# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('lib', File.dirname(__FILE__))

# NOTE: とりあえず静岡
REQUEST_PARAM_PREF = '210000'
MAX_HOTEL_NUM = 10_000

require 'hotel'
require 'pry'
require 'csv'
require 'active_support'
require 'active_support/core_ext'

client = Clients::Hotel.new

CSV.open("tmp/sizuoka.csv", "a") do |csv|
  csv << Clients::Hotel::RESPONSE_FIELDS

  1.step(MAX_HOTEL_NUM, Clients::Base::JALAN_API_RESPONSE_MAX_COUNT) do |start_from|
    response = client.request!(pref: REQUEST_PARAM_PREF, start: start_from)

    hotel_hashs = Hash.from_xml(response.body.to_xml).dig("Results", "Hotel")
    break if hotel_hashs.nil?

    hotel_hashs.map do |hotel_hash|
      rows = Clients::Hotel::HOTEL_RESPONSE_FIELDS.each_with_object([]) do |field, array|
        dig_path_array = field.include?('/') ? field.split('/') : [field]
        value = hotel_hash.dig(*dig_path_array)
        row = value.is_a?(Array) ? value.join("\n") : value.to_s

        array << row
      end

      csv << rows.flatten
    end
  end
end
