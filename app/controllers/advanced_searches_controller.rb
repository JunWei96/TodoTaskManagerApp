class AdvancedSearchesController < ApplicationController
  before_action :logged_in_user
  def new
    @user = current_user
    @advanced_search = @user.advanced_searches.new
  end

  def create
    @user = current_user
    # create a new entry of advanced_searches that is linked to the current_user
    @advanced_search = @user.advanced_searches.create!(search_params)
    redirect_to @advanced_search
  end

  def show
    @user = current_user
    @todo_post = @user.todo_posts.build
    # @advanced_search represents the advanced_search queries that user entered
    @advanced_search = @user.advanced_searches.find(params[:id])
    @header = "Advanced search"

    # 2 rounds of filtering are taking place here
    #
    # First is the @advanced_search.todo_posts, which uses the AdvancedSearch's
    # method called "todo_posts" to filter out the todo_posts according the queries made
    # by the user
    #
    # Next filter_task_* methods are methods by Application controller to filter out
    # todo_posts according to their categories and they are subsequently displayed.
    @todo_posts = @advanced_search.todo_posts

    @todo_posts_to_be_due = filter_tasks_to_be_due(@todo_posts).paginate(page: params[:to_be_due_page], per_page: 5)
    @todo_posts_overdue = filter_tasks_overdue(@todo_posts).paginate(page: params[:overdue_page], per_page: 5)
    @todo_posts_deferred = filter_tasks_deferred(@todo_posts).paginate(page: params[:deferred_page], per_page: 5)
    @todo_posts_completed = filter_tasks_completed(@todo_posts).paginate(page: params[:completed_page], per_page: 5)

  end

  private

  def search_params
    params.require(:advanced_search).permit(:category, :description,
                                 :due_date_start, :due_date_end, :completed)
  end
end
