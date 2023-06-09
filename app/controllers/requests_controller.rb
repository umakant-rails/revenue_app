class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, only: %i[ show edit update destroy ]

  # GET /requests or /requests.json
  def index
    @requests = current_user.requests.joins([:participants, :khasras]).order("created_At DESC").distinct.page(params[:page])
  end

  # GET /requests/1 or /requests/1.json
  def show
    applicant = @request.participants.find_by_is_applicant(true)

    respond_to do |format|
      if applicant.blank?
        if @request.request_type.name = "फौती"
          flash[:error] = "कृपया पहले किसी वारसान को आवेदक बनाये, अभी इस आवेदन में कोई भी आवेदक नहीं है |"
        elsif @request.request_type.name == "नामांतरण" 
          flash[:erorr] = "कृपया पहले किसी क्रेता को आवेदक बनाये, अभी इस आवेदन में कोई भी आवेदक नहीं है |"
        end
        format.html { redirect_to new_request_participant_path(@request) } 
      else
        format.html{}
      end
    end
  end

  # GET /requests/new
  def new
    @districts = Village.all.pluck(:district).uniq
    year = Request.current_revenue_year
    @request_types = RequestType.all

    if params[:request_id].blank?
      @request = Request.new(year:year)
    else
      @request = Request.find(params[:request_id])
      if @request.participants.blank? || params[:op_type] = "participant"
        @varsan = @request.participants.where("karanda_aam_faut is true");
        @participants = @request.participants.where("name is not null")
        @participant = @request.participants.new
      elsif params[:op_type] = "khasra"
        @khasras = @request.khasras
        @khasra = @request.khasras.new
      end
    end
  end

  # GET /requests/1/edit
  def edit
    @districts = Village.all.pluck(:district).uniq
    r_village = @request.village
    village_list = Village.where(district: r_village.district)

    @tehsils = village_list.pluck(:tehsil).uniq
    @circles = village_list.where(tehsil: r_village.tehsil).pluck(:ri).uniq
    @villages = village_list.where(ri: r_village.ri)
    @request_types = RequestType.all

    if @request.payment_transaction.present?
      respond_to do |format|
        flash[:error] = "इस आवेदन का भुगतान कर दिया गया है, अब इसकी जानकारी में कोई परिवर्तन नहीं किया जा सकता है |" 
        format.html { redirect_back_or_to requests_path } 
      end
    end
  end

  # POST /requests or /requests.json
  def create
    @districts = Village.all.pluck(:district).uniq
    @request = current_user.requests.new(request_params)

    respond_to do |format|
      if (@request.request_type.name == "नामांतरण") && 
      (params[:request][:registry_number].blank? || params[:request][:registry_date].blank?)
        flash[:error] =  "नामांतरण के लिए रजिस्ट्री की नंबर एवं रजिस्ट्री दिनांक आवश्यक है |"
        format.html { render :new, status: :unprocessable_entity }
      elsif @request.save
        format.html { redirect_to new_request_participant_path(@request), notice: "Request was successfully created." }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1 or /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to new_request_participant_path(@request), notice: "Request was successfully updated." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1 or /requests/1.json
  def destroy
    @request.destroy

    respond_to do |format|
      format.html { redirect_to requests_url, notice: "Request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def pending
    @requests = Request.left_joins([:participants, :khasras]).where("participants.request_id is null or khasras.request_id is null").uniq
  end

  def get_records
    if params[:selected_field] == "district"
      @records = Village.where(district: params[:selected_value]).pluck(:tehsil).uniq
    elsif params[:selected_field] == "tehsil"
      @records = Village.where(tehsil: params[:selected_value]).pluck(:ri).uniq
    elsif params[:selected_field] == "circle"
      @records = Village.where(ri: params[:selected_value])
    end
  end

  def export
    @request = Request.find(params[:id])
    set_template_classes
    respond_to do |format|
      format.html{}
      format.pdf do
        render pdf: @request.applicant_name,
          template: "requests/export",
          layout: "pdf_layout",
          margin: {top: 10, bottom: 10, left: 8, right: 8},
          title:  @request.applicant_name,
          background: true,
          show_as_html: false,
          page_size: "A4",
          encoding:"UTF-8",
          print_media_type: true
      end
    end
  end

  def payment_page
    @request = current_user.requests.find(params[:id])
    render layout: 'payment_layout'
  end

  def make_payment
    @request = current_user.requests.find(params[:id])
    last_transaction = current_user.payment_transactions.last
    remian_amt = last_transaction.amount - params[:payment_amount].to_i
    
    @transaction = PaymentTransaction.new(
      transactionable: @request, user_id: current_user.id, 
      amount:remian_amt, debit:params[:payment_amount]
    )

    respond_to do |format|
      if @transaction.save
        @request.update(payment_done: true)
        # format.html { redirect_to request_url(@request), notice: "सेवा का भुगतान सफलतापूर्वक कर दिया गया है |" }
        format.json { head :no_content }
      end
    end

  end

  private
    def set_template_classes
      @templates = {}
      template_arr = ['ordersheet1', 'ordersheet2','applicant_application', 
        'non_applicant_application', 'applicant_affidavit', 'non_applicant_affidavit', 
        'ishtihar', 'kathan', 'talwana', 'panchnama', 'patwari_prativedan']
      order_sanjara_arr = ['order_praroop', 'sanjara_praroop']

      template_arr.each do | key | 
        @templates[key.to_sym] = params.keys.index(key).present? ? params[key] : 'pdf-paragraph-40'
      end
      order_sanjara_arr.each do | key |
        @templates[key.to_sym] = params.keys.index(key).present? ? params[key] : 'p1'
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:title, :request_type_id, :year, :village_id, :registry_number, :registry_date)
    end
end
