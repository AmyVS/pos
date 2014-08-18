class Purchase < ActiveRecord::Base
  has_one :product
  belongs_to :checkout
end
