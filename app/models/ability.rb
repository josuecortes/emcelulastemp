class Ability
  include CanCan::Ability

  MASTER = Role.where(:nome=>"MASTER").first
  ADMINISTRADOR = Role.where(:nome=>"ADMINISTRADOR").first
  LIDER_DE_CELULA = Role.where(:nome=>"LIDER DE CELULA").first
  SUPERVISOR_DE_CELULA = Role.where(:nome=>"SUPERVISOR DE CELULA").first
  CORDENADOR_DE_CELULA = Role.where(:nome=>"CORDENADOR DE CELULA").first
  SECRETARIA = Role.where(:nome=>"SECRETARIA").first
  TESOURARIA = Role.where(:nome=>"TESOURARIA").first

  def initialize(user)
    
    

    if user.roles.include?MASTER
      can :manage, :all
      
    end

    if user.roles.include?ADMINISTRADOR
      can :manage, :all, {:igreja_id=>user.igreja_id}
      can :manage, Role, {:nome.ne=>'MASTER'}
      can :manage, User, {:igreja_id=>user.igreja_id, :role_id.nin=>Role.where(:nome.in=>["MASTER"]).collect{|r|r.id}}
    end

    if user.roles.include?SECRETARIA
      can :manage, Role, {:nome.nin=>['MASTER','ADMINISTRADOR','TESOURARIA']}
      can :manage, User, {:igreja_id=>user.igreja_id, :role_ids.nin=>Role.where(:nome.in=>["MASTER","ADMINISTRADOR","TESOURARIA"]).collect{|r|r.id}}
      can :manage, Celula, {:igreja_id=>user.igreja_id}
      can :gerenciar, Celula, {:igreja_id=>user.igreja_id}
      can :manage, Pessoa, {:igreja_id=>user.igreja_id}
      can :manage, Trilho, {:igreja_id=>user.igreja_id}
      can [:read, :update, :create], Igreja, {:id=>user.igreja_id}

      #can :relatorios, :all
      can :show, :relatorios
      can :aniversariantes, :relatorios
      can :geral, :relatorios

      can :manage, EncontroSemanal
      can :enviar, EncontroSemanal

    end


    if user.roles.include?CORDENADOR_DE_CELULA

      #cannot :manage, :all
      
      can :manage, User, {:id=>user.id}
      can :read, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_cordenador_ids)}  
      can :gerenciar, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_cordenador_ids)}  
      can :adicionar_supervisor, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_cordenador_ids)} 
      can :salvar_supervisor, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_cordenador_ids)} 
      can :remover_supervisor, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_cordenador_ids)} 
      
      
      #cannot :delete, Celula

      #can :adicionar_lider, Celula
      #can :salvar_lider, Celula
      #can :remover_lider, Celula


      #can :create, EncontroSemanal
      #can :manage, EncontroSemanal, {:celula_id.in=>(user.pessoa.celulas_que_e_lider_ids), :status => "EM ABERTO"}
      #can :delete, EncontroSemanal, {:celula_id.in=>(user.pessoa.celulas_que_e_lider_ids), :status.nin=>["ENVIADO", "RECEBIDO"]}
      
      can :read, EncontroSemanal, {:celula_id.in=>(user.pessoa.celulas_que_e_cordenador_ids), :status =>"RECEBIDO"}


      #cannot [:adicionar_supervisor, :salvar_supervisor, :remover_supervisor, :adicionar_cordenador, :salvar_cordenador, :remover_cordenador], Celula 



      can :manage, Pessoa, {:igreja_id=>user.igreja_id, :id=>user.pessoa_id} 
      can :manage, Pessoa, {:igreja_id=>user.igreja_id, :celula_que_e_supervisor_id.in=>(user.pessoa.celulas_que_e_cordenador_ids)} 
      can :read, Pessoa, {:igreja_id=>user.igreja_id, :celula_que_e_membro_id.in=>(user.pessoa.celulas_que_e_cordenador_ids)} 
      can :read, Pessoa, {:igreja_id=>user.igreja_id, :celula_que_e_lider_em_treinamento_id.in=>(user.pessoa.celulas_que_e_cordenador_ids)}
      can :read, Pessoa, {:igreja_id=>user.igreja_id, :celula_que_e_membro_id=>nil, :celula_que_e_lider_em_treinamento_id=>nil, 
                          :celulas_que_e_lider_ids=>[],
                          :celulas_que_e_supervisor_ids=>[], 
                          :celulas_que_e_cordenador_ids=>[]}


      #cannot :relatorios, :all
      #cannot :show, :relatorios
      can :show, :relatorios
      can :aniversariantes, :relatorios
      can :geral, :relatorios

    end



    if user.roles.include?SUPERVISOR_DE_CELULA

      #cannot :manage, :all
      
      can :manage, User, {:id=>user.id}
      can :create, Celula
      can :read, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_supervisor_ids)}  
      can :update, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_supervisor_ids)}  
      can :gerenciar, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_supervisor_ids)}  
      can :adicionar_lider, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_supervisor_ids)} 
      can :salvar_lider, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_supervisor_ids)} 
      can :remover_lider, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_supervisor_ids)} 
      
      
      #cannot :delete, Celula

      #can :adicionar_lider, Celula
      #can :salvar_lider, Celula
      #can :remover_lider, Celula


      #can :create, EncontroSemanal
      #can :manage, EncontroSemanal, {:celula_id.in=>(user.pessoa.celulas_que_e_lider_ids), :status => "EM ABERTO"}
      #can :delete, EncontroSemanal, {:celula_id.in=>(user.pessoa.celulas_que_e_lider_ids), :status.nin=>["ENVIADO", "RECEBIDO"]}
      cannot :receber, EncontroSemanal, {:celula_id.in=>(user.pessoa.celulas_que_e_supervisor_ids), :status =>"EM ABERTO"}
      can :receber, EncontroSemanal, {:celula_id.in=>(user.pessoa.celulas_que_e_supervisor_ids), :status =>"ENVIADO"}
      can :read, EncontroSemanal, {:celula_id.in=>(user.pessoa.celulas_que_e_supervisor_ids), :status =>"RECEBIDO"}


      #cannot [:adicionar_supervisor, :salvar_supervisor, :remover_supervisor, :adicionar_cordenador, :salvar_cordenador, :remover_cordenador], Celula 



      can :manage, Pessoa, {:igreja_id=>user.igreja_id, :id=>user.pessoa_id} 
      can :manage, Pessoa, {:igreja_id=>user.igreja_id, :celula_que_e_membro_id.in=>(user.pessoa.celulas_que_e_supervisor_ids)} 
      can :read, Pessoa, {:igreja_id=>user.igreja_id, :celula_que_e_lider_em_treinamento_id.in=>(user.pessoa.celulas_que_e_supervisor_ids)}
      can :read, Pessoa, {:igreja_id=>user.igreja_id, :celula_que_e_membro_id=>nil, :celula_que_e_lider_em_treinamento_id=>nil, 
                          :celulas_que_e_lider_ids=>[],
                          :celulas_que_e_supervisor_ids=>[], 
                          :celulas_que_e_cordenador_ids=>[]}


      #cannot :relatorios, :all
      #cannot :show, :relatorios
      can :show, :relatorios
      can :aniversariantes, :relatorios
      can :geral, :relatorios

    end

    if user.roles.include?LIDER_DE_CELULA
      
      #cannot :manage, :all

      can :manage, User, {:id=>user.id}
      
      can :show, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_lider_ids)} 
      can :read, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_lider_ids)} 
      can :update, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_lider_ids)} 
      
      can :gerenciar, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_lider_ids)} 
      can :adicionar_membro, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_lider_ids)} 
      can :salvar_membro, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_lider_ids)} 
      can :remover_membro, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_lider_ids)} 
      can :salvar_lider_em_treinamento, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_lider_ids)} 
      can :remover_lider_em_treinamento, Celula, {:igreja_id=>user.igreja_id, :id.in=>(user.pessoa.celulas_que_e_lider_ids)}  

      #cannot [:adicionar_lider, :salvar_lider, :remover_lider, :adicionar_supervisor, :salvar_supervisor, :remover_supervisor, 
      #        :adicionar_cordenador, :salvar_cordenador, :remover_cordenador], Celula 


      can :pegar_celula, EncontroSemanal, {:celula_id.in=>(user.pessoa.celulas_que_e_lider_ids)}
      can :create, EncontroSemanal
      can :update, EncontroSemanal, {:celula_id.in=>(user.pessoa.celulas_que_e_lider_ids), :status => "EM ABERTO"}
      can :destroy, EncontroSemanal, {:celula_id.in=>(user.pessoa.celulas_que_e_lider_ids), :status => "EM ABERTO"}
      can :enviar, EncontroSemanal, {:celula_id.in=>(user.pessoa.celulas_que_e_lider_ids), :status => "EM ABERTO"}
      can :read, EncontroSemanal, {:celula_id.in=>(user.pessoa.celulas_que_e_lider_ids), :status.in=>["EM ABERTO", "ENVIADO", "RECEBIDO"]}

      
      can :manage, Pessoa, {:igreja_id=>user.igreja_id, :id=>user.pessoa_id} 
      can :manage, Pessoa, {:igreja_id=>user.igreja_id, :celula_que_e_membro_id.in=>(user.pessoa.celulas_que_e_lider_ids)} 
      can :manage, Pessoa, {:igreja_id=>user.igreja_id, :celula_que_e_lider_em_treinamento_id.in=>(user.pessoa.celulas_que_e_lider_ids)}
      


      can :read, Pessoa, {:igreja_id=>user.igreja_id, :celula_que_e_membro_id=>nil, :celula_que_e_lider_em_treinamento_id=>nil, 
                          :celulas_que_e_lider_ids=>[],
                          :celulas_que_e_supervisor_ids=>[], 
                          :celulas_que_e_cordenador_ids=>[]}

      #cannot :relatorios, :all
      #cannot :show, :relatorios
      #cannot :aniversariantes, :relatorios
      #cannot :geral, :relatorios
      can :show, :relatorios
      can :aniversariantes, :relatorios
      can :geral, :relatorios
      
    end

    
  end
end
