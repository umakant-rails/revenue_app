class BlankFormsController < ApplicationController
  before_action :set_blank_form, only: %i[ show edit update destroy ]

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

  # GET /blank_forms/1 or /blank_forms/1.json
  def show
    @districts = Village.all.pluck(:district).uniq
    if @blank_form.present? 
      @blank_forms = BlankForm.where(section_hindi: @blank_form.section_hindi)
    else
      @blank_forms = BlankForm.where(section_hindi: params[:section])
      @blank_form = @blank_forms[0]
    end

  end

  # GET /blank_forms/new
  def new
    @blank_form = BlankForm.new
  end

  # GET /blank_forms/1/edit
  def edit
  end

  # POST /blank_forms or /blank_forms.json
  def create
    @blank_form = BlankForm.new(blank_form_params)

    respond_to do |format|
      if @blank_form.save
        format.html { redirect_to blank_form_url(@blank_form), notice: "Blank form was successfully created." }
        format.json { render :show, status: :created, location: @blank_form }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blank_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blank_forms/1 or /blank_forms/1.json
  def update
    respond_to do |format|
      if @blank_form.update(blank_form_params)
        format.html { redirect_to blank_form_url(@blank_form), notice: "Blank form was successfully updated." }
        format.json { render :show, status: :ok, location: @blank_form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blank_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blank_forms/1 or /blank_forms/1.json
  def destroy
    @blank_form.destroy

    respond_to do |format|
      format.html { redirect_to blank_forms_url, notice: "Blank form was successfully destroyed." }
      format.json { head :no_content }
    end
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
