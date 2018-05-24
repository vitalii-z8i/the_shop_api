module TheShop
  class API < Grape::API
    version 'v1', using: :header, vendor: 'the_shop'

    format :json
    prefix :api

    # /api
    get do
      {
        name: 'The Shop API',
        versions: ['V1']
      }
    end
  end
end