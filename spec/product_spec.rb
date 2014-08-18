require 'spec_helper'

describe Product do
  it 'shows a list of all products available for purchase' do
    product1 = Product.new({:name => 'snowboard', :price => 450.00, :quantity => 5})
    product1.save
    product2 = Product.new({:name => 'bindings', :price => 150.00, :quantity => 10})
    product2.save
    expect(Product.show_list).to eq ['1. snowboard: $450.0, 5','2. bindings: $150.0, 10']
  end
end
