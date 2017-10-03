class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  field :nome,              type: String, default: ""
  
  ## Roles ===> ADMINISTRADOR NUINFO REQUISITANTE
  
  field :ativo,             type: Boolean, default: true
  field :mudar_senha,       type: Boolean, default: true

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  belongs_to :igreja
  belongs_to :pessoa
  has_and_belongs_to_many :roles, inverse_of: :users, class_name: "Role"

  validates_presence_of :nome, :ativo, :role_ids, :mudar_senha, :email
  validates_presence_of :igreja_id, :if => :nao_master
  validates_presence_of :pessoa_id, :if => :nao_master_nao_administrador

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  def verificar_senha
    if self.mudar_senha == true
      return true
    else
      return false
    end 
  end

  def nao_master
    r = Role.where(:nome=>"MASTER").first
    if self.roles.include?r
      return false
    else
      return true
    end 
  end

  def e_secretaria
    r = Role.where(:nome=>"SECRETARIA").first
    if self.roles.include?r
      return true
    else
      return false
    end
  end

  def nao_master_nao_administrador
    m = Role.where(:nome=>"MASTER").first
    a = Role.where(:nome=>"ADMINISTRADOR").first
    if self.roles.include?m or self.roles.include?a
      return false
    else
      return true
    end 
  end

  def supervisor_nao_master_nao_adm_nao_sec 
    m = Role.where(:nome=>"MASTER").first
    a = Role.where(:nome=>"ADMINISTRADOR").first
    sec = Role.where(:nome=>"SECRETARIA").first
    sup = Role.where(:nome=>"SUPERVISOR DE CELULA").first
    if self.roles.include?sup and !self.roles.include?m and !self.roles.include?a and !self.roles.include?sec
      return true
    end
  end

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
