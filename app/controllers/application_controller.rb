class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  around_action :user_time_zone, if: :current_user

  private

  def logged_in_user
    if !logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def user_time_zone(&block)
      Time.use_zone(current_user.time_zone, &block)
  end

  def filter_tasks_to_be_due(todo_posts)
    todo_posts_to_be_due = todo_posts.where.not(due_date: nil)
    todo_posts_to_be_due = todo_posts_to_be_due.where(completed_at: nil)
    todo_posts_to_be_due = todo_posts_to_be_due.where('due_date >= ?', DateTime.now)
    return todo_posts_to_be_due
  end

  def filter_tasks_overdue(todo_posts)
    todo_posts_overdue = todo_posts.where.not(due_date: nil)
    todo_posts_overdue = todo_posts_overdue.where(completed_at: nil)
    todo_posts_overdue = todo_posts_overdue.where('due_date < ?', DateTime.now)
    return todo_posts_overdue
  end

  def filter_tasks_deferred(todo_posts)
    todo_posts_deferred = todo_posts.where(completed_at: nil)
    return todo_posts_deferred.where(due_date: nil)
  end

  def filter_tasks_completed(todo_posts)
    return todo_posts.where.not(completed_at: nil)
  end

end
