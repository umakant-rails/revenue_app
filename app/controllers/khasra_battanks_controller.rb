class KhasraBattanksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request
  # after_action :set_required_data, only: %[ crate add_participants remove_participant]
  before_action :set_khasra_battank, only: %i[ show edit update destroy ]

  # GET /khasra_battanks or /khasra_battanks.json
  def index
    @khasra_battanks = KhasraBattank.all
  end

  # GET /khasra_battanks/1 or /khasra_battanks/1.json
  def show
  end

  # GET /khasra_battanks/new
  def new
    set_required_data
    respond_to do |format|
      if @hissedars.blank? || @land_owners.blank?
        flash[:error] = "इस बंटवारे में मूल भूस्वामी अथवा सह-भागीदार दर्ज नहीं किये है, कृपया इनको दर्ज करे |"
        format.html { redirect_to new_request_participant_path(@request) }
      elsif @khasras.blank?
        flash[:error] = "इस बंटवारे में अभी तक खसरा नंबर दर्ज नहीं किये है, कृपया इनको दर्ज करे |"
        format.html { redirect_to new_request_khasra_path(@request) }
      else
        format.html {}
      end
    end

  end

  # GET /khasra_battanks/1/edit
  def edit
  end

  # POST /khasra_battanks or /khasra_battanks.json
  def create
    is_true = false

    keys = params[:khasra_battank_attributes].keys rescue nil
    if keys.present?
      is_true = @request.khasra_battanks.create(params[:khasra_battank_attributes].values)
    else
      @khasra_battank = @request.khasra_battanks.new(khasra_battank_params)
      is_true = @khasra_battank.save
    end

    respond_to do |format|
      if is_true
        set_required_data
        flash[:notice] = "Khasra battank was successfully created."
        format.html { redirect_to new_request_khasra_battank_url(@request)}
        format.js
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @khasra_battank.errors, status: :unprocessable_entity }
        format.js {render json: @khasra_battank.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /khasra_battanks/1 or /khasra_battanks/1.json
  def update
    respond_to do |format|
      if @khasra_battank.update(khasra_battank_params)
        format.html { redirect_to khasra_battank_url(@khasra_battank), notice: "Khasra battank was successfully updated." }
        format.json { render :show, status: :ok, location: @khasra_battank }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @khasra_battank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /khasra_battanks/1 or /khasra_battanks/1.json
  def destroy

    p_khasra = @khasra_battank.khasra
    p_khasra.khasra_battanks.destroy_all

    respond_to do |format|
      format.html { redirect_to new_request_khasra_battank_path(@request), notice: "Khasra battank was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_participants
    khasra_battank_ids = params[:khasra_battank][:khasra_ids]
    participant_ids = params[:khasra_battank][:hissedar_ids].join(",")
    @khasra_battanks = KhasraBattank.where("id in (?)", khasra_battank_ids)

    respond_to do |format|
      if @khasra_battanks.update_all(group_id: Time.now.to_i, participant_ids: participant_ids)
        set_required_data
        format.html { redirect_to new_request_khasra_battank_path(@request), notice: "Khasra battank was successfully destroyed." }
        format.js
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.js { render json: @khasra_battank.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_participant
    khasra_battank = @request.khasra_battanks.where(id: params[:id]).first rescue nil
    
    respond_to do |format|
      if KhasraBattank.where("group_id =?",khasra_battank.group_id).update(group_id: nil, participant_ids: nil)
        set_required_data

        format.html { redirect_to new_request_khasra_battank_path(@request), notice: "Khasra battank was successfully destroyed." }
        format.js
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.js { render json: @khasra_battank.errors, status: :unprocessable_entity }
      end
    end

  end

  private 
    def set_required_data
      @khasra_battank = KhasraBattank.new
      @hissedars = @request.participants.hissedar rescue nil
      @land_owners = @request.participants.land_owner rescue nil
      @khasras = @request.khasras rescue nil
      @new_khasra_battanks = @request.khasra_battanks.where("group_id is null") rescue nil
    end

    def set_request
      @request = Request.find(params[:request_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_khasra_battank
      @khasra_battank = KhasraBattank.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def khasra_battank_params
      params.fetch(:khasra_battank).permit(:khasra_id, :new_khasra, :rakba, :request_id, :participant_ids, :group_id)
    end
end
