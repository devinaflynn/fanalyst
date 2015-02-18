class LeaderboardController < ApplicationController
  def index
    @users = User.order(avarage_score: :desc)
  end
end
