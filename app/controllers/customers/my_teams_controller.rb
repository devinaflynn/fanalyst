class Customers::MyTeamsController < ApplicationController
  before_action :authenticate_customer!

  layout 'application'

  def index
    @payments = current_customer.payments
  end
end
