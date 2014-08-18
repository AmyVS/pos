class DropProductIdFromCheckouts < ActiveRecord::Migration
  def change
    remove_column :checkouts, :product_id
  end
end
