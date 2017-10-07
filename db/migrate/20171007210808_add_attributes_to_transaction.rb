class AddAttributesToTransaction < ActiveRecord::Migration[5.1]
  def change
     remove_column :transactions, :paid_by_user, :string
     add_column :transactions, :debit_user, :integer
     add_column :transactions, :credit_user, :integer
  end
end
