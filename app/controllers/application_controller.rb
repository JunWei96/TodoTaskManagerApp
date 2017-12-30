class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  around_action :user_time_zone, if: :current_user

  private

  def logged_in_user
    if !logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def user_time_zone(&block)
      Time.use_zone(current_user.time_zone, &block)
    end
end
