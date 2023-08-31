class BlankFormsController < ApplicationController
  before_action :set_blank_form, only: %i[ show_blank_form ]

  def get_departments
    @departments = Department.all
  end

  # GET /blank_forms or /blank_forms.json
  def index
    # @districts = Village.all.pluck(:district).uniq
    @departments = Department.all
    # @department = Department.where(eng_name: params[:department])[0]
    # @blank_forms = @department.present? ? @department.blank_forms.order("group_name")  : []
  end

  def department
    @department = Department.where(eng_name: params[:department])[0]
    @form_groups = @department.present? ? @department.blank_forms.pluck("section_hindi").uniq : []
    if @form_groups.length == 1
      redirect_to section_blank_forms_path(params[:department], @form_groups[0])
    end
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

  def show_blank_form
    @districts = Village.all.pluck(:district).uniq
    if @blank_form.present? 
      @blank_forms = BlankForm.where(section_hindi: @blank_form.section_hindi)
    else
      @blank_forms = BlankForm.where(section_hindi: params[:section])
      @blank_form = @blank_forms[0]
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blank_form
      @blank_form = BlankForm.find(params[:id]) rescue nil
    end

    # Only allow a list of trusted parameters through.
    def blank_form_params
      params.require(:blank_form).permit(:name, :category, :department, :content)
    end
end
