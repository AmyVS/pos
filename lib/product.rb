class Product < ActiveRecord::Base
  # has_many(:checkouts)
  def self.show_list
    products = []
    Product.all.each_with_index  do |product, index|
      products << "#{index + 1}. #{product.name}: $#{product.price}, #{product.quantity}"
    end
    products
  end

end
