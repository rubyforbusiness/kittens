require "rails_helper"

RSpec.describe FlightPlansController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/flight_plans").to route_to("flight_plans#index")
    end

    it "routes to #delete_all" do
      expect(post: "/flight_plans/delete_all").to route_to("flight_plans#delete_all")
    end

    it "route to #download" do
      expect(post: "/flight_plans/download").to route_to("flight_plans#download")
    end

    it "route to #run" do
      expect(post: "/flight_plans/1/run").to route_to("flight_plans#run", id: "1")
    end

    it "route to #submit" do
      expect(post: "/flight_plans/1/submit").to route_to("flight_plans#submit", id: "1")
    end

    it "routes to #new" do
      expect(get: "/flight_plans/new").to route_to("flight_plans#new")
    end

    it "routes to #show" do
      expect(get: "/flight_plans/1").to route_to("flight_plans#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/flight_plans/1/edit").to route_to("flight_plans#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/flight_plans").to route_to("flight_plans#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/flight_plans/1").to route_to("flight_plans#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/flight_plans/1").to route_to("flight_plans#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/flight_plans/1").to route_to("flight_plans#destroy", id: "1")
    end
  end
end
