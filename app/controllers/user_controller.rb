class UserController < ApplicationController
  def index
    @user = User.find(params[:id])
    @users = []
    @results = Result.joins(:team).where('teams.user_id = ?', @user.id).order(score: :desc)
  end
end
