class IgrejasController < ApplicationController
  before_action :set_igreja, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource :class=>"Igreja", except: :create
  # GET /igrejas
  # GET /igrejas.json
  def index
    @igrejas = Igreja.accessible_by(current_ability)
  end

  # GET /igrejas/1
  # GET /igrejas/1.json
  def show
  end

  # GET /igrejas/new
  def new
    @igreja = Igreja.new
  end

  # GET /igrejas/1/edit
  def edit
  end

  # POST /igrejas
  # POST /igrejas.json
  def create
    @igreja = Igreja.new(igreja_params)

    respond_to do |format|
      if @igreja.save
        format.html { redirect_to @igreja, notice: @@msgs }
        format.json { render :show, status: :created, location: @igreja }
      else
        flash[:danger] = @@msge
        format.html { render :new }
        format.json { render json: @igreja.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /igrejas/1
  # PATCH/PUT /igrejas/1.json
  def update
    respond_to do |format|
      if @igreja.update(igreja_params)
        format.html { redirect_to @igreja, notice: @@msgs }
        format.json { render :show, status: :ok, location: @igreja }
      else
        flash[:danger] = @@msge
        format.html { render :edit }
        format.json { render json: @igreja.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /igrejas/1
  # DELETE /igrejas/1.json
  def destroy
    if @igreja.destroy
      flash[:success] = @@msgs
    else
      flash[:danger] = @@msge
    end
    respond_to do |format|
      format.html { redirect_to igrejas_url, notice: 'Igreja was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_igreja
      @igreja = Igreja.accessible_by(current_ability).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def igreja_params
      params.require(:igreja).permit(:id, :nome, :logradouro, :numero, :bairro, :cidade, :estado, :cep)
    end
end
