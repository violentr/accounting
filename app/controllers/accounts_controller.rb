class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
    @account = current_user.eur_account
  end

  def make_payment
    amount = params["transaction"]["amount"].to_i
    credit_user = User.find_by(id: params["user"].to_i)
    ::MakePaymentService.new(current_user, credit_user, amount).process!

    redirect_to root_path
  end
end
