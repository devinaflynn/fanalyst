class ResultsController < ApplicationSignedInController
  def new
    @team = current_user.teams.find(params[:team_id])
    @result = @team.build_result
  end

  def create
    @team = current_user.teams.find(params[:team_id])

    # TODO: it would be interesting to have a background worker checking once a while if this results are correct
    respond_to do |format|
      if @team.create_or_update_result(result_params)
        format.html { redirect_to @team, notice: 'Result was successfully created.' }
      else
        @result = @team.result
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

    respond_to do |format|
      if @team.create_or_update_result(result_params)
        format.html { redirect_to @team, notice: 'Result was successfully updated.' }
      else
        @result = @team.result
        format.html { render :edit }
      end
    end

  end

  private

  def result_params
    params.require(:result).permit(:notes, :score, :image)
  end
end
