class Product < ActiveRecord::Base
  has_many :purchases

  def self.show_list
    products = []
    Product.all.each_with_index  do |product, index|
      products << "#{index + 1}. #{product.name}: $#{product.price}"
    end
    products
  end

end
