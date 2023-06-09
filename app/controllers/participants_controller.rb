class ParticipantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request
  before_action :set_required_data, only: %i[new edit create update]
  before_action :set_participant, only: %i[ show edit update destroy ]

  # GET /participants or /participants.json
  def index
    @participants = Participant.all
  end

  # GET /participants/1 or /participants/1.json
  def show
  end

  # GET /participants/new
  def new
    if @request.request_type.name == "फौती" && (@request.participants.blank? || params[:is_dead])
      @participant = @request.participants.new(depth: 0, is_dead: true, participant_type_id: 4)
    elsif @request.request_type.name == "फौती"
      @participant = @request.participants.new(participant_type_id: 5)
    else 
      @participant = @request.participants.new
    end

    if @request.payment_transaction.present?
      respond_to do |format|
        flash[:error] = "इस आवेदन का भुगतान कर दिया गया है, अब इसकी जानकारी में कोई परिवर्तन नहीं किया जा सकता है |" 
        format.html { redirect_back_or_to requests_path } 
      end
    end
  end

  # GET /participants/1/edit
  def edit
  end

  # POST /participants or /participants.json
  def create
    is_true = @request.request_type.name == "फौती" ? validate_fouti_request : false

    if @request.participants.buyers.blank? && params[:participant][:participant_type_id] == '1'
      params[:participant][:is_applicant] = true
    elsif @request.participants.applicant.present? && params[:participant][:participant_type_id] == '1' &&
      params[:participant][:is_applicant] == 'true'
      @request.participants.applicant.update(is_applicant: false)
    end

    @participant = @request.participants.new(participant_params)

    respond_to do |format|
      if is_true
        format.html { render :new, status: :unprocessable_entity }
      elsif @participant.save
        format.html { redirect_to new_request_participant_url, notice: "Participant was successfully created." }
        format.json { render :show, status: :created, location: @participant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participants/1 or /participants/1.json
  def update
    respond_to do |format|
      if @participant.update(participant_params)
        format.html { redirect_to new_request_participant_url(@request), notice: "Participant was successfully updated." }
        format.json { render :show, status: :ok, location: @participant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1 or /participants/1.json
  def destroy
    @participant.destroy

    respond_to do |format|
      format.html { redirect_to new_request_participant_url(@request), notice: "Participant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def get_balees
    @request = Request.find(params[:request_id])
    @balees = @request.participants.where("balee is not null").pluck(:balee).uniq

    respond_to do |format|
      format.html {}
      format.json { head :no_content }
    end
    render layout: false
  end

  private

    def set_required_data
      @participant_types  = ParticipantType.get_participants(@request)
      @balees = @request.participants.where("balee is not null").pluck(:balee).uniq
    end

    def validate_fouti_request
      is_true = false

      if params[:participant][:parent_id].present?
        @parent = Participant.find(params[:participant][:parent_id])
        params[:participant][:depth] = @parent.depth+1
      end

      if params[:participant][:participant_type_id] == "4" && params[:participant][:death_date].blank?
        flash[:error] = "फौत व्यक्ति की फौत दिनांक भरना आवश्यक है |"
        is_true = true
      elsif params[:participant][:participant_type_id] == "5" and (
        params[:participant][:parent_id].blank? or params[:participant][:relation_to_deceased].blank?)
        flash[:error] = "फौत व्यक्ति को चुनना एवं वारसान का मृतक से संबंध भरना अनिवार्य है |"
        is_true = true
      end

      return is_true
    end

    def remove_params_extra_space
      params[:participant].each{|k, v| params[:participant][k] = v.strip }
    end

    def set_request
      @request = Request.find(params[:request_id])
    end

    def set_participant
      @participant = Participant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def participant_params
      params.fetch(:participant).permit(:name, :relation, :gaurdian, :address, :is_dead, :death_date,
        :is_nabalig, :balee, :parent_id, :request_id, :depth, :relation_to_deceased, :is_shareholder,
        :participant_type_id, :total_share_sold, :is_applicant)
    end
end
