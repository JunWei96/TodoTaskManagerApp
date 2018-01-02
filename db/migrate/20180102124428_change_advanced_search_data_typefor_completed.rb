class ChangeAdvancedSearchDataTypeforCompleted < ActiveRecord::Migration[5.1]
  def change
    change_column :advanced_searches, :completed, :string
  end
end
