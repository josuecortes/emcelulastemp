class TipoCelulasController < ApplicationController
  before_action :set_tipo_celula, only: [:show, :edit, :update, :destroy]

  # GET /tipo_celulas
  # GET /tipo_celulas.json
  def index
    @tipo_celulas = TipoCelula.all
  end

  # GET /tipo_celulas/1
  # GET /tipo_celulas/1.json
  def show
  end

  # GET /tipo_celulas/new
  def new
    @tipo_celula = TipoCelula.new
  end

  # GET /tipo_celulas/1/edit
  def edit
  end

  # POST /tipo_celulas
  # POST /tipo_celulas.json
  def create
    @tipo_celula = TipoCelula.new(tipo_celula_params)

    respond_to do |format|
      if @tipo_celula.save
        format.html { redirect_to @tipo_celula, notice: 'Tipo celula was successfully created.' }
        format.json { render :show, status: :created, location: @tipo_celula }
      else
        format.html { render :new }
        format.json { render json: @tipo_celula.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_celulas/1
  # PATCH/PUT /tipo_celulas/1.json
  def update
    respond_to do |format|
      if @tipo_celula.update(tipo_celula_params)
        format.html { redirect_to @tipo_celula, notice: 'Tipo celula was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipo_celula }
      else
        format.html { render :edit }
        format.json { render json: @tipo_celula.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_celulas/1
  # DELETE /tipo_celulas/1.json
  def destroy
    @tipo_celula.destroy
    respond_to do |format|
      format.html { redirect_to tipo_celulas_url, notice: 'Tipo celula was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_celula
      @tipo_celula = TipoCelula.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_celula_params
      params[:tipo_celula]
    end
end
