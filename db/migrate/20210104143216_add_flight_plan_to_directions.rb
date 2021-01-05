class AddFlightPlanToDirections < ActiveRecord::Migration[5.2]
  def change
    add_reference :directions, :flight_plan
  end
end
