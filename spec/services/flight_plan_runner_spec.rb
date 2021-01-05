# frozen_string_literal: true

require 'rails_helper'
context FlightPlanRunner do
  let(:flight_plan) { create(:flight_plan) }

  describe '#run' do
    subject do
      described_class.new(flight_plan).run
    end

    context 'without directions' do
      it 'updates locations to zero' do
        expect{
          subject
        }.to change { FlightPlan.find(flight_plan.id).final_x_location }.from(nil).to(0)
        .and change { FlightPlan.find(flight_plan.id).final_y_location }.from(nil).to(0)
      end
    end

    context 'with one direction' do
      before {
        create(:movement, flight_plan: flight_plan, direction: "forward")
      }

      let(:fetch) {
        -> (id) { FlightPlan.find(id) }
      }

      let(:expected_x) { 0 }
      let(:expected_y) { 1 }

      it 'updates locations correctly' do
        expect{
          subject
        }.to change { fetch.call(flight_plan.id).final_x_location }.from(nil).to(expected_x)
        .and change { fetch.call(flight_plan.id).final_y_location }.from(nil).to(expected_y)
      end
    end

    context 'with several directions' do
      before {
        create(:movement, flight_plan: flight_plan, direction: "forward")
        create(:turn, flight_plan: flight_plan, instruction: "right")
        create(:movement, flight_plan: flight_plan, direction: "forward")
      }

      let(:fetch) {
        -> (id) { FlightPlan.find(id) }
      }

      let(:expected_x) { 1 }
      let(:expected_y) { 1 }

      it 'updates locations correctly' do
        expect{
          subject
        }.to change { fetch.call(flight_plan.id).final_x_location }.from(nil).to(expected_x)
        .and change { fetch.call(flight_plan.id).final_y_location }.from(nil).to(expected_y)
      end
    end
  end
end
