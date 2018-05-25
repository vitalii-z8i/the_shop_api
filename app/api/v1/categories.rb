module TheShop
  module API
    module V1
      class Categories < Grape::API
        resource :categories do
          desc "Return list of categories"
          get do
            {
              categories: ::Category.map(&:as_short_json)
            }
          end

          desc "Create new category"
          params do
            requires :category, type: Hash do
              requires :name, type: String
            end
          end
          post do
            status 501
            {
              error: "Not Implemented"
            }
          end

          route_param :id, type: Integer do
            desc "Update new category"
            patch do
              status 501
              {
                error: "Not Implemented"
              }
            end

            desc "Delete a category"
            delete do
              status 501
              {
                error: "Not Implemented"
              }
            end
          end

          desc "Return categories list by popularity of their products"
          get :popular do
            status 501
            {
              error: "Not Implemented"
            }
          end

          #NOTE: Action is not required. It's here just for routing example
          # desc "Return category info"
          # params do
          #   requires :id, type: Integer            
          # end
          # get ':id' do
          #   {
          #     type: "Show ACTION"
          #   }
          # end
        end

      end
    end
  end
end