require 'rails_helper'

RSpec.describe Transaction, type: :model do
   it {is_expected.to respond_to(:account) }
   it {is_expected.to respond_to(:amount) }
   it {is_expected.to respond_to(:debit_user) }
   it {is_expected.to respond_to(:credit_user) }

end
