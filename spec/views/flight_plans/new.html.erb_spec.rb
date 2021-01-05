require 'rails_helper'

RSpec.describe "flight_plans/new", type: :view do
  before(:each) do
    assign(:flight_plan, FlightPlan.new(
      final_x_location: 1,
      final_y_location: 1
    ))
  end

  it "renders new flight_plan form" do
    render

    assert_select "form[action=?][method=?]", flight_plans_path, "post" do

      assert_select "input[name=?]", "flight_plan[final_x_location]"

      assert_select "input[name=?]", "flight_plan[final_y_location]"
    end
  end
end
