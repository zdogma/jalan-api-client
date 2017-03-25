# frozen_string_literal: true
require 'base'

module Clients
  class Hotel < Base
    REQUEST_URL = 'http://jws.jalan.net/APIAdvance/HotelSearch/V1/'

    RESPONSE_FIELDS = %w(
      HotelID
      HotelName
      PostCode
      HotelAddress
      Area/Region
      Area/Prefecture
      Area/LargeArea
      Area/SmallArea
      HotelType
      HotelDetailURL
      HotelCatchCopy
      HotelCaption
      PictureURL
      PictureCaption
      AccessInformation
      CheckInTime
      CheckOutTime
      X
      Y
      SampleRateFrom
      LastUpdate/day
      LastUpdate/month
      LastUpdate/year
      OnsenName
      HotelNameKana
      CreditCard/AMEX
      CreditCard/DC
      CreditCard/DINNERS
      CreditCard/ETC
      CreditCard/JCB
      CreditCard/MASTER
      CreditCard/MILLION
      CreditCard/NICOS
      CreditCard/SAISON
      CreditCard/UC
      CreditCard/UFJ
      CreditCard/VISA
      NumberOfRatings
      Rating
      WifiHikariStation
      JJPReferenceFlag
      AJPReferenceFlag
      NTAReferenceFlag
      Plan/PlanName
      Plan/PlanCD
      Plan/RoomType
      Plan/RoomName
      Plan/RoomCD
      Plan/PlanCheckIn
      Plan/PlanCheckOut
      Plan/PlanDetailURL
      Plan/PlanPictureURL
      Plan/PlanPictureCaption
      Plan/Meal
      Plan/PlanSampleRateFrom
    )

    def initialize
      super
      @endpoint_url = REQUEST_URL
    end
  end
end
