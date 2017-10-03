class EncontroSemanalsController < ApplicationController
  before_filter :pegar_celula
  before_filter :pegar_encontro, only: [:receber, :enviar]
  before_action :set_encontro_semanal, only: [:show, :edit, :update, :destroy]
  
  load_and_authorize_resource :class=>"EncontroSemanal", except: :create

  # GET /encontro_semanals
  # GET /encontro_semanals.json
  def index
    @celula.encontro_semanals.all
  end

  # GET /encontro_semanals/1
  # GET /encontro_semanals/1.json
  def show
  end

  # GET /encontro_semanals/new
  def new

    if @celula.lideres_da_celula_ids.include?current_user.pessoa.id or current_user.e_secretaria
      @encontro_semanal = @celula.encontro_semanals.build
    else
      flash[:error] = "Você não é lider desta célula."
      redirect_to celula_encontro_semanals_path(@celula)
    end
    
  end

  # GET /encontro_semanals/1/edit
  def edit
  end

  # POST /encontro_semanals
  # POST /encontro_semanals.json
  def create
    @encontro_semanal = @celula.encontro_semanals.new(encontro_semanal_params)
    respond_to do |format|
      if @encontro_semanal.save
        format.html { redirect_to celula_encontro_semanal_path(@celula, @encontro_semanal), notice: @@msgs }
        format.json { render :show, status: :created, location: @encontro_semanal }
      else
        flash[:danger] = @@msge
        format.html { render :new }
        format.json { render json: @encontro_semanal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /encontro_semanals/1
  # PATCH/PUT /encontro_semanals/1.json
  def update
    respond_to do |format|
      if @encontro_semanal.update(encontro_semanal_params)
        format.html { redirect_to celula_encontro_semanal_path(@celula, @encontro_semanal), notice: @@msgs }
        format.json { render :show, status: :ok, location: @encontro_semanal }
      else
        flash[:danger] = @@msge
        format.html { render :edit }
        format.json { render json: @encontro_semanal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /encontro_semanals/1
  # DELETE /encontro_semanals/1.json
  def destroy
    if @encontro_semanal.destroy
      respond_to do |format|
        format.html { redirect_to celula_encontro_semanals_path(@celula), notice: @@msgs }
        format.json { head :no_content }
      end
    else
      flash[:error] = @@msge
      redirect_to celula_encontro_semanals_path(@celula)
    end
  end

  def enviar
    @encontro_semanal.status = "ENVIADO"
    if @encontro_semanal.setar_faltosos(@celula)
      if @encontro_semanal.save!
        flash[:success] = @@msgs
        redirect_to celula_encontro_semanals_path(@celula)
      else
        flash[:danger] = @@msge
        redirect_to celula_encontro_semanals_path(@celula)
      end
    else
      flash[:error] = @@msge
      redirect_to celula_encontro_semanals_path(@celula)
    end
  end

  def receber
    @encontro_semanal.status = "RECEBIDO"
    if @encontro_semanal.save
      flash[:success] = @@msgs
      redirect_to celula_encontro_semanal_path(@celula, @encontro_semanal)
    else
      flash[:danger] = @@msge
      redirect_to celula_encontro_semanals_path(@celula)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_encontro_semanal
      @encontro_semanal = @celula.encontro_semanals.accessible_by(current_ability).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def encontro_semanal_params
      params.require(:encontro_semanal).permit(:data, :houve_celula, :celula_id, :status, :numero_visitantes, :nome_visitantes,
                                               :numero_criancas, :numero_decisoes, :numero_reconciliacoes,
                                               :ministrante, :palavra, :ofertas, :dizimos, membro_ids: [])
    end

    def pegar_celula
      @celula = Celula.find(params[:celula_id])
    end

    def pegar_encontro
      @encontro_semanal = @celula.encontro_semanals.find(params[:encontro_semanal_id])
    end
end
