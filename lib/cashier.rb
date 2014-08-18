class Cashier < ActiveRecord::Base
  belongs_to :checkout

  def self.show_list
    cashiers = []
    Cashier.all.each_with_index do |cashier, index|
      cashiers << "#{index + 1}. #{cashier.name}"
    end
    cashiers
  end
end
