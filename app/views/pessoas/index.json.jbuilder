json.array!(@pessoas) do |pessoa|
  json.extract! pessoa, :id, :nome, :sexo, :data_nascimento, :logradouro, :numero, :bairro, :cidade, :estado, :cep, :email, :celular, :residencial
  json.url pessoa_url(pessoa, format: :json)
end
