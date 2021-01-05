# frozen_string_literal: true

# Service for obtaining data from external APIs
class Api
  attr_reader :client

  def initialize(client)
    @client = client
  end

  def directions
    call_make_request_with_url('directions').directions
  end

  def location(x,y)
    call_make_request_with_url_body("location/#{x}/#{y}")
  end

  private

  def call_make_request_with_url(url, params = nil)
    objectify_hash(make_request(url, params)&.parsed_response)
  end

  def call_make_request_with_url_body(url, params = nil)
    make_request(url, params)&.response&.body
  end

  def objectify_hash(hash)
    OpenStruct.new hash
  end

  def make_request(url, params = nil)
    client.fetch(url, params)
  end

end


