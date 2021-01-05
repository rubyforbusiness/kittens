require 'rails_helper'

RSpec.describe Direction, type: :model do
  let(:direction) { create(:direction, :with_flight_plan)}
  it 'has a flight plan' do
    expect(direction.flight_plan).not_to be nil
  end
end
