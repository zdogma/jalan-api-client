# frozen_string_literal: true
require 'dotenv/load'
require 'faraday'
require 'nokogiri'

module Clients
  class Base
    JALAN_API_RESPONSE_MAX_COUNT = 100

    def initialize
      @api_key = ENV['JALAN_API_KEY']
      @connection = Faraday.new
    end

    def request!(params_hash = {})
      params = params_hash.merge(key: @api_key, count: JALAN_API_RESPONSE_MAX_COUNT)
      response = @connection.get(@endpoint_url, params)

      Response.new(response)
    end
  end

  class Response
    attr_reader :status_code, :reason_phrase, :body, :error_message

    def initialize(response)
      @status_code = response.status
      @reason_phrase = response.reason_phrase
      @body = Nokogiri::XML(response.body)
      @error_message = @body.css("Error").inner_text
    end

    def success?
      @body.css("Error").empty?
    end
  end
end
