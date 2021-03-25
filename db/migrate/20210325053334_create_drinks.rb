class CreateDrinks < ActiveRecord::Migration[6.1]
  def change
    create_table :drinks do |t|
      t.string :name
      t.string :presentation
      t.text :description
      t.decimal :price
      t.integer :stock
      t.decimal :alcohol_grades
      t.references :brand, null: false, foreign_key: true
      t.references :style, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
