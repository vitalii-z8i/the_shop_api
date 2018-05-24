module TheShop
  module API
    module V1
      class Products < Grape::API
        resource :categories do
          route_param :category_id, type: Integer do
            desc "Return list of products for category"
            get :products do
              status 501
              {
                error: "Not Implemented"
              }
            end
          end
        end

        resource :products do
          desc 'Create a product'
          post do
          end

          get :popular do
            status 501
            {
              error: "Not Implemented"
            }
          end

          get :hottest do
            status 501
            {
              error: "Not Implemented"
            }
          end

          route_param :id, type: Integer do
            desc 'Return a product'
            get do
              status 501
              {
                error: "Not Implemented"
              }
            end

            desc 'Update a product'            
            patch do
              status 501
              {
                error: "Implemented"
              }
            end

            desc 'Delete a product'            
            delete do
              status 501
              {
                error: 'Not Implemented'
              }
            end

            desc 'Purchase a product'            
            post :purchase do
              status 501
              {
                error: 'Not Implemented'
              }
            end
          end
        end
      end
    end
  end
end