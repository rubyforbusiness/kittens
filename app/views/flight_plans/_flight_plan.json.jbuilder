json.extract! flight_plan, :id, :final_x_location, :final_y_location, :created_at, :updated_at
json.url flight_plan_url(flight_plan, format: :json)
