class CreateDrivers < ActiveRecord::Migration[8.1]
  def change
    create_table :drivers do |t|
      t.string :name, null: false
      t.string :cnh, null: false
      t.date :cnh_expiration, null: false
      t.references :vehicle, null: true, foreign_key: true

      t.timestamps
    end
    add_index :drivers, :cnh, unique: true
  end
end
