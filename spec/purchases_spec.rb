require 'spec_helper'

describe Purchase do
  it 'has a product' do
    product = Product.create({:name => 'snowboard', :price => 450.0})
    purchase = Purchase.create({:product_id => product.id, :quantity => 1})
    expect(purchase.product_id).to eq product.id
  end
end
