# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('lib', File.dirname(__FILE__))

# NOTE: とりあえず静岡
REQUEST_PARAM_PREF = '210000'
MAX_STOCK_NUM = 100_000

require 'hot_spring'
require 'pry'
require 'csv'
require 'active_support'
require 'active_support/core_ext'

client = Clients::HotSpring.new

CSV.open("tmp/hot-spring_sizuoka.csv", "a") do |csv|
  csv << Clients::HotSpring::RESPONSE_FIELDS

  1.step(MAX_STOCK_NUM, Clients::Base::JALAN_API_RESPONSE_MAX_COUNT) do |start_from|
    response = client.request!(pref: REQUEST_PARAM_PREF, start: start_from)

    hot_spring_hashs = Hash.from_xml(response.body.to_xml).dig("Results", "Onsen")
    break if hot_spring_hashs.nil?

    hot_spring_hashs.map do |hot_spring_hash|
      rows = Clients::HotSpring::RESPONSE_FIELDS.each_with_object([]) do |field, array|
        dig_path_array = field.include?('/') ? field.split('/') : [field]
        value = hot_spring_hash.dig(*dig_path_array)
        row = value.is_a?(Array) ? value.join("\n") : value.to_s

        array << row
      end

      csv << rows.flatten
    end
  end
end
