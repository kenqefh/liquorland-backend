class CreateSaleDrinks < ActiveRecord::Migration[6.1]
  def change
    create_table :sale_drinks do |t|
      t.references :sale, null: false, foreign_key: true
      t.references :drink, null: false, foreign_key: true
      t.integer :quantity, default: 1

      t.timestamps
    end
    add_index :sale_drinks, [:drink_id, :sale_id], unique: true
  end
end
