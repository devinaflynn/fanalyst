class CustomerMailer < ApplicationMailer
  def welcome_email(customer)
    @customer = customer
    @url  = new_customer_session_url
    mail(to: customer.email, subject: 'Welcome to fanalyst website')
  end
end
