class Product < Sequel::Model

  def validate
    super
    errors.add(:name, "can't be empty") if name.blank?
    errors.add(:category_id, "can't be empty") if category_id.blank?
    errors.add(:price, "can't be empty") if price.blank?
  end

end