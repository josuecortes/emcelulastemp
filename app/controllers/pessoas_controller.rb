class PessoasController < ApplicationController
  
  before_action :set_pessoa, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource :class=>"Pessoa", except: :create

  # GET /pessoas
  # GET /pessoas.json
  def index
    @pessoas = Pessoa.accessible_by(current_ability)
  end

  # GET /pessoas/1
  # GET /pessoas/1.json
  def show
  end

  # GET /pessoas/new
  def new
    @pessoa = Pessoa.new
  end

  # GET /pessoas/1/edit
  def edit
  end

  # POST /pessoas
  # POST /pessoas.json
  def create
    @pessoa = Pessoa.new(pessoa_params)

    respond_to do |format|
      if @pessoa.save
        format.html { redirect_to @pessoa, notice: @@msgs }
        format.json { render :show, status: :created, location: @pessoa }
      else
        flash[:danger] = @@msge
        format.html { render :new }
        format.json { render json: @pessoa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pessoas/1
  # PATCH/PUT /pessoas/1.json
  def update
    respond_to do |format|
      if @pessoa.update(pessoa_params)
        format.html { redirect_to @pessoa, notice: @@msgs }
        format.json { render :show, status: :ok, location: @pessoa }
      else
        flash[:danger] = @@msge
        format.html { render :edit }
        format.json { render json: @pessoa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pessoas/1
  # DELETE /pessoas/1.json
  def destroy #  -----------------------------------> DESATIVAR / ATIVAR
    if @pessoa.ativo == true
      @pessoa.ativo = false
    else
      @pessoa.ativo = true
    end
    if @pessoa.save!
      flash[:success] = @@msgs
    else
      flash[:dager] = @@msge
    end

    redirect_to pessoas_url
  end



  def trilhos
    @pessoa = Pessoa.accessible_by(current_ability).find(params[:pessoa_id])
    @trilhos = @pessoa.trilhos_da_pessoa.order_by([:nome, :asc])

  
  end

  def adicionar_trilho
    @pessoa = Pessoa.accessible_by(current_ability).find(params[:pessoa_id])
    @igreja = @pessoa.igreja
    @trilhos = @igreja.trilhos.where(:id.nin=>@pessoa.trilhos_da_pessoa_ids).order_by([:nome, :asc])


  end

  def salvar_trilho
    @pessoa = Pessoa.accessible_by(current_ability).find(params[:pessoa_id])
    @igreja = @pessoa.igreja
    @trilho = @igreja.trilhos.find(params[:trilho_id])
    @pessoa.trilhos_da_pessoa << @trilho

    if @pessoa.save
      flash[:success] = @@msgs
      redirect_to pessoa_trilhos_url(@pessoa)
    else
      flash[:danger] = @@msge
      redirect_to pessoa_trilhos_url(@pessoa)
    end

  end

  def remover_trilho
    @pessoa = Pessoa.accessible_by(current_ability).find(params[:pessoa_id])
    @trilho = @pessoa.trilhos_da_pessoa.find(params[:trilho_id])
    @pessoa.trilhos_da_pessoa.delete(@trilho)

    if @pessoa.save
      flash[:success] = @@msgs
      redirect_to pessoa_trilhos_url(@pessoa)
    else
      flash[:danger] = @@msge
      redirect_to pessoa_trilhos_url(@pessoa)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pessoa
      @pessoa = Pessoa.accessible_by(current_ability).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pessoa_params
      params.require(:pessoa).permit(:nome, :sexo, :data_nascimento, :logradouro, :numero, :bairro, :cidade, 
                                     :estado, :cep, :email, :celular, :residencial, :igreja_id,
                                     :estado_civil, :data_casamento)
    end
end
