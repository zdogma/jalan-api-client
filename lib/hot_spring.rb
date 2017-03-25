# frozen_string_literal: true
require 'base'

module Clients
  class HotSpring < Base
    REQUEST_URL = 'http://jws.jalan.net/APICommon/OnsenSearch/V1/'

    RESPONSE_FIELDS = %w(
      OnsenName
      OnsenNameKana
      OnsenID
      OnsenAddress
      Area/Region
      Area/Prefecture
      Area/LargeArea
      Area/SmallArea
      NatureOfOnsen
      OnsenAreaName
      OnsenAreaNameKana
      OnsenAreaID
      OnsenAreaURL
      OnsenAreaCaption
    )

    def initialize
      super
      @endpoint_url = REQUEST_URL
    end
  end
end
