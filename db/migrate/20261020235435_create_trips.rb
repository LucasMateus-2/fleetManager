class CreateTrips < ActiveRecord::Migration[8.1]
  def change
    create_table :trips do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.references :driver, null: false, foreign_key: true
      t.datetime :started_at, null: false
      t.datetime :ended_at
      t.integer :distance_km

      t.timestamps
    end
  end
end
