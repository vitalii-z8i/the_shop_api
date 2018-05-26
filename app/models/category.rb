class Category < Sequel::Model
  include Models::JsonExt
  short_json_attributes :id, :name, :products_count

  one_to_many :products

  dataset_module do
    def fetch_popular
      total_purchases = Sequel.function(:sum, Sequel.qualify(:products, :purchases_count))

      self.association_join(:products)
      .select_group(Sequel.qualify(:categories, :id))
      .select(Sequel[:categories].*, Sequel.as(total_purchases, :total_purchases))
      .order(Sequel.desc(:total_purchases))
    end
  end
  one_to_many :products
end