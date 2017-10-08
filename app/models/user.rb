class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 has_many :accounts
 scope :all_except, ->(user) { where.not(id: user).map{|u|  [u.email, u.id]} }

 def eur_account
   accounts.first
 end

 def eur_account_transactions
   eur_account.transactions
 end
end
