# frozen_string_literal: true
require 'base'

module Clients
  class Area < Base
    REQUEST_URL = 'http://jws.jalan.net/APICommon/AreaSearch/V1/'

    def initialize
      super
      @endpoint_url = REQUEST_URL
    end
  end
end
