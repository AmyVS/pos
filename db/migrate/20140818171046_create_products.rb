class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.column :name, :string
      t.column :price, :decimal, :precision => 8, :scale => 2
      t.column :quantity, :integer

      t.timestamps
    end
  end
end
