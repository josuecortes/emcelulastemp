Rails.application.routes.draw do
  
  resources :tipo_celulas

  get 'relatorios/index'

  get 'relatorios/aniversariantes'

  get 'relatorios/geral'

  resources :trilhos

  resources :celulas do

    get :gerenciar

    get :adicionar_membro

    get :salvar_membro

    get :remover_membro

    get :salvar_lider_em_treinamento

    get :remover_lider_em_treinamento

    get :adicionar_lider

    get :salvar_lider

    get :remover_lider

    get :adicionar_supervisor

    get :salvar_supervisor

    get :remover_supervisor

    get :adicionar_cordenador

    get :salvar_cordenador

    get :remover_cordenador

    get :relatorios

    resources :encontro_semanals, :path => "encontro_semanais" do

      get :enviar

      get :receber

    end

  end

  resources :igrejas

  resources :pessoas do

    get :trilhos

    get :adicionar_trilho

    post :salvar_trilho

    delete :remover_trilho 
    
  end

  devise_for :users
  
  resources :usuarios do

    get :redefinir_senha

    get :logar_como
  
  end 

  get 'home/index'

  get "home/nao_autorizado"

  root 'home#index'

  
end
