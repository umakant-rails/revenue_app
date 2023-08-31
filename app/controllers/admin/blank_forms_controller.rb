class Admin::BlankFormsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blank_form, only: %i[ show edit update destroy ]

  def index
    @departments = Department.all
    @blank_forms = BlankForm.all.page(params[:page]).per(10)
  end

  def new
    @departments = Department.all
    @blank_form = BlankForm.new
  end

  def create
    set_section_params
    @blank_form = BlankForm.new(blank_form_params)

    respond_to do |format|
      if @blank_form.save
        format.html { redirect_to admin_blank_form_path(@blank_form), notice: "Blank Form was successfully updated." }
        format.json { render :show, status: :ok, location: @blank_form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blank_form.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
    @departments = Department.all
    @sections = @blank_form.department.blank_forms.pluck(:section_eng).uniq
  end

  def update
    set_section_params
    respond_to do |format|
      if @blank_form.update(blank_form_params)
        format.html { redirect_to admin_blank_form_path(@blank_form), notice: "Blank Form was successfully updated." }
        format.json { render :show, status: :ok, location: @blank_form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blank_form.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blank_form.destroy

    respond_to do |format|
      format.html { redirect_to admin_blank_forms_path, notice: "Balnk Form was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def get_sections
    @blank_form = params[:form_id].present? ? BlankForm.find(params[:form_id]) : nil
    @sections = BlankForm.where(department_id: params[:department_id]).pluck(:section_eng).uniq
  end

  private

  def set_section_params
    @departments = Department.all
    section = BlankForm.where(section_eng: params[:blank_form][:section_name]).first
    if params[:blank_form][:section_name].present? && section.present?
      params[:blank_form][:section_eng] = section.section_eng
      params[:blank_form][:section_hindi] = section.section_hindi
    end
  end

  def set_blank_form
    @blank_form = BlankForm.find(params[:id])
  end

  def blank_form_params
    params.require(:blank_form).permit(:department_id, :eng_name, :hindi_name, :section_eng, :section_hindi, :category, :content)
  end

end
