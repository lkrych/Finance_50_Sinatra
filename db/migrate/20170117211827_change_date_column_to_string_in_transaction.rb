class ChangeDateColumnToStringInTransaction < ActiveRecord::Migration[5.0]
  def change
    change_column :transactions, :date, :string
  end
end
