class ApplicationController < ActionController::Base
  layout :layout_by_resource

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
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope === :customer || resource_or_scope.kind_of?(Customer)
      new_customer_session_path
    elsif resource_or_scope === :user || resource_or_scope.kind_of?(User)
      root_path
    elsif resource_or_scope === :admin || resource_or_scope.kind_of?(Admin)
      new_admin_session_path
    else
      super
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope === :customer || resource_or_scope.kind_of?(Customer)
      customers_my_teams_path
    elsif resource_or_scope === :user || resource_or_scope.kind_of?(User)
      leaderboard_path
    elsif resource_or_scope === :admin || resource_or_scope.kind_of?(Admin)
      admin_users_path
    else
      super
    end
  end

  def layout_by_resource
    if controller_name == 'leaderboard'
      'application'
    elsif controller_name == 'user' && action_name=='index'
      'application'
    elsif devise_controller? && resource_name == :admin
      "admin"
    elsif devise_controller? && resource_name == :user
      "application"
    elsif devise_controller? && resource_name == :customer
      "application"
    else
      "frontend"
    end
  end
end
