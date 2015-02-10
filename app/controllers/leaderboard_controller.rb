class LeaderboardController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id).order(avarage_score: :desc)
  end
end
