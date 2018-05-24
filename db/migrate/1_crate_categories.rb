Sequel.migration do
  up do
    create_table(:categories) do
      primary_key :id
      String :name, null: false
      Integer :products_count, default: 0
      Timestamp :created_at, null: false
      Timestamp :updated_at, null: false
    end
  end

  down do
    drop_table(:categories)
  end
end
