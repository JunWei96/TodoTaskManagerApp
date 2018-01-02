class AdvancedSearch < ApplicationRecord
  belongs_to :user, required: false

  def todo_posts
    @todo_posts ||= find_todo_posts
  end

  def completed_true?
    completed == "true"
  end

  private

  def find_todo_posts
    filtered_posts = user.todo_posts
    filtered_posts = filtered_posts.where("description like ?",
                                  "%#{description}%") if description.present?

    filtered_posts = filtered_posts.where("due_date >= ?",
                                    due_date_start) if due_date_start.present?
    filtered_posts = filtered_posts.where("due_date <= ?",
                                    due_date_end) if due_date_end.present?

    if category.present?
      filtered_posts = filtered_posts.reject { |todo_post|
        !(todo_post.category.map(&:name).include? category)
      }
    end

    if completed.present?
      filtered_posts = filtered_posts.reject { |todo_post|
        !(todo_post.completed? == completed_true?)
      }
    end

  filtered_posts
  end


end
