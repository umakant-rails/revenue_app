class Admin::FormTemplatesController < ApplicationController
  before_action :set_admin_form_template, only: %i[ show edit update destroy ]

  # GET /admin/form_templates or /admin/form_templates.json
  def index
    @admin_form_templates = Admin::FormTemplate.all
  end

  # GET /admin/form_templates/1 or /admin/form_templates/1.json
  def show
  end

  # GET /admin/form_templates/new
  def new
    @form_template = FormTemplate.new
  end

  # GET /admin/form_templates/1/edit
  def edit
  end

  # POST /admin/form_templates or /admin/form_templates.json
  def create
    @admin_form_template = Admin::FormTemplate.new(admin_form_template_params)

    respond_to do |format|
      if @admin_form_template.save
        format.html { redirect_to admin_form_template_url(@admin_form_template), notice: "Form template was successfully created." }
        format.json { render :show, status: :created, location: @admin_form_template }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_form_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/form_templates/1 or /admin/form_templates/1.json
  def update
    respond_to do |format|
      if @admin_form_template.update(admin_form_template_params)
        format.html { redirect_to admin_form_template_url(@admin_form_template), notice: "Form template was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_form_template }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_form_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/form_templates/1 or /admin/form_templates/1.json
  def destroy
    @admin_form_template.destroy

    respond_to do |format|
      format.html { redirect_to admin_form_templates_url, notice: "Form template was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_form_template
      @admin_form_template = Admin::FormTemplate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_form_template_params
      params.fetch(:admin_form_template, {})
    end
end
