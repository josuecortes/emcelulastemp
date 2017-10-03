class Role
  include Mongoid::Document
  include Mongoid::Timestamps

  field :nome,              type: String, default: ""

  validates_presence_of :nome

  has_and_belongs_to_many :users, inverse_of: :roles, class_name: "User"

  scope :oquepode, ->{ where(:nome.nin=>["LIDER DE CELULA", "SUPERVISOR DE CELULA", "CORDENADOR DE CELULA"]   )}

end
