class LeaderboardController < ApplicationController
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

def faq

end  
