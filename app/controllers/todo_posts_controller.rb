class TodoPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    if logged_in?
      @user = current_user
      @todo_posts = @user.search_task(params[:search]).paginate(page: params[:page])
      @todo_post = @user.todo_posts.build
      @header = "Search: " + params[:search]
    end
  end

  def create
    @user = current_user
    @todo_post = @user.todo_posts.build(todo_post_params)

    if @todo_post.save
      # add_or_update_tag(@user, @todo_post, todo_post_params["tag_list"])
      flash[:success] = "Task added!"
      # flash[:success] = @todo_post.tags.map(&:name)
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
      # add_or_update_tag(current_user, @todo_post)
      flash[:success] = "Task edited!"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    # remove_owned_tags(current_user, @todo_post)
    @todo_post.destroy
    flash[:success] = "Task deleted"
    redirect_to request.referrer || root_url
  end

  def complete
    if logged_in?
      @user = current_user
      @todo_post = @user.todo_posts.find(params[:id])
      @todo_post.touch(:completed_at)
      flash[:success] = "Task successfully completed!"
      redirect_to root_url
    end
  end

  private

  def todo_post_params
    params.require(:todo_post).permit(:description, :due_date, :tag_list)
  end

  def correct_user
    @todo_post = current_user.todo_posts.find_by(id: params[:id])
    redirect_to root_url if @todo_post.nil?
  end

  # def add_or_update_tag(user, todo_post, tag_to_add)
  #   # owned_tagged_list = todo_post.all_tags_list.dup
  #   # owned_tagged_list.add(tag_to_add)
  #   owned_tagged_list = todo_post.tags.map(&:name)
  #   user.tag(todo_post, with: owned_tagged_list.delete(tag_to_add), on: :category)
  # end
  #
  # # def add_or_update_tag(user, todo_post)
  # #   tag_list = todo_post.all_tags_list - todo_post.tag_list
  # #   tag_list += [(params[:tag_list])]
  # #   user.tag(todo_post, with: tag_list.to_s, on: :category)
  # # end
  #
  # def remove_owned_tags(user, todo_post)
  #   id_to_be_removed = todo_post.tags.ids
  #   user.owned_tag_ids = user.owned_tag_ids - id_to_be_removed
  # end

  # def add_or_update_tag(user, todo_post, tag_to_add)
  #   owned_tag_list = todo_post.all_tags_list - todo_post.tag_list
  #   owned_tag_list += [tag_to_add]
  #   user.tag(todo_post, with: owned_tag_list, on: :category)
  # end

  # def remove_owned_tags(user, todo_post)
  #   owned_tag_list = todo_post.all_tags_list - todo_post.tag_list
  #   owned_tag_list -= todo_post.tag_list
  #   user.tag(todo_post, with: owned_tag_list.to_s, on: :category)
  #   # todo_post.save
  # end
end
