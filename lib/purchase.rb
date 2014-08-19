class Purchase < ActiveRecord::Base
  belongs_to :product
  belongs_to :checkout
  has_many :cashiers, through: :checkout
end
