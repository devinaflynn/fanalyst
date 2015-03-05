class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :profile_image
    devise_parameter_sanitizer.for(:account_update) << :bio
    devise_parameter_sanitizer.for(:account_update) << :sport_list
    devise_parameter_sanitizer.for(:account_update) << :favorite_team_list
  end

  def after_sign_in_path_for(resource)
    leaderboard_path
  end

end
