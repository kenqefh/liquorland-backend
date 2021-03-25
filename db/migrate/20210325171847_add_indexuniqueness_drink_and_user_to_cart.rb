class AddIndexuniquenessDrinkAndUserToCart < ActiveRecord::Migration[6.1]
  def change
    add_index :carts, [:user_id, :drink_id], unique: true
  end
end
