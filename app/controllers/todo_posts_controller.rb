class TodoPostsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy, :complete]
  before_action :correct_user,   only: [:destroy, :complete]

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
    @todo_posts_to_be_due = filter_tasks_to_be_due(@user.todo_posts).paginate(page: params[:to_be_due_page], per_page: 5)
    @todo_posts_overdue = filter_tasks_overdue(@user.todo_posts).paginate(page: params[:over_due_page], per_page: 5)
    @todo_posts_deferred = filter_tasks_deferred(@user.todo_posts).paginate(page: params[:deferred_page], per_page: 5)
    @todo_posts_completed = filter_tasks_completed(@user.todo_posts).paginate(page: params[:completed_page], per_page: 5)
    @header = "TODO list(" + @user.todo_posts.count.to_s + ")"
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
    respond_to do |format|
        format.html { redirect_to root_url }
        format.js
    end
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

  # make sure the todo_post belongs to its respective owners
  def correct_user
    @todo_post = current_user.todo_posts.find_by(id: params[:id])
    redirect_to root_url if @todo_post.nil?
  end
end
