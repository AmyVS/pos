require 'spec_helper'

describe Customer do
  it 'belongs to a checkout' do
    customer = Customer.create
    checkout = Checkout.create({:customer_id => customer.id, :cashier_id => 4})
    expect(checkout.customer_id).to eq customer.id
  end
end
