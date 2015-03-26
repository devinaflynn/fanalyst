class UserController < ApplicationController
  def index
    @user = User.find(params[:id])

    @teams = nil

    #  to see an user team, we need a customer allowed.
    if current_customer && current_customer.allowed?(@user)
      @teams = @user.teams.where('created_at >= ?', Time.zone.now - 1.day)
    end

    # everyone can see the
    results = Result.joins(:team).where('teams.user_id = ?', @user.id).order(created_at: :desc)

    # TODO: improve performance
    @result_views = []
    results.each_slice(3) { |a| @result_views << a }
  end
end


class ResultView
  def initialize(image_url, score, notes)
    @image_url = image_url
    @score = score
    @notes = notes
  end
end




# image_tag result.image(:medium)
# result.score.round(1)
# result.notes %></h5>
