json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name, :year

  json.beers do
    json.array!(brewery.beers) do |beer|
      json.extract! beer, :id, :name
    end
  end
end
