class TodoPostsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy, :complete]
  before_action :correct_user,   only: [:destroy, :complete]

  def index
    @user = current_user
    # parameters of build is empty to create an new todo_post object in memory
    # so that the view can take this todo_post and display an empty form.
    @todo_post = @user.todo_posts.build
    @todo_posts = @user.search_task(params[:search]).sort_by(&:due_date).paginate(page: params[:page])
    @header = "Search: " + params[:search]
  end

  def create
    @user = current_user
    @todo_post = @user.todo_posts.build(todo_post_params)

    # saving of task will fail only when task's description is empty
    if @todo_post.save
      flash[:success] = "Task added!"
      redirect_to root_url
    else
      flash[:danger] = "Empty task!"
      redirect_to root_url
    end
  end

  def edit
    @user = current_user
    @todo_post = @user.todo_posts.find(params[:id])
    @todo_posts = @user.todo_posts.paginate(page: params[:page])
  end

  def update
    @todo_post = current_user.todo_posts.find(params[:id])

    if @todo_post.update(todo_post_params)
      flash[:success] = "Task edited!"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    @todo_post.destroy
    flash[:success] = "Task deleted"
    redirect_to request.referrer || root_url
  end

  def complete
    @user = current_user
    @todo_post = @user.todo_posts.find(params[:id])
    @todo_post.touch(:completed_at)
    flash[:success] = "Task successfully completed!"
    redirect_to root_url
  end

  private

  def todo_post_params
    params.require(:todo_post).permit(:description, :due_date, :tag_list)
  end

  def correct_user
    @todo_post = current_user.todo_posts.find_by(id: params[:id])
    redirect_to root_url if @todo_post.nil?
  end
end
