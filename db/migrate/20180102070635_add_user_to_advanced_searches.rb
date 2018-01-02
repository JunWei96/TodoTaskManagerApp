class AddUserToAdvancedSearches < ActiveRecord::Migration[5.1]
  def change
    add_reference :advanced_searches, :user, foreign_key: true
  end
end
