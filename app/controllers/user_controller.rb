class UserController < ApplicationController
  def index
    @user = User.find(params[:id])
    @teams = nil
    if current_user && current_user.allowed?(@user)
      @teams = @user.teams
    end
    @results = Result.joins(:team).where('teams.user_id = ?', @user.id).order(created_at: :desc)
  end
end
