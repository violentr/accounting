class RegistrationsController < Devise::RegistrationsController

  after_action :add_account

  protected

  def add_account
    if resource.persisted? # user is created successfuly
      resource.accounts.create(balance: 100)
    end
  end
end

