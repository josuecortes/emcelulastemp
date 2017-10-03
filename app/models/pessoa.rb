class Pessoa
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :nome, type: String, :default => ""
  field :sexo, type: String, :default => ""
  field :data_nascimento, type: Date
  field :logradouro, type: String, :default => ""
  field :numero, type: String, :default => ""
  field :bairro, type: String, :default => ""
  field :cidade, type: String, :default => ""
  field :estado, type: String, :default => ""
  field :cep, type: String
  field :email, type: String
  field :celular, type: String
  field :residencial, type: String
  field :estado_civil, type: String
  field :data_casamento, type: Date

  field :ativo, type: Boolean, default: true

  field :ano, type: Integer
  field :mes, type: Integer
  field :dia, type: Integer

  belongs_to :igreja
  has_one :user

  belongs_to :celula_que_e_membro, inverse_of: :membros_da_celula, class_name: "Celula"
  belongs_to :celula_que_e_lider_em_treinamento, inverse_of: :lideres_em_treinamento_da_celula, class_name: "Celula"
  has_and_belongs_to_many :celulas_que_e_lider, inverse_of: :lideres_da_celula, class_name: "Celula"
  has_and_belongs_to_many :celulas_que_e_supervisor, inverse_of: :supervisores_da_celula, class_name: "Celula"
  has_and_belongs_to_many :celulas_que_e_cordenador, inverse_of: :cordenadores_da_celula, class_name: "Celula"

  has_and_belongs_to_many :trilhos_da_pessoa, inverse_of: :pessoas_no_trilho, :class_name=>"Trilho", :dependent => :restrict

  has_and_belongs_to_many :encontros, inverse_of: :membros, :class_name => "EncontroSemanal"

  has_and_belongs_to_many :encontro_faltosos, inverse_of: :faltosos, :class_name => "EncontroSemanal"


  validates_presence_of :estado_civil, :nome, :sexo, :data_nascimento, :logradouro, :numero, :cidade, :estado, :email, :bairro, :igreja_id
  validates_presence_of :data_casamento, :if => :checar_estado_civil

  def checar_estado_civil
    if self.estado_civil == "CASADO(A)"
      return true
    end
  end
  
  def adicionar_membro_na_celula(celula)
    self.celula_que_e_membro = celula
    if self.save
      return true
    else
      return false
    end
  end

  def remover_membro_da_celula(celula)
    self.celula_que_e_membro = nil
    if self.save
      return true
    else
      return false
    end
  end

  def adicionar_lider_em_treinamento_na_celula(celula)
    self.celula_que_e_lider_em_treinamento = celula
    self.celula_que_e_membro = nil
    if self.save
      return true
    else
      return false
    end
  end

  def remover_lider_em_treinamento_da_celula(celula)
    self.celula_que_e_lider_em_treinamento = nil
    if self.save
      return true
    else
      return false
    end
  end

  def adicionar_lider_na_celula(celula)
    self.celulas_que_e_lider << celula
    self.celula_que_e_membro = nil
    self.celula_que_e_lider_em_treinamento = nil
    if self.save
      return true
    else
      return false
    end
  end

  def remover_lider_da_celula(celula)
    c = self.celulas_que_e_lider.count

    if c > 1
      self.celulas_que_e_lider.delete(celula)
    else
      self.celulas_que_e_lider = nil
    end

    if self.save
      return true
    else
      return false
    end
  end

  def adicionar_supervisor_na_celula(celula)
    self.celulas_que_e_supervisor << celula
    self.celula_que_e_membro = nil
    self.celula_que_e_lider_em_treinamento = nil
    if self.save
      return true
    else
      return false
    end
  end

  def remover_supervisor_da_celula(celula)
    c = self.celulas_que_e_supervisor.count

    if c > 1
      self.celulas_que_e_supervisor.delete(celula)
    else
      self.celulas_que_e_supervisor = nil
    end

    if self.save
      return true
    else
      return false
    end
  end

  def adicionar_cordenador_na_celula(celula)
    self.celulas_que_e_cordenador << celula
    self.celula_que_e_membro = nil
    self.celula_que_e_lider_em_treinamento = nil
    if self.save
      return true
    else
      return false
    end
  end

  def remover_cordenador_da_celula(celula)
    c = self.celulas_que_e_cordenador.count

    if c > 1
      self.celulas_que_e_cordenador.delete(celula)
    else
      self.celulas_que_e_cordenador = nil
    end

    if self.save
      return true
    else
      return false
    end
  end

  scope :pessoas_sem_celula, -> { where(celula_que_e_membro_id: nil, celula_que_e_lider_em_treinamento_id: nil, celulas_que_e_lider_ids: [], 
                                        celulas_que_e_supervisor_ids: [], celulas_que_e_cordenador_ids: []) }
  #scope :participantes_da_celula , lambda { |celula| where(:id.in=>([celula.membros_da_celula_ids, celula.lideres_da_celula_ids, celula.supervisores_da_celula_ids]))} 
  scope :nao_e_lider_desta_celula , lambda { |celula| where(:id.nin=>(celula.lideres_da_celula_ids))} 
  scope :nao_e_supervisor_desta_celula , lambda { |celula| where(:id.nin=>(celula.supervisores_da_celula_ids))} 
  scope :nao_e_cordenador_desta_celula , lambda { |celula| where(:id.nin=>(celula.cordenadores_da_celula_ids))} 
  #scope :nao_e_lider_desta_celula, lambda {|celula| any_in(:celulas_que_e_lider_ids.nin => (celula.lideres_da_celula))}
  #scope :da_igreja, -> 

  before_save :maiusculas_sem_acentos
  before_create :setar_relacionamentos

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

  def setar_relacionamentos
    self.celula_que_e_membro_id = nil
    self.celula_que_e_lider_em_treinamento_id = nil
    self.celulas_que_e_lider_ids = []
    self.celulas_que_e_supervisor_ids = []
    self.celulas_que_e_cordenador_ids = []
    self.user = nil
  end

  def porcentagem
    total = self.igreja.trilhos.count
    trilhos_da_pessoa = self.trilhos_da_pessoa.count
    if trilhos_da_pessoa > 0 and total > 0
      porcentagem = (trilhos_da_pessoa * 100) / total
    else
      porcentagem = 0
    end
    return porcentagem
  end

  before_save :setar_data_separada

  def setar_data_separada
    self.ano = self.data_nascimento.year
    self.mes = self.data_nascimento.month
    self.dia = self.data_nascimento.day
  end

  #scope :mes, ->{ where(:data_inicio=>DateTime.now.year, :data_inicio=>DateTime.now.month) }


  scope :mes, lambda { |q| where(:mes=>q) }

  #scope :data, lambda { |q| where(:data=>q)}

  scope :semana, -> { where(:dia.gte=>data_inicio_semana.day, :mes.gte=>data_inicio.month, :dia.lte=>data_fim_semana.day, :mes.lte=>data_fim_semana.month)}


  def data_inicio_semana
    data_atual = DateTime.now
    data_inicio = data_atual
    while data_inicio.wday != 1 do
      data_inicio = data_inicio - 1.day
    end
    return data_inicio
  end

  def data_fim_semana
    data_atual = DateTime.now
    data_fim = data_atual
    while data_fim.wday != 0 do
      data_fim = data_fim + 1.day
    end
    return data_fim
  end

end
