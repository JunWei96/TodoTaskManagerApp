class StaticPagesController < ApplicationController
	def home
    if logged_in?
      @user = current_user
      # for /share/todo_post_form
      @todo_post = @user.todo_posts.build

      if params[:tag]
        @todo_posts_to_be_due = filter_tasks_to_be_due(TodoPost.tagged_with(params[:tag], owned_by: @user)).paginate(page: params[:to_be_due_page], per_page: 5)
        @todo_posts_overdue = filter_tasks_overdue(TodoPost.tagged_with(params[:tag], owned_by: @user)).paginate(page: params[:overdue_page], per_page: 5)
        @todo_posts_deferred = filter_tasks_deferred(TodoPost.tagged_with(params[:tag], owned_by: @user)).paginate(page: params[:deferred_page], per_page: 5)
        @todo_posts_completed = filter_tasks_completed(TodoPost.tagged_with(params[:tag], owned_by: @user)).paginate(page: params[:completed_page], per_page: 5)
        @header = "Category: " + params[:tag]
      elsif params[:search]
        @todo_posts_to_be_due = filter_tasks_to_be_due(@user.search_task(params[:search])).paginate(page: params[:to_be_due_page], per_page: 5)
        @todo_posts_overdue = filter_tasks_overdue(@user.search_task(params[:search])).paginate(page: params[:overdue_page], per_page: 5)
        @todo_posts_deferred = filter_tasks_deferred(@user.search_task(params[:search])).paginate(page: params[:deferred_page], per_page: 5)
        @todo_posts_completed = filter_tasks_completed(@user.search_task(params[:search])).paginate(page: params[:completed_page], per_page: 5)
        @header = "Search: " + params[:search]
      else
        @todo_posts_to_be_due = filter_tasks_to_be_due(@user.todo_posts).paginate(page: params[:to_be_due_page], per_page: 5)
        @todo_posts_overdue = filter_tasks_overdue(@user.todo_posts).paginate(page: params[:overdue_page], per_page: 5)
        @todo_posts_deferred = filter_tasks_deferred(@user.todo_posts).paginate(page: params[:deferred_page], per_page: 5)
        @todo_posts_completed = filter_tasks_completed(@user.todo_posts).paginate(page: params[:completed_page], per_page: 5)
        @header = "TODO list(" + @user.todo_posts.count.to_s + ")"
      end
    end
  end

  def contact
  end

end
