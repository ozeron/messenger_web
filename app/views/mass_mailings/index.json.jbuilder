json.array!(b.mass_mailings) do |mass_mailing|
  json.extract! mass_mailing, :id, :title, :started, :finished
  json.url mass_mailing_url(mass_mailing, format: :json)
end
