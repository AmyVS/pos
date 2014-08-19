require 'spec_helper'

describe Product do
  it 'shows a list of all products available for purchase' do
    product1 = Product.new({:name => 'snowboard', :price => 450.0})
    product1.save
    product2 = Product.new({:name => 'bindings', :price => 150.0})
    product2.save
    expect(Product.show_list).to eq ['1. snowboard: $450.0','2. bindings: $150.0']
  end

  it 'has many purchases' do
    product = Product.create({:name => 'snowboard', :price => 450.0})
    purchase1 = Purchase.create({:product_id => product.id, :checkout_id => 1, :quantity => 1})
    purchase2 = Purchase.create({:product_id => product.id, :checkout_id => 1, :quantity => 1})
    expect(product.purchases).to eq [purchase1, purchase2]
  end
end
