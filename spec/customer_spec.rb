require 'spec_helper'

describe Customer do
  it 'adds a product and customer id to purchase table and adjust the products quantity' do
    patron = Customer.new
    patron.save
    product1 = Product.new({:name => 'snowboard', :price => 450.00, :quantity => 5})
    product1.save
    product2 = Product.new({:name => 'snowboard', :price => 450.00, :quantity => 5})
    product2.save
    patron.add_to_cart(product1)
    patron.add_to_cart(product2)
    expect(patron.purchases).to eq [product1, product2]
  end
end
