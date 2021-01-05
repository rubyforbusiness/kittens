# frozen_string_literal: true

# Calculates end location of a set of directions
class FlightPlanRunner
  attr_reader :flight_plan

  def initialize(flight_plan)
    @flight_plan = flight_plan
  end

  def run
    ActiveRecord::Base.transaction do
      location = Location.new
      flight_plan.directions.order(:sequence_no).each do |direction|
        location.update direction
      end
      flight_plan.final_x_location = location.x
      flight_plan.final_y_location = location.y
      flight_plan.save!
    end
  end
end
