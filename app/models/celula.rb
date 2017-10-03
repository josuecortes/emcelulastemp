class Celula
  include Mongoid::Document
  include Mongoid::Timestamps

  field :nome, type: String, :default => ""
  field :data_criacao, type: Date
  field :logradouro, type: String, :default => ""
  field :numero, type: String, :default => ""
  field :bairro, type: String, :default => ""
  field :cidade, type: String, :default => ""
  field :estado, type: String, :default => ""
  field :cep, type: String
  field :dia, type: String
  field :hora, type: String, :default => "19"
  field :minutos, type: String, :default => "00"

  field :ativo, type: Boolean, default: true

  belongs_to :igreja
  has_many :membros_da_celula, inverse_of: :celula_que_e_membro, class_name: "Pessoa"
  has_many :lideres_em_treinamento_da_celula, inverse_of: :celula_que_e_lider_em_treinamento, class_name: "Pessoa"
  has_and_belongs_to_many :lideres_da_celula, inverse_of: :celulas_que_e_lider, class_name: "Pessoa"
  has_and_belongs_to_many :supervisores_da_celula, inverse_of: :celulas_que_e_supervisor, class_name: "Pessoa"
  has_and_belongs_to_many :cordenadores_da_celula, inverse_of: :celulas_que_e_cordenador, class_name: "Pessoa"
  has_many :encontro_semanals

  validates_presence_of :nome, :logradouro, :numero, :bairro, :cidade, :estado, :hora, :minutos, :dia, :igreja_id
  validates_uniqueness_of :nome, :scope => [:igreja_id]

  before_save :maiusculas_sem_acentos

  def maiusculas_sem_acentos
    # if self.nome != nil
    #   self.nome = self.nome.upcase
    #   self.nome = self.nome.remover_acentos 
    # end

    if self.nome != "" and self.nome != nil
      self.nome = self.nome.upcase
      self.nome = self.nome.remover_acentos
    end

    if self.logradouro != "" and self.logradouro != nil
      self.logradouro = self.logradouro.upcase
      self.logradouro = self.logradouro.remover_acentos
    end

    if self.bairro != "" and self.bairro != nil
      self.bairro = self.bairro.upcase
      self.bairro = self.bairro.remover_acentos
    end

    if self.cidade != "" and self.cidade != nil
      self.cidade = self.cidade.upcase
      self.cidade = self.cidade.remover_acentos
    end

    if self.estado != "" and self.estado != nil
      self.estado = self.estado.upcase
      self.estado = self.estado.remover_acentos
    end

    if self.estado != "" and self.estado != nil
      self.estado = self.estado.upcase
      self.estado = self.estado.remover_acentos
    end

  end

end
