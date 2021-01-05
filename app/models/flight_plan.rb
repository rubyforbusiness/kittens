class FlightPlan < ApplicationRecord
  has_many :directions, dependent: :destroy
end
