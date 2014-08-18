class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.column :product_id, :integer
      t.column :checkout_id, :integer
      t.column :quantity, :integer
    end
  end
end
