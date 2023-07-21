class Admin::FormLayoutsController < ApplicationController
  before_action :set_admin_form_layout, only: %i[ show edit update destroy ]

  # GET /admin/form_layouts or /admin/form_layouts.json
  def index
    @admin_form_layouts = [] #Admin::FormLayout.all
  end

  # GET /admin/form_layouts/1 or /admin/form_layouts/1.json
  def show
  end

  # GET /admin/form_layouts/new
  def new
    #@admin_form_layout = Admin::FormLayout.new
    @order_template = OrderTemplate.new
  end

  # GET /admin/form_layouts/1/edit
  def edit
  end

  # POST /admin/form_layouts or /admin/form_layouts.json
  def create
    @admin_form_layout = Admin::FormLayout.new(admin_form_layout_params)

    respond_to do |format|
      if @admin_form_layout.save
        format.html { redirect_to admin_form_layout_url(@admin_form_layout), notice: "Form layout was successfully created." }
        format.json { render :show, status: :created, location: @admin_form_layout }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_form_layout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/form_layouts/1 or /admin/form_layouts/1.json
  def update
    respond_to do |format|
      if @admin_form_layout.update(admin_form_layout_params)
        format.html { redirect_to admin_form_layout_url(@admin_form_layout), notice: "Form layout was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_form_layout }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_form_layout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/form_layouts/1 or /admin/form_layouts/1.json
  def destroy
    @admin_form_layout.destroy

    respond_to do |format|
      format.html { redirect_to admin_form_layouts_url, notice: "Form layout was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_form_layout
      @admin_form_layout = Admin::FormLayout.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_form_layout_params
      params.fetch(:admin_form_layout, {})
    end
end
