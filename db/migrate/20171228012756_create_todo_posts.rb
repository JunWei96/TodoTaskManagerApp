class CreateTodoPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :todo_posts do |t|
      t.string :subject
      t.text :description
      t.datetime :due_date
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :todo_posts, [:user_id, :created_at]
  end
end
