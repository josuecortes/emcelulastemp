class CelulasController < ApplicationController

  before_action :set_celula, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource :class=>"Celula", except: :create

  # GET /celulas
  # GET /celulas.json
  def index
    @celulas = Celula.accessible_by(current_ability)
  end

  # GET /celulas/1
  # GET /celulas/1.json
  def show
  end

  # GET /celulas/new
  def new
    @celula = Celula.new
  end

  # GET /celulas/1/edit
  def edit
  end

  # POST /celulas
  # POST /celulas.json
  def create
    @celula = Celula.new(celula_params)

    respond_to do |format|
      if @celula.save
        format.html { redirect_to @celula, notice: @@msgs }
        format.json { render :show, status: :created, location: @celula }
      else
        flash[:danger] = @@msge
        format.html { render :new }
        format.json { render json: @celula.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /celulas/1
  # PATCH/PUT /celulas/1.json
  def update
    respond_to do |format|
      if @celula.update(celula_params)
        format.html { redirect_to @celula, notice: @@msgs }
        format.json { render :show, status: :ok, location: @celula }
      else
        flash[:danger] = @@msge
        format.html { render :edit }
        format.json { render json: @celula.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /celulas/1
  # DELETE /celulas/1.json
  def destroy #  -----------------------------------> DESATIVAR / ATIVAR
    if @celula.ativo == true
      @celula.ativo = false
    else
      @celula.ativo = true
    end
    if @celula.save!
      flash[:success] = @@msgs
    else
      flash[:dager] = @@msge
    end

    redirect_to celulas_url
  end

  def gerenciar 
    @celula = Celula.accessible_by(current_ability).find(params[:celula_id])
  end

  def adicionar_membro
    @celula = Celula.accessible_by(current_ability).find(params[:celula_id])
    @pessoas = Pessoa.accessible_by(current_ability).pessoas_sem_celula
  end

  def salvar_membro
    @celula = Celula.accessible_by(current_ability).find(params[:celula_id])
    @pessoa = Pessoa.accessible_by(current_ability).find(params[:pessoa_id])

    if @pessoa.adicionar_membro_na_celula(@celula)
      flash[:success] = @@msgs
      redirect_to celula_gerenciar_url(@celula)
    else
      flash[:danger] = @@msge
      redirect_to  celula_adicionar_membro_url(@celula)
    end
  end

  def remover_membro
    @celula = Celula.accessible_by(current_ability).find(params[:celula_id])
    @pessoa = Pessoa.accessible_by(current_ability).find(params[:pessoa_id])

    if @pessoa.remover_membro_da_celula(@celula)
      flash[:success] = @@msgs
      redirect_to celula_gerenciar_url(@celula)
    else
      flash[:danger] = @@msge
      redirect_to  celula_adicionar_membro_url(@celula)
    end
  end
  #########################################################

  def salvar_lider_em_treinamento
    @celula = Celula.accessible_by(current_ability).find(params[:celula_id])
    @pessoa = Pessoa.accessible_by(current_ability).find(params[:pessoa_id])

    if @pessoa.adicionar_lider_em_treinamento_na_celula(@celula)
      flash[:success] = @@msgs
      redirect_to celula_gerenciar_url(@celula)
    else
      flash[:danger] = @@msge
      redirect_to  celula_gerenciar_url(@celula)
    end
  end

  def remover_lider_em_treinamento
    @celula = Celula.accessible_by(current_ability).find(params[:celula_id])
    @pessoa = Pessoa.accessible_by(current_ability).find(params[:pessoa_id])

    if @pessoa.remover_lider_em_treinamento_da_celula(@celula)
      flash[:success] = @@msgs
      redirect_to celula_gerenciar_url(@celula)
    else
      flash[:danger] = @@msge
      redirect_to  celula_adicionar_membro_url(@celula)
    end
  end

  #########################################################
  def adicionar_lider
    @celula = Celula.accessible_by(current_ability).find(params[:celula_id])
    @pessoas = Pessoa.accessible_by(current_ability).nao_e_lider_desta_celula(@celula)
  end

  def salvar_lider
    @celula = Celula.accessible_by(current_ability).find(params[:celula_id])
    @pessoa = Pessoa.accessible_by(current_ability).find(params[:pessoa_id])

    if @pessoa.adicionar_lider_na_celula(@celula)
      flash[:success] = @@msgs
      redirect_to celula_gerenciar_url(@celula)
    else
      flash[:danger] = @@msge
      redirect_to  celula_adicionar_lider_url(@celula)
    end
  end

  def remover_lider
    @celula = Celula.accessible_by(current_ability).find(params[:celula_id])
    @pessoa = Pessoa.accessible_by(current_ability).find(params[:pessoa_id])

    #@pessoa.celula_que_e_membro = nil
    if @pessoa.remover_lider_da_celula(@celula)
      flash[:success] = @@msgs
      redirect_to celula_gerenciar_url(@celula)
    else
      flash[:danger] = @@msge
      redirect_to  celula_adicionar_lider_url(@celula)
    end
  end
  ###################################

  def adicionar_supervisor
    @celula = Celula.accessible_by(current_ability).find(params[:celula_id])
    @pessoas = Pessoa.accessible_by(current_ability).nao_e_supervisor_desta_celula(@celula)
  end

  def salvar_supervisor
    @celula = Celula.accessible_by(current_ability).find(params[:celula_id])
    @pessoa = Pessoa.accessible_by(current_ability).find(params[:pessoa_id])

    if @pessoa.adicionar_supervisor_na_celula(@celula)
      flash[:success] = @@msgs
      redirect_to celula_gerenciar_url(@celula)
    else
      flash[:danger] = @@msge
      redirect_to  celula_adicionar_supervisor_url(@celula)
    end
  end

  def remover_supervisor
    @celula = Celula.accessible_by(current_ability).find(params[:celula_id])
    @pessoa = Pessoa.accessible_by(current_ability).find(params[:pessoa_id])

    #@pessoa.celula_que_e_membro = nil
    if @pessoa.remover_supervisor_da_celula(@celula)
      flash[:success] = @@msgs
      redirect_to celula_gerenciar_url(@celula)
    else
      flash[:danger] = @@msge
      redirect_to  celula_adicionar_supervisor_url(@celula)
    end
  end
  ##################################

  def adicionar_cordenador
    @celula = Celula.accessible_by(current_ability).find(params[:celula_id])
    @pessoas = Pessoa.accessible_by(current_ability).nao_e_cordenador_desta_celula(@celula)
  end

  def salvar_cordenador
    @celula = Celula.accessible_by(current_ability).find(params[:celula_id])
    @pessoa = Pessoa.accessible_by(current_ability).find(params[:pessoa_id])

    if @pessoa.adicionar_cordenador_na_celula(@celula)
      flash[:success] = @@msgs
      redirect_to celula_gerenciar_url(@celula)
    else
      flash[:danger] = @@msge
      redirect_to  celula_adicionar_cordenador_url(@celula)
    end
  end

  def remover_cordenador
    @celula = Celula.accessible_by(current_ability).find(params[:celula_id])
    @pessoa = Pessoa.accessible_by(current_ability).find(params[:pessoa_id])

    #@pessoa.celula_que_e_membro = nil
    if @pessoa.remover_cordenador_da_celula(@celula)
      flash[:success] = @@msgs
      redirect_to celula_gerenciar_url(@celula)
    else
      flash[:danger] = @@msge
      redirect_to  celula_adicionar_cordenador_url(@celula)
    end
  end


  def relatorios 
    @celula = Celula.accessible_by(current_ability).find(params[:celula_id])
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_celula
      @celula = Celula.accessible_by(current_ability).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def celula_params
      params.require(:celula).permit(:nome, :data_criacao, :logradouro, :numero, :bairro, :cidade, :estado, 
                                     :cep, :dia, :hora, :minutos, :ativo, :igreja_id, supervisores_da_celula_ids: [])
    end
end
