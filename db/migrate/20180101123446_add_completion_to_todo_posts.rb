class AddCompletionToTodoPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :todo_posts, :completed, :boolean
    add_column :todo_posts, :completed_at, :datetime
  end
end
