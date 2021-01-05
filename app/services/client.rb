# frozen_string_literal: true

require 'httparty'
# Class for calling http services
class Client
  attr_reader :base_url, :email

  REQUEST_METHOD = 'get'

  def initialize(email:)
    @base_url = Rails.configuration.client['base_url']
    @email = email
    @httparty_options = {
      format: :json,
    }
  end

  def fetch(route, params = nil)
    return nil unless @base_url.present?

    url = URI("#{@base_url}/#{email}/#{route}")
    if params.present?
      url.query = params.to_query
    end
    HTTParty.send(REQUEST_METHOD, url.to_s, @httparty_options)
  end
end
