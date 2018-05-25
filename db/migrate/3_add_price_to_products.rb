Sequel.migration do
  up do
    add_column(:products, :price, Float)
  end
  
  down do
    drop_column(:products, :price)
  end
end
