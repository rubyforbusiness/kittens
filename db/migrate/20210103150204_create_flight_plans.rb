class CreateFlightPlans < ActiveRecord::Migration[5.2]
  def change
    create_table :flight_plans do |t|
      t.integer :final_x_location
      t.integer :final_y_location

      t.timestamps
    end
  end
end
