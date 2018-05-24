module TheShop
  module API
    module V1
      class Categories < Grape::API
        resource :categories do
          desc "Return list of hussars"
          get do
            {name: 'catrgories', resources: [1,2,3,4,5] }
          end
        end
      end
    end
  end
end