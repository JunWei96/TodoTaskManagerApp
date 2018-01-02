class SetDefaultValueforTodoPosts < ActiveRecord::Migration[5.1]
  def change
    change_column :todo_posts, :completed, :boolean, default: false
  end
end
