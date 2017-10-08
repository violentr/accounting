require 'rails_helper'

RSpec.describe AccountsController, type: :controller do

  before do
    @user = User.create(email: "user2@example.com", password: 123456, password_confirmation: 123456)
    Account.create(balance: 100, currency: "eur", user: @user)
    sign_in(@user)
  end

  it "should have respond as :sucess" do
    get :index
    expect(response).to have_http_status(:success)
  end

  it "should not respond as :sucess" do
    sign_out(@user)
    get :index
    expect(response).not_to have_http_status(:success)
  end

  it "should ceate a payment" do
    other_user = User.create(email: "user23@example.com", password: 123456, password_confirmation: 123456)
    Account.create(balance: 100, currency: "eur", user: other_user)

    post :make_payment, params: {user: other_user.id, transaction: {amount: 20}}
    expect(response).to have_http_status(:redirect)
  end
end
