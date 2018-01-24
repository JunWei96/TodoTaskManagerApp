class AccountActivationsController < ApplicationController
  # this action will be activated when user clicked on their account activate link that
  # was being sent to their email.
  def edit
    user = User.find_by(email: params[:email])
    # if user exist and user not activated and user's credentials(meaning the activation link)
    # are correct, then go ahead and activate the user's account.
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
