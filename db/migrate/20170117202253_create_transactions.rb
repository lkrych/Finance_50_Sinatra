class CreateTransactions < ActiveRecord::Migration[5.0]
    def up
      create_table :transactions do |t|
        t.string :transaction
        t.datetime :date
        t.string :symbol
        t.integer :shares
        t.numeric :price
      end
    end
  
  def down
    drop_table :transaction
  end
  
end
