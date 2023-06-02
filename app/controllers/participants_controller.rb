class ParticipantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request
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
    @participant_types  = ParticipantType.get_participants(@request)

    if @request.participants.blank? || params[:depth] == '0'
      @participant = @request.participants.new(depth: 0, is_dead: true, participant_type_id: 5)
    else
      @participant = @request.participants.new(participant_type_id: 6)
    end

    @request = Request.find(params[:request_id])
    @balees = @request.participants.where("balee is not null").pluck(:balee).uniq

    if @request.payment_transaction.present?
      respond_to do |format|
        flash[:error] = "इस आवेदन का भुगतान कर दिया गया है, अब इसकी जानकारी में कोई परिवर्तन नहीं किया जा सकता है |" 
        format.html { redirect_back_or_to requests_path } 
      end
    end
  end

  # GET /participants/1/edit
  def edit
    @participant_types  = ParticipantType.get_participants(@request)
  end

  # POST /participants or /participants.json
  def create
    @participant_types  = ParticipantType.get_participants(@request)
    @request = Request.find(params[:request_id])
    @balees = @request.participants.where("balee is not null").pluck(:balee).uniq

    if params[:participant][:parent_id].present?
      @parent = Participant.find(params[:participant][:parent_id])
      params[:participant][:depth] = @parent.depth+1
    end

    @participant = @request.participants.new(participant_params)

    respond_to do |format|
      if @participant.save
        format.html { redirect_to new_request_participant_url(@request), notice: "Participant was successfully created." }
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
      format.html { redirect_to participants_url, notice: "Participant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
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
        :participant_type_id, :total_share_sold)
    end
end
