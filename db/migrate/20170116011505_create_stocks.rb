class CreateStocks < ActiveRecord::Migration[5.0]
  def up
    create_table :stocks do |t|
      t.string :symbol
      t.string :name
      t.integer :shares
      t.numeric :price
      t.string :user
    end
  end
  
  def down
    drop_table :stocks
  end
end
