# frozen_string_literal: true

require 'rails_helper'
context Api do
  let(:email) { 'ragnarcom@googlemail.com' }
  let(:client) { Client.new(email: email) }
  describe '#directions' do
    subject { described_class.new(client).directions }

    let(:directions) do
      %w[forward right forward forward forward left forward forward left right forward right forward forward right forward forward left]
    end

    it 'uses client to return expected directions' do
      expect(subject).to eq(directions)
    end
  end

  describe '#location' do
    let(:x) { 1 }
    let(:y) { 4 }
    subject { described_class.new(client).location(x,y) }

    it 'returns a response' do
      expect(subject.length).to be > 0
      puts subject
    end

  end
end
