class Igreja
  include Mongoid::Document
  include Mongoid::Timestamps

  field :nome, type: String, :default => ""
  field :logradouro, type: String, :default => ""
  field :numero, type: String, :default => ""
  field :bairro, type: String, :default => ""
  field :cidade, type: String, :default => ""
  field :estado, type: String, :default => ""
  field :cep, type: String

  has_many :users
  has_many :pessoas
  has_many :celulas
  has_many :trilhos

  validates_presence_of :nome, :logradouro, :numero, :bairro, :cidade, :estado, :cep

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
