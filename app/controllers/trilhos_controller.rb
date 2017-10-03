class TrilhosController < ApplicationController
  before_action :set_trilho, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource :class=>"Trilho", except: :create
  # GET /trilhos
  # GET /trilhos.json
  def index
    @trilhos = Trilho.accessible_by(current_ability)
  end

  # GET /trilhos/1
  # GET /trilhos/1.json
  def show
  end

  # GET /trilhos/new
  def new
    @trilho = Trilho.new
  end

  # GET /trilhos/1/edit
  def edit
  end

  # POST /trilhos
  # POST /trilhos.json
  def create
    @trilho = Trilho.new(trilho_params)

    respond_to do |format|
      if @trilho.save
        format.html { redirect_to @trilho, notice: @@msgs }
        format.json { render :show, status: :created, location: @trilho }
      else
        flash[:danger] = @@msge
        format.html { render :new }
        format.json { render json: @trilho.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trilhos/1
  # PATCH/PUT /trilhos/1.json
  def update
    respond_to do |format|
      if @trilho.update(trilho_params)
        format.html { redirect_to @trilho, notice: @@msgs }
        format.json { render :show, status: :ok, location: @trilho }
      else
        flash[:danger] = @@msge
        format.html { render :edit }
        format.json { render json: @trilho.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trilhos/1
  # DELETE /trilhos/1.json
  def destroy
    if @trilho.destroy
      flash[:success] = @@msgs
    else
      flash[:danger] = @@msge
    end
    respond_to do |format|
      format.html { redirect_to trilhos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trilho
      @trilho = Trilho.accessible_by(current_ability).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trilho_params
      params.require(:trilho).permit(:nome, :ordem, :igreja_id)
    end
end
