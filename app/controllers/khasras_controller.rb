class KhasrasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request 
  before_action :set_khasra, only: %i[ show edit update destroy ]

  # GET /khasras or /khasras.json
  def index
    @khasras = Khasra.all
  end

  # GET /khasras/1 or /khasras/1.json
  def show
  end

  # GET /khasras/new
  def new
    if @request.participants.blank?
      flash[:error] = "please add participants first."
      redirect_to new_request_participant_path(@request)
    else
      village = @request.khasras.blank? ? @request.village : @request.khasras.last.village
      @khasra = Khasra.new(village_id: village.id)
    end

    if @request.payment_transaction.present?
      respond_to do |format|
        flash[:error] = "इस आवेदन का भुगतान कर दिया गया है, अब इसकी जानकारी में कोई परिवर्तन नहीं किया जा सकता है |" 
        format.html { redirect_back_or_to requests_path } 
      end
    end

  end

  # GET /khasras/1/edit
  def edit
  end

  # POST /khasras or /khasras.json
  def create
    inserted_khasra = @request.khasras.where("sold_rakba is not null").present?
    khasra_tmp = @request.khasras.where(khasra: params[:khasra][:khasra], village_id: params[:khasra][:village_id])
    @khasra = @request.khasras.new(khasra_params)

    total_rakba = @khasra.rakba.to_f*10000
    if @khasra.unit == 'व.फु.'
      sold_rakba =  (@khasra.sold_rakba.to_f / 10.7639).round
    elsif @khasra.unit == 'व.मी.'
      sold_rakba =  (@khasra.sold_rakba.to_f).round
    elsif @khasra.unit ==  'हे.'
      sold_rakba =  @khasra.sold_rakba.to_f * 10000;
    elsif inserted_khasra.present? && @khasra.sold_rakba.blank?
      sold_rakba = 0.0
    end

    respond_to do |format|
      if khasra_tmp.present?
        flash[:error] =  "यह खसरा पहले ही जोड़ा जा चुका है |"
        format.html { render :new, status: :unprocessable_entity }
      elsif @khasra.sold_rakba.present? && @khasra.unit.blank?
        flash[:error] =  "अगर आपने विक्रय रकबा भरा है तो बिक्रय रकबा की इकाई चुनना आवश्यक है |"
        format.html { render :new, status: :unprocessable_entity }
      elsif @request.request_type.name != "बटवारा" && inserted_khasra.blank? && @khasra.sold_rakba.blank?
        flash[:error] =  "खसरा में क्रय/विक्रय किया गया रकबा भरना अनिवार्य है |"
        format.html { render :new, status: :unprocessable_entity }
      elsif sold_rakba > total_rakba
        flash[:error] =  "विक्रय रकबा, खसरे के रकबे से ज्यादा नहीं हो सकता है |"
        format.html { render :new, status: :unprocessable_entity }
      elsif @khasra.save
        format.html { redirect_to new_request_khasra_url, notice: "Khasra was successfully created." }
        format.json { render :show, status: :created, location: @khasra }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @khasra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /khasras/1 or /khasras/1.json
  def update
    respond_to do |format|
      if @khasra.update(khasra_params)
        format.html { redirect_to new_request_khasra_url, notice: "Khasra was successfully updated." }
        format.json { render :show, status: :ok, location: @khasra }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @khasra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /khasras/1 or /khasras/1.json
  def destroy
    @khasra.destroy

    respond_to do |format|
      format.html { redirect_to new_request_khasra_url(@request), notice: "Khasra was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_khasra
      @khasra = Khasra.find(params[:id])
    end

    def set_request
      @request = Request.find(params[:request_id])
    end
    
    # Only allow a list of trusted parameters through.
    def khasra_params
      params.fetch(:khasra).permit(:khasra, :rakba, :sold_rakba, :unit, :request_id, :village_id)
    end
end
