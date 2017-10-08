require 'rails_helper'

RSpec.describe User, type: :model do
   it {is_expected.to respond_to(:email) }
   it {is_expected.to respond_to(:accounts) }

   before do
     @user = User.create(email: "user@example.com", password: 123456, password_confirmation: 123456)
     @account = Account.create(balance: 100, currency: "eur", user: @user)
   end

   describe "#eur_account" do
     it "should has Account with currency: :eur" do
       expect(@user.eur_account).to eq(@account)
     end
   end

   describe "#eur_account_transactions" do
     it "should has no transactions for :eur account" do
       expect(@user.eur_account_transactions).to be
     end
   end

   describe ".all_except" do
     it "should not include defined user" do
       1.upto(5) do |n|
         User.create(email: "user#{n}@example.com")
       end
       expect(described_class.all_except(@user)).not_to include(@user)
     end
   end
end
