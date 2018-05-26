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
            Product.limit(25).fetch_popular.map(&:to_hash)
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
              updated_count = Product.where(id: params[:id]).update(purchases_count: (Sequel.expr(1) + :purchases_count))
              raise Sequel::NoMatchingRow unless updated_count > 0
              updated_count
            end

            post :track_view do
              updated_count = Product.where(id: params[:id]).update(views_count: (Sequel.expr(1) + :views_count))
              raise Sequel::NoMatchingRow unless updated_count > 0
              updated_count
            end
          end
        end
      end
    end
  end
end