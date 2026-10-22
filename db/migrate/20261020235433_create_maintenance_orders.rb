class CreateMaintenanceOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :maintenance_orders do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.integer :kind, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.date :opened_at, null: false
      t.date :scheduled_for
      t.integer :odometer
      t.date :released_at
      t.text :description

      t.timestamps
    end
  end
end
