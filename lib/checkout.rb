class Checkout < ActiveRecord::Base
  has_many :purchases
  belongs_to :customer
  belongs_to :cashier
  has_many :products, through: :purchases
end
