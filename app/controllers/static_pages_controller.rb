class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      # for /share/todo_post_form
      @todo_post = @user.todo_posts.build
      # obtain the type of order that the user's wants on the todo_posts
      @order = get_sort_params

      # if the user clicked on any tag link, the @todo_posts will only display
      # those post with that tag.
      if params[:tag]
        @todo_posts = TodoPost.tagged_with(params[:tag],
                                owned_by: @user).order(@order).paginate(page: params[:page])
        @header = "Category: " + params[:tag]
      else
        @todo_posts = @user.todo_posts.order(@order).paginate(page: params[:page])
        @header = "TODO list(" + @user.todo_posts.count.to_s + ")"
      end
    end
  end

  def contact
  end

  def completed
    @user = current_user
    @todo_post = @user.todo_posts.build
    @todo_posts = @user.todo_posts.where.not(completed_at: nil).paginate(page: params[:page])
    @header = "Completed task".pluralize(@todo_posts.count)
  end

  def remaining
    @user = current_user
    @todo_post = @user.todo_posts.build
    @todo_posts = @user.todo_posts.where(completed_at: nil).paginate(page: params[:page])
    @header = "Remaining task".pluralize(@todo_posts.count)
  end
end
