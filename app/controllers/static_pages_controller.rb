class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      # for /share/todo_post_form
      @todo_post = @user.todo_posts.build
      # @user.tag(@todo_post, with: params[:tag_list], on: :category)
      # @todo_post.save
      @subjects = get_subjects
      
      # @order = params[:sort] ? params[:sort] : "created_at DESC"
      @order = get_sort_params
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

  private

  def get_subjects
    owned_tags = current_user.owned_tags
    subjects = []
    len = owned_tags.length
    i = 0
    while i < len do
      subjects << current_user.owned_tags[i].name
      i = i + 1
    end
    return subjects
  end
end
