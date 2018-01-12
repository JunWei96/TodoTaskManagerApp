class SessionsController < ApplicationController
  # action for login page
  def new
  end

  # action when user submits the login form
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # check if user with the given email exist and
    # whether the given password matches the email address
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = "Account not activated."
        message += " Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  # action when user logs out
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
