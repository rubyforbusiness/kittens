require 'rails_helper'

RSpec.describe FlightPlan, type: :model do
  let(:flight_plan) { create(:flight_plan, :with_directions)}
  it 'has directions' do
    expect(flight_plan.directions.count).to be > 0
  end
end
