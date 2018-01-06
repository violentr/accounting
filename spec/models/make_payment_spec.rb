require 'rails_helper'

RSpec.describe MakePayment do

   before do
     @debit_user = User.create(email: "user@example.com", password: 123456, password_confirmation: 123456)
     Account.create(balance: 100, currency: "eur", user: @debit_user)
     @credit_user = User.create(email: "user2@example.com", password: 123456, password_confirmation: 123456)
     Account.create(balance: 100, currency: "eur", user: @credit_user)
     @make_payment = described_class.new(@debit_user, @credit_user, 23)
   end

   describe "#debit_account!" do
     it "should debit account, user who is paying" do
       @make_payment.debit_account!
       expect(@debit_user.eur_account.balance.to_i).to eq(77)
     end
   end

   describe "#credit_account!" do
     it "should credit account, for credit_user (who is receiving)" do
       @make_payment.credit_account!
       expect(@credit_user.eur_account.balance.to_i).to eq(123)
     end
   end

   describe "#negative_balance?" do
     context 'when amount was more then user balance' do
       it "should return true" do
         make_payment = described_class.new(@debit_user, @credit_user, 120)
         expect(make_payment.balance_negative?).to eq(true)
       end
     end

     context 'when amount was blank or 0' do
       it "should return false" do
         make_payment = described_class.new(@debit_user, @credit_user, '')
         expect(make_payment.balance_negative?).to eq(false)
       end
     end
     context 'when amount was same as user balance' do
       it "should return false" do
         make_payment = described_class.new(@debit_user, @credit_user, 100)
         expect(make_payment.balance_negative?).to eq(false)
       end
     end
   end

   describe "#process!" do
     it "should create transactions, for current payment" do
       @make_payment.process!
       expect(@debit_user.eur_account_transactions.first.debit_user).to eq(@credit_user.id)
       expect(@credit_user.eur_account_transactions.first.credit_user).to eq(@debit_user.id)
     end

     it 'credit_user should be paid by debit_user' do
       @make_payment.process!
       expect(@credit_user.eur_account.balance.to_i).to eq(123)
       expect(@credit_user.eur_account_transactions.count).to eq(1)
       expect(@debit_user.eur_account.balance.to_i).to eq(77)
       expect(@debit_user.eur_account_transactions.count).to eq(1)
     end
   end

end
