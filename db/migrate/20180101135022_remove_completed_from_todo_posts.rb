class RemoveCompletedFromTodoPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :todo_posts, :completed
  end
end
