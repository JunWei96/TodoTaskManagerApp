class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      # for /share/todo_post_form
      @todo_post = @user.todo_posts.build
      # @user.tag(@todo_post, with: params[:tag_list], on: :category)
      # @todo_post.save
      @subjects = get_subjects
      if params[:tag]
        @todo_posts = TodoPost.tagged_with(params[:tag],
                                owned_by: @user).paginate(page: params[:page])
        @header = "Category: " + params[:tag]
      else
        @todo_posts = @user.todo_posts.paginate(page: params[:page])
        @header = "TODO list(" + @user.todo_posts.count.to_s + ")"
      end
    end
  end

  def contact
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
