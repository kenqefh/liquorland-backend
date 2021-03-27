class AddColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :birth_date, :date
  end
end
