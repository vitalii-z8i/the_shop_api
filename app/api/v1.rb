module TheShop
  class API < Grape::API
    class V1 < Grape::API
      version 'v1', using: :path

      get do
        {name: 'The Shop API', version: 1}
      end
    end
  end
end