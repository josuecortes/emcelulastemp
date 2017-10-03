	class EncontroSemanal
  include Mongoid::Document
  include Mongoid::Timestamps

  field :data, type: Date
  field :status, type: String, :default => "EM ABERTO" #EM ABERTO ENVIADO RECEBIDO
  field :numero_visitantes, type: Integer, :default => 0
  field :nome_visitantes, type: String, :default => ""

  field :numero_criancas, type: Integer, :default => 0
  field :numero_decisoes, type: Integer, :default => 0
  field :numero_reconciliacoes, type: Integer, :default => 0
  field :ministrante, type: String, :default => ""
  field :palavra, type: String, :default => ""
  field :ofertas, type: String, :default => ""
  field :dizimos, type: String, :default => ""

  field :houve_celula, type: Boolean, :default => true


  validates_presence_of :data, :celula_id, :status

  belongs_to :celula
  has_and_belongs_to_many :membros, inverse_of: :encontros, :class_name => "Pessoa"
  has_and_belongs_to_many :faltosos, inverse_of: :encontro_faltosos, :class_name => "Pessoa"

  before_save :maiusculas_sem_acentos

  def maiusculas_sem_acentos
    if !self.ministrante.blank?
      self.ministrante = self.ministrante.upcase
      self.ministrante = self.ministrante.remover_acentos 
    end 

    if !self.palavra.blank?
      self.palavra = self.palavra.upcase
      self.palavra = self.palavra.remover_acentos 
    end 

    if !self.nome_visitantes.blank?
      self.nome_visitantes = self.nome_visitantes.upcase
      self.nome_visitantes = self.nome_visitantes.remover_acentos 
    end 

  end
  
  def setar_faltosos(celula)


    # presentes = []
    # self.membros.each do |m|
    #   presentes << m.id
    # end

    # self.faltosos << celula.membros_da_celula.where(:membros_da_celula_ids.nin=>(presentes))
    # self.faltosos << celula.lideres_em_treinamento_da_celula.where(:lideres_em_treinamento_da_celula_ids.nin=>(presentes))
    # self.faltosos << celula.lideres_da_celula.where(:lideres_da_celula_ids.nin=>(presentes))

    # celula.where(:membros_da_celula_ids.nin=>(self.membro_ids), :lideres_da_celula_ids.nin=>(self.membro_ids), :lideres_em_treinamento_da_celula_ids.nin=>(self.membro_ids)).each do |m|
    #   self.faltosos << m
    # end

    celula.membros_da_celula.each do |mc|
      presente = false
      self.membros.each do |mp|
        if mp.id == mc.id
          presente = true
        end
      end
      if presente == false
        self.faltosos << mc
      end
    end

    #################

    celula.lideres_em_treinamento_da_celula.each do |ltc|
      presente = false
      self.membros.each do |mp|
        if mp.id == ltc.id
          presente = true
        end
      end
      if presente == false
        self.faltosos << ltc
      end
    end

    ###############

    celula.lideres_da_celula.each do |lc|
      presente = false
      self.membros.each do |mp|
        if mp.id == lc.id
          presente = true
        end
      end
      if presente == false
        self.faltosos << lc
      end
    end

    if self.save!
      return true
    else
      return false
    end

  end

end
