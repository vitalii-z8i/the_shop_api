Sequel.migration do
  up do
    create_table(:products) do
      primary_key :id
      String :name, null: false
      Integer :category_id, null: false
      Integer :views_count, default: 0 
      Integer :purchases_count, default: 0 
      Timestamp :created_at, null: false
      Timestamp :updated_at, null: false
    end
    add_index(:products, :category_id)
    alter_table(:products){ add_foreign_key([:category_id], :categories) }
  end

  down do
    drop_table(:products)
  end
end
