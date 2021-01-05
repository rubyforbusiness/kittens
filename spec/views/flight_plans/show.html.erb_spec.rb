require 'rails_helper'

RSpec.describe "flight_plans/show", type: :view do
  before(:each) do
    @flight_plan = assign(:flight_plan, FlightPlan.create!(
      final_x_location: 2,
      final_y_location: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
