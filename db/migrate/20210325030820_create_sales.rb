class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total, default: 0
      t.string :code

      t.timestamps
    end
  end
end
