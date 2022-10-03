json.extract! user, :id, :first_name, :last_name, :birthday, :country_of_origin, :level, :points, :tier, :created_at, :updated_at
json.url user_url(user, format: :json)
