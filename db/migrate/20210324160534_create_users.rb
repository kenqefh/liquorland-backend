# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest
      t.string :direction, null: true
      t.integer :role, default: 0
      t.string :token

      t.timestamps
    end
    add_index :users, :token, unique: true
    add_index :users, :email, unique: true
  end
end
