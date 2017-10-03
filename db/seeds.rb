
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

m = Role.find_or_create_by(:nome=>"MASTER")
if m.save
	puts "Role master criada"
else
	puts "Erro ao criar role master"
end

r = Role.find_or_create_by(:nome=>"ADMINISTRADOR")
if r.save
puts "Role administrador criada"
else
	puts "Erro ao criar role administrador"
end

Role.find_or_create_by(:nome=>"LIDER DE CELULA")
Role.find_or_create_by(:nome=>"SUPERVISOR DE CELULA")
Role.find_or_create_by(:nome=>"CORDENADOR DE CELULA")
Role.find_or_create_by(:nome=>"PASTOR")
Role.find_or_create_by(:nome=>"PRESIDENTE")


Role.find_or_create_by(:nome=>"SECRETARIA")
Role.find_or_create_by(:nome=>"TESOURARIA")



u = User.find_or_create_by(:nome=>"MASTER", :email=>"master@emcelulas.com", :password=>"123123123",
											 :password_confirmation=>"123123123", :mudar_senha=>false, :ativo=>true)

#u.roles << m
#user.roles.delete(role_mc)
u.roles << m

if u.save
	puts "Usuario Master Criado"
	puts #{u.roles}
else
	puts "Erro ao Criar Usuario Masterss"
end