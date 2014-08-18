class Checkout < ActiveRecord::Base
  has_many :purchases
  has_one :customer
end
