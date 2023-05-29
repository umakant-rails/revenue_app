class KhasrasController < ApplicationController
  before_action :set_khasra, only: %i[ show edit update destroy ]

  # GET /khasras or /khasras.json
  def index
    @khasras = Khasra.all
  end

  # GET /khasras/1 or /khasras/1.json
  def show
  end

  # GET /khasras/new
  def new
    @khasra = Khasra.new
  end

  # GET /khasras/1/edit
  def edit
  end

  # POST /khasras or /khasras.json
  def create
    @khasra = Khasra.new(khasra_params)

    respond_to do |format|
      if @khasra.save
        format.html { redirect_to khasra_url(@khasra), notice: "Khasra was successfully created." }
        format.json { render :show, status: :created, location: @khasra }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @khasra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /khasras/1 or /khasras/1.json
  def update
    respond_to do |format|
      if @khasra.update(khasra_params)
        format.html { redirect_to khasra_url(@khasra), notice: "Khasra was successfully updated." }
        format.json { render :show, status: :ok, location: @khasra }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @khasra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /khasras/1 or /khasras/1.json
  def destroy
    @khasra.destroy

    respond_to do |format|
      format.html { redirect_to khasras_url, notice: "Khasra was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_khasra
      @khasra = Khasra.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def khasra_params
      params.fetch(:khasra, {})
    end
end
