module MyTeamsHelper
  def state(payment)
    if payment.expires_at > Time.zone.now
      "active till #{payment.expires_at.strftime("%l:%M %P")}"
    else
      "expired"
    end
  end
end
