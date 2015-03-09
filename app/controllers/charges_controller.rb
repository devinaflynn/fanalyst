class ChargesController < ApplicationSignedInController
  def create
    # Amount in cents
    @subcription_user = User.find(params[:subcription_user_id])
    if @subcription_user.price != params[:price].to_f
      # something is not right ....
      render file: '/public/500.html' and return
    end

    # se if the user already subscribed this user
    if current_user.allowed?(@subcription_user)
      return redirect_to user_detail_path(@subcription_user), alert: 'You already subscribed this user'
    end

    amount = (params[:price].to_f.round(2)*100).to_i

    begin
      # TODO: ask for a user by e-mail address instead assuming that we have the stripe_customer_id
      if current_user.stripe_customer_id
        customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
      else
        # creates a new customer
        customer = Stripe::Customer.create(
            :email => current_user.email,
            :card  => params[:stripeToken]
        )
        current_user.stripe_customer_id = customer.id
      end

      charge = Stripe::Charge.create(
          :customer    => customer.id,
          :amount      => amount,
          :description => "Allows '#{@subcription_user.username}' access for 12h.",
          :currency    => 'usd'
      )
    rescue Stripe::CardError => e
      current_user.save
      flash[:error] = e.message
      return redirect_to user_detail_path(@subcription_user)
    end

    current_user.payments << Payment.new(
        allowed_user_id: @subcription_user.id,
        value: params[:price],
        expires_at: Time.zone.now + 12.hours)
    current_user.save

    redirect_to user_detail_path(@subcription_user), notice: 'Payment processed'
  end
end
