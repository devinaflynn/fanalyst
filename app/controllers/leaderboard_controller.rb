class LeaderboardController < ApplicationController
  before_action :authenticate_user!, except: [:index, :pricing, :jobs, :profile, :nfl_leaderboard, :mlb_leaderboard, :nhl_leaderboard, :march_madness_leaderboard, :soccer_leaderboard]

  def index
    @users = User.order(avarage_score: :desc)
  end

  def profile
    @user = User.find(params[:id])
  end
end

def nfl_leaderboard

end 


def jobs

end

def pricing

end  

def player_news_nba

end  
