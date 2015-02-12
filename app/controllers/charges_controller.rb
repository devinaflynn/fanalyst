class ChargesController < ApplicationController
  def create
    byebug
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
      customer = Stripe::Customer.create(
          :email => 'current_user.email',
          :card  => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
          :customer    => customer.id,
          :amount      => amount,
          :description => 'customer',
          :currency    => 'usd'
      )
    rescue Stripe::CardError => e
      flash[:error] = e.message
      return redirect_to user_detail_path(@subcription_user)
    end

    current_user.payments << Payment.new(
        allowed_user_id: @subcription_user.id,
        value: params[:price],
        expires_at: Time.zone.now + 12.hours)

    redirect_to user_detail_path(@subcription_user), notice: 'Payment processed'
  end
end
