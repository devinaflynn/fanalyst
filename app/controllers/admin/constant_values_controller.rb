class Admin::ConstantValuesController < ApplicationAdminController
  def edit
    @constant_value = ConstantValue.first
    if @constant_value.nil?
      @constant_value = ConstantValue.create
    end
  end

  def update
    @constant_value = ConstantValue.first
    respond_to do |format|
      if @constant_value.update(constant_value_params)
        format.html { redirect_to edit_admin_constant_value_path(@constant_value), notice: 'Constant were successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

    def constant_value_params
      params.require(:constant_value).permit(:fan_duel_median_score)
    end
end
