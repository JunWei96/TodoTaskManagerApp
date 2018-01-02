class AdvancedSearchesController < ApplicationController
  before_action :logged_in_user
  def new
    @user = current_user
    @advanced_search = @user.advanced_searches.new
  end

  def create
    @user = current_user
    @advanced_search = @user.advanced_searches.create!(search_params)
    redirect_to @advanced_search
  end

  def show
    @user = current_user
    @todo_post = @user.todo_posts.build
    @advanced_search = @user.advanced_searches.find(params[:id])
    @todo_posts = @advanced_search.todo_posts.paginate(page: params[:page])
    @header = "Advanced search"
  end

  private

  def search_params
    params.require(:advanced_search).permit(:category, :description,
                                 :due_date_start, :due_date_end, :completed)
  end
end
