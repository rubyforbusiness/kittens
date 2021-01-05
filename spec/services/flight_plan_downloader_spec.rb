# frozen_string_literal: true

require 'rails_helper'
context FlightPlanDownloader do
  describe '#download' do
    let(:email) { 'ragnarcom@googlemail.com' }
    let(:api) { double }

    subject do
      allow(api).to receive(:directions).and_return(directions)
      described_class.new(api).download
    end

    let(:directions) {
      %w[forward right]
    }

    it 'parses directions into Directions, Turns and Movements' do
      expect{
        subject
      }.to change { Direction.count }.from(0).to(2)
      .and change { Turn.count }.from(0).to(1)
      .and change { Movement.count }.from(0).to(1)
      .and change { FlightPlan.count }.from(0).to(1)
    end

    context 'Turn records' do
      subject {
        allow(api).to receive(:directions).and_return(directions)
        described_class.new(api).download
        Turn.first
      }

      it 'sets correct attributes on Turn' do
        expect(subject.right?).to be true
        expect(subject.sequence_no).to eq 1
      end
    end

    context 'Movement records' do
      subject {
        allow(api).to receive(:directions).and_return(directions)
        described_class.new(api).download
        Movement.first
      }
      it 'sets correct attributes on Movement' do
        subject
        expect(subject.forward?).to be true
        expect(subject.distance).to eq 1
        expect(subject.sequence_no).to eq 0
      end
    end

    context 'Flight Plan records' do
      subject {
        allow(api).to receive(:directions).and_return(directions)
        described_class.new(api).download
        FlightPlan.first
      }
      it 'links flight plan with directions' do
        expect(subject.directions.count).to eq directions.count
      end
    end
  end
end
