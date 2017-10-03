json.array!(@encontro_semanals) do |encontro_semanal|
  json.extract! encontro_semanal, :id
  json.url encontro_semanal_url(encontro_semanal, format: :json)
end
