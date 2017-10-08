class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions


  def credit(amount)
    amount = self.balance.to_i + amount.to_i
    update_attributes(balance: amount)
  end

  def debit(amount)
    amount = self.balance.to_i - amount.to_i
    update_attributes(balance: amount)
  end

end
