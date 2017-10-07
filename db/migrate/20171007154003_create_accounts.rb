class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :balance
      t.string :currency, default: :eur
      t.belongs_to :user
    end
  end
end
