class TodoPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    if logged_in?
      @user = current_user
      @todo_posts = @user.search_task(params[:search]).paginate(page: params[:page])
      @todo_post = @user.todo_posts.build
    end
  end

  def create
    @user = current_user
    @todo_post = @user.todo_posts.build(todo_post_params)

    if @todo_post.save
      add_or_update_tag(@user, @todo_post)
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
      add_or_update_tag(current_user, @todo_post)
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
    params.require(:todo_post).permit(:description, :due_date, :tag_list)
  end

  def correct_user
    @todo_post = current_user.todo_posts.find_by(id: params[:id])
    redirect_to root_url if @todo_post.nil?
  end

  def add_or_update_tag(user, todo_post)
    subjects = todo_post.all_tags_list.dup
    subjects.add(params[:tag_list])
    user.tag(todo_post, with: subjects, on: :category)
  end
end
