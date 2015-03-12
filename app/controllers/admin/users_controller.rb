class Admin::UsersController < ApplicationAdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    @user = User.new

    # search
    if params[:user]
      @user = User.new(user_search_params)
      if !@user.email.empty?
        @users = @users.where("email like ?", "%#{@user.email}%")
      end

      if !@user.username.empty?
        @users = @users.where("username like ?", "%#{@user.username}%")
      end

      if @user.price != nil
        @users = @users.where(price: @user.price)
      end
    end

    @users = @users.paginate(:page => params[:page])  
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    respond_to do |format|
      if @user.update(user_search_params)
        format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

    def user_search_params
      params.require(:user).permit(:email, :username, :price)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end
