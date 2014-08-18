require 'spec_helper'

describe Cashier do

  it 'belongs to a checkout' do
    cashier = Cashier.create({:name => 'Vic'})
    checkout = Checkout.create({:customer_id => 2, :cashier_id => cashier.id})
    expect(checkout.cashier_id).to eq cashier.id
  end

  it 'shows a list of all cashiers' do
    cashier1 = Cashier.new({:name => 'Vic'})
    cashier1.save
    cashier2 = Cashier.new({:name => 'Jane'})
    cashier2.save
    expect(Cashier.show_list).to eq ['1. Vic','2. Jane']
  end
end
