class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @todo_post = current_user.todo_posts.build if logged_in?
      @user = current_user
      @todo_posts = @user.todo_posts.paginate(page: params[:page])
    end

    # if logged_in?
    #   @todo_post  = current_user.todo_posts.build
    #   @feed_items = current_user.feed.paginate(page: params[:page])
    # end
    # @user = current_user
    # @todo_posts = TodoPost.where("user_id = ?", current_user.id)
  end

  def help
  end

  def about
  end

  def contact
  end
end
