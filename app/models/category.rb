class Category < Sequel::Model
  include Models::JsonExt
  short_json_attributes :id, :name, :products_count

  dataset_module do
    def fetch_popular
      select_append(Sequel.function(:sum, Sequel.qualify(:products, :purchase_count)))
      .join(Product.with_purchase_rate.viewed_by_people, category_id: :id)
      .order(Sequel.function(:sum, Sequel.qualify(:products, :purchase_count)).desc)
    end
  end
  one_to_many :products
end