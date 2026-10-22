class CreateFuelings < ActiveRecord::Migration[8.1]
  def change
    create_table :fuelings do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.date :date, null: false
      t.decimal :liters, null: false, precision: 8, scale: 2
      t.decimal :cost, null: false, precision: 10, scale: 2
      t.integer :odometer, null: false

      t.timestamps
    end
  end
end
