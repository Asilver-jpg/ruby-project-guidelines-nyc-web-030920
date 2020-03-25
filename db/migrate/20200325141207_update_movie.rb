class UpdateMovie < ActiveRecord::Migration[5.0]
  def change
    remove_column :movies, :year
    remove_column :movies, :rated
    add_column :movies, :budget, :integer
  end
end
