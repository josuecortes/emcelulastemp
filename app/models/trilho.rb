class Trilho
  include Mongoid::Document
  include Mongoid::Timestamps

  field :nome, type: String, :default => ""
  field :ordem, type:String

  belongs_to :igreja

  has_and_belongs_to_many :pessoas_no_trilho, inverse_of: :trilhos_da_pessoa, :class_name=>"Pessoa", :dependent => :restrict

  validates_presence_of :nome, :ordem, :igreja_id

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

  end
  
end
