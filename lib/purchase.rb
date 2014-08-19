class Purchase < ActiveRecord::Base
  has_one :product
  belongs_to :checkout
  has_many :cashiers, through: :checkout
end
