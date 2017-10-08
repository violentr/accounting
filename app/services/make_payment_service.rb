class MakePaymentService
  attr_reader :credit_user, :debit_user, :amount

  def initialize(debit_user, credit_user, amount)
    @debit_user = debit_user
    @credit_user = credit_user
    @amount = amount
  end

  def create_credit_transaction
    Transaction.create(credit_user: debit_user.id, amount: amount)
  end

  def create_debit_transaction
    Transaction.create(debit_user: credit_user.id, amount: amount)
  end

  def debit_account!
    debit_user.eur_account.debit(amount)
  end

  def credit_account!
    credit_user.eur_account.credit(amount)
  end

  def process!
    credit_user.eur_account_transactions << create_credit_transaction
    debit_user.eur_account_transactions << create_debit_transaction
    debit_account!
    credit_account!
  end

end

