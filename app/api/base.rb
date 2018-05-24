require './app/api/v1/base'

module TheShop
  module API
    class Base < Grape::API
      mount TheShop::API::V1::Base
    end
  end
end