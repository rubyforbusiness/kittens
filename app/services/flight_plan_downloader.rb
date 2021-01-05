# frozen_string_literal: true

# Converts directions into Direction objects
class FlightPlanDownloader
  attr_reader :api

  def initialize(api)
    @api = api
  end

  def download
    ActiveRecord::Base.transaction do
      flight_plan = FlightPlan.new
      raw_directions = api.directions
      raw_directions.each_with_index do |raw_direction, index|
        case raw_direction
        when 'left', 'right'
          record = Turn.new(instruction: raw_direction)
        when 'forward'
          record = Movement.new(distance: 1, direction: raw_direction)
        else
          raise "unexpected direction type from api: #{raw_direction}"
        end

        record.sequence_no = index
        flight_plan.directions << record
        record.save!
      end
      flight_plan.save!
    end
  end
end
