module TheShop
  module API
    module V1
      class Products < Grape::API
        resource :categories do
          route_param :category_id, type: Integer do
            desc "Return list of products for category"
            get :products do
              category = ::Category.first!(id: params[:category_id])
                                   .products.map(&:to_hash)
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
            product_params = declared(params, include_missing: false)[:product]
            product = ::Product.create(product_params)
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
              Product.where(id: params[:id]).update(views_count: (Sequel.expr(1) + :views_count))
              product = ::Product.first!(id: params[:id])
              product.to_hash
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
              product_params = declared(params, include_missing: false)[:product]
              product = ::Product.first!(id: params[:id])
              product.update(product_params)
              product.to_hash
            end

            desc 'Delete a product'            
            delete do
              product = ::Product.first!(id: params[:id]).delete
              product.to_hash
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