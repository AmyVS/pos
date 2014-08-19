class AddTotalToCheckouts < ActiveRecord::Migration
  def change
    add_column :checkouts, :total, :decimal, :precision => 8, :scale => 2
  end
end
