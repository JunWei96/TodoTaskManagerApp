class StaticPagesController < ApplicationController
	def home
    if logged_in?
      @user = current_user
      # for /share/todo_post_form
      @todo_post = @user.todo_posts.build

      # 2 rounds of filtering are taking place in each case where user can choose to view
      # the post in either "Filtered by tag" or "Filtered by simple search" or "Default
      # view" which has no filter.
      #
      # The first round of filtering occurs according to the type of view the user choose
      #
      # Next filter_task_* methods are methods by Application controller to filter out
      # todo_posts according to their categories and they are subsequently displayed.

      if params[:tag]
        # Filter the todo_posts according to the choose tag which are owned by @user
        @todo_posts = TodoPost.tagged_with(params[:tag], owned_by: @user);

        @todo_posts_to_be_due = filter_tasks_to_be_due(@todo_posts).paginate(page: params[:to_be_due_page], per_page: 5)
        @todo_posts_overdue = filter_tasks_overdue(@todo_posts).paginate(page: params[:overdue_page], per_page: 5)
        @todo_posts_deferred = filter_tasks_deferred(@todo_posts).paginate(page: params[:deferred_page], per_page: 5)
        @todo_posts_completed = filter_tasks_completed(@todo_posts).paginate(page: params[:completed_page], per_page: 5)
        @header = "Category: " + params[:tag]
      elsif params[:search]
        # Filter the todo_posts according to the simple search params
        @todo_posts = @user.search_task(params[:search]);

        @todo_posts_to_be_due = filter_tasks_to_be_due(@todo_posts).paginate(page: params[:to_be_due_page], per_page: 5)
        @todo_posts_overdue = filter_tasks_overdue(@todo_posts).paginate(page: params[:overdue_page], per_page: 5)
        @todo_posts_deferred = filter_tasks_deferred(@todo_posts).paginate(page: params[:deferred_page], per_page: 5)
        @todo_posts_completed = filter_tasks_completed(@todo_posts).paginate(page: params[:completed_page], per_page: 5)
        @header = "Search: " + params[:search]
      else
        # No filter is being applied, will obtain all the posts by the user
        @todo_posts = @user.todo_posts;

        @todo_posts_to_be_due = filter_tasks_to_be_due(@todo_posts).paginate(page: params[:to_be_due_page], per_page: 5)
        @todo_posts_overdue = filter_tasks_overdue(@todo_posts).paginate(page: params[:overdue_page], per_page: 5)
        @todo_posts_deferred = filter_tasks_deferred(@todo_posts).paginate(page: params[:deferred_page], per_page: 5)
        @todo_posts_completed = filter_tasks_completed(@todo_posts).paginate(page: params[:completed_page], per_page: 5)
        @header = "TODO list(" + @user.todo_posts.count.to_s + ")"
      end
    end
  end

end
