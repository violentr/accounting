require 'rails_helper'

RSpec.describe Account, type: :model do
   it {is_expected.to respond_to(:user) }
   it {is_expected.to respond_to(:transactions) }

   before do
     user = User.create(email: "user@example.com", password: 123456, password_confirmation: 123456)
     @account = Account.create(balance: 100, currency: "eur", user: user)
   end

   describe "#credit" do
     it "should be credited by certain amount" do
       @account.credit(23)
       expect(@account.balance.to_i).to eq(123)
     end
   end

   describe "#debit" do
     it "should be debited by certain amount" do
       @account.debit(23)
       expect(@account.balance.to_i).to eq(77)
     end
   end

end
