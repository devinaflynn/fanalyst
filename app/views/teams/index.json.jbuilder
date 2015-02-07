json.array!(@teams) do |team|
  json.extract! team, :id, :notes, :score
  json.url team_url(team, format: :json)
end
