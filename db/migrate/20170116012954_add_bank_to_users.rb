class AddBankToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :bank, :float
  end
end
