class AddColumnToDrinks < ActiveRecord::Migration[6.1]
  def change
    add_column :drinks, :reviews_count, :integer, default: 0
  end
end
