# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

puts "Populating db with Users and Accounts, please wait"

1.upto(10) do |n|
  user = User.create(email: "user_#{n}@example.com", password: 123456, password_confirmation: 123456)
  Account.create(balance: 100, currency: "eur", user_id: user.id)
end

puts "Data was populated successfully"
