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

  it 'has many checkouts' do
    cashier = Cashier.create({:name => 'Vic'})
    checkout = Checkout.create({:customer_id => 1, :cashier_id => cashier.id})
    checkout2 = Checkout.create({:customer_id => 2, :cashier_id => cashier.id})
    expect(cashier.checkouts).to eq [checkout, checkout2]
  end

  it 'has many purchases through checkouts' do
    cashier = Cashier.create({:name => 'Vic'})
    checkout = Checkout.create({:customer_id => 1, :cashier_id => cashier.id})
    purchase1 = Purchase.create({:product_id => 1, :quantity => 2, :checkout_id => checkout.id})
    purchase2 = Purchase.create({:product_id => 2, :quantity => 3, :checkout_id => checkout.id})
    expect(cashier.purchases).to eq [purchase1, purchase2]
  end
end
