class Product < Sequel::Model
  many_to_one :category

  dataset_module do
    # Short format (For simple logic)
    where(:viewed_by_people, Sequel[:views_count] > 0)
    where(:purchased_by_people, Sequel[:purchases_count] > 0)
    select_append(:with_purchase_rate, Sequel.as(
      (Sequel[:purchases_count] * Sequel[100]) / Sequel[:views_count],
      :purchase_rate)
    )

    # For more complex tasks - You can use a method
    def fetch_popular
      self.with_purchase_rate
          .viewed_by_people
          .reverse_order(:purchase_rate, :purchases_count)
    end
  end

  def after_create
    super
    category.update(products_count: Sequel.expr(1) + :products_count)
  end

  def after_destroy
    super
    category.update(products_count: Sequel.expr(1) + :products_count)
  end

  # All validations goes here
  def validate
    super
    errors.add(:name, "can't be empty") if name.blank?
    errors.add(:category_id, "can't be empty") if category_id.blank?
    errors.add(:price, "can't be empty") if price.blank?
  end
end