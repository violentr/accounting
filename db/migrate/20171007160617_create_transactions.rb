class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :amount
      t.string :paid_by_user
      t.belongs_to :account
      t.timestamps
    end
  end
end
