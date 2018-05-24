Dir['./app/api/v1/*.rb'].each { |f| require f }
module TheShop
  module API
    module V1
      class Base < Grape::API
        version 'v1', using: :path
        format :json

        get do
          {
            name: 'The Shop API',
            version: 'v1',
            created: Time.parse('2018-05-24 00:00')
          }
        end

        mount TheShop::API::V1::Categories
        mount TheShop::API::V1::Products
      end
    end
  end
end
