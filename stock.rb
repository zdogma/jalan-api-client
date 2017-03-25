# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('lib', File.dirname(__FILE__))

# NOTE: とりあえず静岡
REQUEST_PARAM_PREF = '210000'
MAX_STOCK_NUM = 100_000

require 'stock'
require 'pry'
require 'csv'
require 'active_support'
require 'active_support/core_ext'

client = Clients::Stock.new

CSV.open("tmp/stock_sizuoka.csv", "a") do |csv|
  csv << Clients::Stock::RESPONSE_FIELDS

  1.step(MAX_STOCK_NUM, Clients::Base::JALAN_API_RESPONSE_MAX_COUNT) do |start_from|
    response = client.request!(pref: REQUEST_PARAM_PREF, start: start_from)

    stock_hashs = Hash.from_xml(response.body.to_xml).dig("Results", "Plan")
    break if stock_hashs.nil?

    stock_hashs.map do |stock_hash|
      rows = Clients::Stock::RESPONSE_FIELDS.each_with_object([]) do |field, array|
        dig_path_array = field.include?('/') ? field.split('/') : [field]
        value = stock_hash.dig(*dig_path_array)
        row = value.is_a?(Array) ? value.join("\n") : value.to_s

        array << row
      end

      csv << rows.flatten
    end
  end
end
