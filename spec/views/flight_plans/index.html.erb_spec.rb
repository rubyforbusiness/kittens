require 'rails_helper'

RSpec.describe "flight_plans/index", type: :view do
  let(:x) { 100 }
  let(:y) { 99 }

  before(:each) do
    assign(:flight_plans, [
      FlightPlan.create!(
        final_x_location: x,
        final_y_location: y
      ),
      FlightPlan.create!(
        final_x_location: x,
        final_y_location: y
      )
    ])
  end

  it "renders a list of flight_plans" do
    render
    assert_select "tr>td", text: x.to_s, count: 2
    assert_select "tr>td", text: y.to_s, count: 2
  end
end
