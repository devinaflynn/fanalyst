class ResultsController < ApplicationController
  def new
    @team = current_user.teams.find(params[:team_id])
    @result = @team.build_result
  end

  def create
    @team = current_user.teams.find(params[:team_id])

    @result = Result.new(result_params)
    @result.team = @team

    # TODO: it would be interesting to have a background worker checking once a while if this results are correct
    respond_to do |format|
      if @result.save
        @current_user.avarage_sum_score+= @result.score
        @current_user.avarage_count_score+= 1
        @current_user.avarage_score = @current_user.avarage_sum_score / @current_user.avarage_count_score
        @current_user.save

        format.html { redirect_to @team, notice: 'Result was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @team = current_user.teams.find(params[:team_id])
    @result = @team.result
  end

  def update
    @team = current_user.teams.find(params[:team_id])
    @result = @team.result

    previous_score = @result.score

    respond_to do |format|
      if @result.update(result_params)
        @current_user.avarage_sum_score+= (@result.score - previous_score)
        @current_user.avarage_score = @current_user.avarage_sum_score / @current_user.avarage_count_score
        @current_user.save

        format.html { redirect_to @team, notice: 'Result was successfully updated.' }
      else
        format.html { render :edit }
      end
    end

  end

  private

  def result_params
    params.require(:result).permit(:notes, :score, :image)
  end
end
