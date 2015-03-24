class ChargesController < ApplicationController
  def create
    byebug
    email = params[:email]

    # get or create customer
    if customer_signed_in?
      customer = current_customer
    else
      customer = Customer.find_by(email: params[:email])
      if customer.nil?
        # creates the customer
        customer = Customer.create(email: email, password: Devise.friendly_token.first(8))

        # sends an welcome message
        CustomerMailer.welcome_email(customer).deliver
      end
    end

    # Verifies if the amount to charge Amount in cents
    @subcription_user = User.find(params[:subcription_user_id])
    if @subcription_user.price != params[:price].to_f
      # something is not right ....
      # TODO: trace an error into newrelic? send a message to administrator?
      render file: '/public/500.html' and return
    end

    # se if the user already subscribed this user
    if customer.allowed?(@subcription_user)
      return redirect_to user_detail_path(@subcription_user), alert: 'You already subscribed this user'
    end

    amount = (params[:price].to_f.round(2)*100).to_i

    begin
      # TODO: ask for a user by e-mail address instead assuming that we have the stripe_customer_id
      if customer.stripe_customer_id
        stripe_customer = Stripe::Customer.retrieve(customer.stripe_customer_id)
      else
        # creates a new customer
        stripe_customer = Stripe::Customer.create(
            :email => customer.email,
            :card  => params[:stripeToken]
        )
        customer.stripe_customer_id = stripe_customer.id
      end

      charge = Stripe::Charge.create(
          :customer    => stripe_customer.id,
          :amount      => amount,
          :description => "Allows '#{@subcription_user.username}' access for 12h.",
          :currency    => 'usd'
      )
    rescue Stripe::CardError => e
      customer.save
      flash[:error] = e.message
      return redirect_to user_detail_path(@subcription_user)
    end

    customer.payments << Payment.new(
        allowed_user_id: @subcription_user.id,
        value: params[:price],
        expires_at: Time.zone.now + 12.hours)
    customer.save

    if customer_signed_in?
      redirect_to user_detail_path(@subcription_user), notice: 'Payment processed.'
    else
      redirect_to new_customer_session_path, notice: 'Payment processed. We have sent you an email. Please follow the instructions to sing in.'
    end
  end
end
