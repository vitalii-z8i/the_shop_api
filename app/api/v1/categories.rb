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
            category_params = declared(params, include_missing: false)[:category]
            cat = ::Category.create(category_params)
            cat.to_hash
          end

          route_param :id, type: Integer do
            desc "Update new category"
            params do
              requires :category, type: Hash do
                requires :name, type: String
              end
            end
            patch do
              category_params = declared(params, include_missing: false)[:category]
              category = ::Category.first!(id: params[:id])

              category.update(category_params)
              category.to_hash
            end

            desc "Delete a category"
            delete do
              cat = ::Category.first!(id: params[:id]).delete
              cat.to_hash
            end
          end

          desc "Return categories list by popularity of their products"
          get :popular do
            ::Category.fetch_popular.map(&:to_hash)
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