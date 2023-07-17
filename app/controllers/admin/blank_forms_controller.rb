class Admin::BlankFormsController < ApplicationController
  before_action :set_admin_blank_form, only: %i[ show edit update destroy ]

  # GET /admin/blank_forms or /admin/blank_forms.json
  def index
    @admin_blank_forms = Admin::BlankForm.all
  end

  # GET /admin/blank_forms/1 or /admin/blank_forms/1.json
  def show
  end

  # GET /admin/blank_forms/new
  def new
    @admin_blank_form = Admin::BlankForm.new
  end

  # GET /admin/blank_forms/1/edit
  def edit
  end

  # POST /admin/blank_forms or /admin/blank_forms.json
  def create
    @admin_blank_form = Admin::BlankForm.new(admin_blank_form_params)

    respond_to do |format|
      if @admin_blank_form.save
        format.html { redirect_to admin_blank_form_url(@admin_blank_form), notice: "Blank form was successfully created." }
        format.json { render :show, status: :created, location: @admin_blank_form }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_blank_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/blank_forms/1 or /admin/blank_forms/1.json
  def update
    respond_to do |format|
      if @admin_blank_form.update(admin_blank_form_params)
        format.html { redirect_to admin_blank_form_url(@admin_blank_form), notice: "Blank form was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_blank_form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_blank_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/blank_forms/1 or /admin/blank_forms/1.json
  def destroy
    @admin_blank_form.destroy

    respond_to do |format|
      format.html { redirect_to admin_blank_forms_url, notice: "Blank form was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_blank_form
      @admin_blank_form = Admin::BlankForm.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_blank_form_params
      params.fetch(:admin_blank_form, {})
    end
end
