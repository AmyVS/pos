require 'spec_helper'

describe Cashier do

  it 'belongs to a checkout' do
    cashier = Cashier.create({:name => 'Vic'})
    checkout = Checkout.create({:customer_id => 2, :cashier_id => cashier.id})
    expect(checkout.cashier_id).to eq cashier.id
  end

end
