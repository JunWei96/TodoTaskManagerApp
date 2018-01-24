class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :index]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :admin_user, only: [:index, :destroy]

  # Action that is only used by admin, do view a list of users
  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  # To view the profile of individual user
  def show
    @user = User.find(params[:id])
    redirect_to root_url and return if (!@user.activated?)
    @todo_posts = @user.todo_posts.paginate(page: params[:page])
  end

  # Used for signup page
  def new
    @user = User.new
  end

  # Action triggered when user click on submit button on signup page.
  def create
    @user = User.new(user_params)
    # If the information keyed in are valid, send activation link to user's email
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new' # else render the signup page, displaying the errors detected
    end
  end

  # Action triggered when user wants to edit its own profile
  def edit
    @user = User.find(params[:id])
  end

  # Action will trigger when user click on the submit button on edit profile page
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # To destroy user account and all its related data, used by admin.
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :time_zone)
  end

  # Ensure the current user is only able to make changes to its own profile. Except for admin.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) if (!current_user?(@user) && !current_user.admin?)
  end

  # Ensure only admins have access to admin privileges
  def admin_user
    redirect_to(root_url) if !(current_user && current_user.admin?)
  end
end
