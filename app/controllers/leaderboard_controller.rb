class LeaderboardController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @users = User.order(avarage_score: :desc)
  end

  def profile
    @user = User.find(params[:id])
  end
end

def nfl_leaderboard

end  
