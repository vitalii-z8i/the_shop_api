module TheShop
  module API
    module V1
      class Products < Grape::API
        resource :categories do
          route_param :category_id, type: Integer do
            desc "Return list of products for category"
            get :products do
              ::Product.where(category_id: params[:category_id]).map(&:to_hash)
            end
          end
        end

        resource :products do
          desc 'Create a product'
          params do
            requires :product, type: Hash do
              requires :name, type: String
              requires :category_id, type: Integer
              requires :price, type: Float
            end
          end
          post do
            product = ::Product.create(params[:product])
            product.to_hash
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
            params do
              requires :product, type: Hash do
                requires :name, type: String
                requires :category_id, type: Integer
                requires :price, type: Float
              end
            end        
            patch do
              product = ::Product.first(id: params[:id]).update(params[:product])
              product.to_hash
            end

            desc 'Delete a product'            
            delete do
              product = ::Product.first(id: params[:id])
              if product.respond_to?(:delete)
                product.delete
                product.to_hash
              else
                status 404
                {
                  error: 'Not found'
                }
              end
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