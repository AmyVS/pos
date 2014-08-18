class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
      t.column :customer_id, :integer
      t.column :cashier_id, :integer
      t.column :product_id, :integer

      t.timestamps
    end
  end
end
