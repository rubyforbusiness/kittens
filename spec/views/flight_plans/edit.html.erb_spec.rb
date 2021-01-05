require 'rails_helper'

RSpec.describe "flight_plans/edit", type: :view do
  before(:each) do
    @flight_plan = assign(:flight_plan, FlightPlan.create!(
      final_x_location: 1,
      final_y_location: 1
    ))
  end

  it "renders the edit flight_plan form" do
    render

    assert_select "form[action=?][method=?]", flight_plan_path(@flight_plan), "post" do

      assert_select "input[name=?]", "flight_plan[final_x_location]"

      assert_select "input[name=?]", "flight_plan[final_y_location]"
    end
  end
end
