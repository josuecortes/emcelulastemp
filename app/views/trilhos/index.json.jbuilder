json.array!(@trilhos) do |trilho|
  json.extract! trilho, :id, :nome
  json.url trilho_url(trilho, format: :json)
end
