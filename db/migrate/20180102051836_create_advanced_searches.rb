class CreateAdvancedSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :advanced_searches do |t|
      t.string :category
      t.string :description
      t.datetime :due_date_start
      t.datetime :due_date_end
      t.boolean :completed

      t.timestamps
    end
  end
end
