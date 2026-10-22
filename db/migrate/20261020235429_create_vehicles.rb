class CreateVehicles < ActiveRecord::Migration[8.1]
  def change
    create_table :vehicles do |t|
      t.string :plate, null: false
      t.string :model, null: false
      t.integer :year, null: false
      t.string :kind, null: false
      t.integer :status, null: false, default: 0
      t.integer :odometer, null: false, default: 0
      t.date :crlv_expiration
      t.date :insurance_expiration
      t.date :ipva_expiration

      t.timestamps
    end
    add_index :vehicles, :plate, unique: true
  end
end
