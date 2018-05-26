Dir['./app/api/v1/*.rb'].each { |f| require f }
module TheShop
  module API
    module V1
      class Base < Grape::API
        version 'v1', using: :path
        format :json

        rescue_from Sequel::NoMatchingRow do |e|
          error!({error: 'Not found'}, 404)
        end
        
        rescue_from Sequel::ValidationFailed do |e|
          error!({error: e}, 400)
        end

        rescue_from Grape::Exceptions::ValidationErrors do |e|
          error!({error: e}, 400)
        end


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
