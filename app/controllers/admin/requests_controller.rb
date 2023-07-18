class Admin::RequestsController < ApplicationController
  before_action :set_admin_request, only: %i[ show edit update destroy ]

  # GET /admin/requests or /admin/requests.json
  def index
    @requests = Request.all.page(params[:page])
  end

  # GET /admin/requests/1 or /admin/requests/1.json
  def show
  end

  # GET /admin/requests/new
  def new
    @request = Request.new
  end

  # GET /admin/requests/1/edit
  def edit
  end

  # POST /admin/requests or /admin/requests.json
  def create
    @request = Request.new(admin_request_params)

    respond_to do |format|
      if @request.save
        format.html { redirect_to admin_request_url(@request), notice: "Request was successfully created." }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/requests/1 or /admin/requests/1.json
  def update
    respond_to do |format|
      if @request.update(admin_request_params)
        format.html { redirect_to admin_request_url(@request), notice: "Request was successfully updated." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/requests/1 or /admin/requests/1.json
  def destroy
    @request.destroy

    respond_to do |format|
      format.html { redirect_to admin_requests_url, notice: "Request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_request
      @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_request_params
      params.fetch(:admin_request, {})
    end
end
