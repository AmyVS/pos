require 'spec_helper'

describe Checkout do
  it 'has many purchases' do
    checkout = Checkout.create({:customer_id => 1, :cashier_id => 4})
    purchase1 = Purchase.create({:product_id => 1, :checkout_id => checkout.id, :quantity => 1})
    purchase2 = Purchase.create({:product_id => 2, :checkout_id => checkout.id, :quantity => 2})
    expect(checkout.purchases).to eq [purchase1, purchase2]
  end

  it 'has one customer' do
    customer = Customer.create
    cashier = Cashier.create
    checkout = Checkout.create({:customer_id => customer.id, :cashier_id => cashier.id})
    expect(checkout.customer_id).to eq customer.id
  end
end
