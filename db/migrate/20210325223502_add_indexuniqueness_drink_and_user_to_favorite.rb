class AddIndexuniquenessDrinkAndUserToFavorite < ActiveRecord::Migration[6.1]
  def change
    add_index :favorites, [:user_id, :drink_id], unique: true
  end
end
