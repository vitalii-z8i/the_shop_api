class Category < Sequel::Model
  include Models::JsonExt
  short_json_attributes :id, :name, :products_count

  one_to_many :products
end