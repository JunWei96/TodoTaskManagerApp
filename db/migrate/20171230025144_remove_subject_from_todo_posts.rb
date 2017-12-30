class RemoveSubjectFromTodoPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :todo_posts, :subject, :string
  end
end
