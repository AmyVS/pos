require 'spec_helper'

describe Checkout do
  it 'has many purchases' do
    product1 = Product.create({:name => 'snowboard', :price => 450.0})
    product2 = Product.create({:name => 'bindings', :price => 150.0})
    checkout = Checkout.create({:customer_id => 1, :cashier_id => 4})
    purchase1 = Purchase.create({:product_id => product1.id, :checkout_id => checkout.id, :quantity => 1})
    purchase2 = Purchase.create({:product_id => product2.id, :checkout_id => checkout.id, :quantity => 2})
    expect(checkout.purchases).to eq [purchase1, purchase2]
  end
end
