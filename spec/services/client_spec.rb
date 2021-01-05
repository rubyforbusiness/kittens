# frozen_string_literal: true

require 'rails_helper'
context Client do
  let(:email) { 'richard@example.com' }
  describe '#base_url' do
    subject { described_class.new(email: email).base_url }
    it 'returns a valid base url' do
      expect(URI.parse(subject).host.length).to be > 0
      expect(URI.parse(subject).path).to eq '/api'
    end
  end

  describe '#email' do
    subject { described_class.new(email: email) }
    it 'returns an email address' do
      expect(subject.email).to eq email
    end
  end

  describe '#fetch' do
    subject { described_class.new(email: email) }
    it 'responds to the method call' do
      expect(subject).to respond_to(:fetch).with(1).arguments
      expect(subject).to respond_to(:fetch).with(2).arguments
    end
  end
end
