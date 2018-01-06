class MakePayment
  attr_reader :credit_user, :debit_user, :amount

  def initialize(debit_user, credit_user, amount)
    @debit_user = debit_user
    @credit_user = credit_user
    @amount = amount
  end

  def balance_negative?
     current_balance  = Account.find_by(user_id: debit_user.id).balance
     balance = (current_balance.to_i - amount.to_i)
     if balance.zero?
       false
     else
       balance.positive? ? false : true
     end
  end

  def debit_account!
    debit_user.eur_account.debit(amount)
  end

  def credit_account!
    credit_user.eur_account.credit(amount)
  end

  def process!
    return "Insufficent funds" if (balance_negative? || amount.zero?)
    credit_user
      .eur_account_transactions
      .create(credit_user: debit_user.id, amount: amount)
    debit_user
      .eur_account_transactions
      .create(debit_user: credit_user.id, amount: amount)
    debit_account!
    credit_account!
  end

end

