require './config/boot'

Product.where(Sequel[:purchases_count] > 0 && Sequel[:views_count] > 0).update(purchases_count: 0, views_count: 0)
# VIEWS_COUNT preset
450.times do |time|
  Product.order(Sequel.function(:RANDOM)).limit(5).each { |r|
    r.update(views_count: Sequel.expr(rand(60)) + :views_count)
  }
end

# PURCHASE_COUNT preset
200.times do |time|
  Product.order(Sequel.function(:RANDOM)).limit(5).each { |r|
    r.update(purchases_count: Sequel.expr(rand(25)) + :purchases_count)
  }
end

Product.where(Sequel[:purchases_count] > Sequel[:views_count]).update(purchases_count: :views_count)