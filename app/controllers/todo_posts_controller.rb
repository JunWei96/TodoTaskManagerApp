class TodoPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @todo_post = current_user.todo_posts.build(todo_post_params)
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

  private

  def todo_post_params
    params.require(:todo_post).permit(:subject, :description, :due_date)
  end
  def correct_user
    @todo_post = current_user.todo_posts.find_by(id: params[:id])
    redirect_to root_url if @todo_post.nil?
  end
end
