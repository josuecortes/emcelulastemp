json.array!(@celulas) do |celula|
  json.extract! celula, :id
  json.url celula_url(celula, format: :json)
end
