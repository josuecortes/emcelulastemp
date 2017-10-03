json.array!(@igrejas) do |igreja|
  json.extract! igreja, :id, :nome, :logradouro, :numero, :bairro, :cidade, :estado, :cep
  json.url igreja_url(igreja, format: :json)
end
