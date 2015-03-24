class UserController < ApplicationController
  def index
    @user = User.find(params[:id])

    @teams = nil

    #  to see an user team, we need a customer allowed.
    if current_customer && current_customer.allowed?(@user)
      @teams = @user.teams.where('created_at >= ?', Time.zone.now - 1.day)
    end

    # everyone can see the
    @results = Result.joins(:team).where('teams.user_id = ?', @user.id).order(created_at: :desc)
  end
end
