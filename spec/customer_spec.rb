require 'spec_helper'

describe Customer do
  it 'has many checkouts' do
    customer = Customer.create
    checkout1 = Checkout.create({:customer_id => customer.id, :cashier_id => 4})
    checkout2 = Checkout.create({:customer_id => customer.id, :cashier_id => 4})
    expect(customer.checkouts).to eq [checkout1, checkout2]
  end
end
