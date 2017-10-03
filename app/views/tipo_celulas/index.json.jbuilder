json.array!(@tipo_celulas) do |tipo_celula|
  json.extract! tipo_celula, :id
  json.url tipo_celula_url(tipo_celula, format: :json)
end
