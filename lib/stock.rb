# frozen_string_literal: true
require 'base'

module Clients
  class Stock < Base
    REQUEST_URL = 'http://jws.jalan.net/APIAdvance/StockSearch/V1/'

    RESPONSE_FIELDS = %w(
      PlanName
      RoomName
      PlanDetailURL
      Facilities/Facility
      PlanCheckIn
      PlanCheckOut
      SplyPeriodStrDay
      SplyPeriodEndDay
      PlanPictureURL
      PlanPictureCaption
      Meal
      RateType
      SampleRate
      ServiceChargeRate
      Stay/PlanDetailURL
      Stay/Date
      date
      month
      year
      Rate
      Stock
      Hotel/HotelID
      Hotel/HotelName
      Hotel/PostCode
      HotelHotelAddress
      Hotel/Area/Region
      Hotel/Area/Prefecture
      Hotel/Area/LargeArea
      Hotel/Area/SmallArea
      Hotel/HotelType
      Hotel/HotelDetailURL
      Hotel/HotelCatchCopy
      Hotel/HotelCaption
      Hotel/PictureURL
      Hotel/PictureCaption
      Hotel/X
      Hotel/Y
      Hotel/HotelNameKana
      Hotel/NumberOfRatings
      Hotel/Rating
    )

    def initialize
      super
      @endpoint_url = REQUEST_URL
    end
  end
end
