require 'spec_helper'

describe Purchase do
  it 'belongs to a product' do
    product = Product.create({:name => 'snowboard', :price => 450.0})
    purchase = Purchase.create({:product_id => product.id, :quantity => 1})
    expect(purchase.product).to eq product
  end

  it 'belongs to a checkout' do
    product = Product.create({:name => 'snowboard', :price => 450.0})
    checkout = Checkout.create({:customer_id => 1, :cashier_id => 1})
    purchase = Purchase.create({:product_id => product.id, :checkout_id => checkout.id, :quantity => 1})
    expect(purchase.checkout).to eq checkout
  end
end
