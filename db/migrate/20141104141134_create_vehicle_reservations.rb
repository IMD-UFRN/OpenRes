# -*- encoding : utf-8 -*-
class CreateVehicleReservations < ActiveRecord::Migration
  def change
    create_table :vehicle_reservations do |t|

      t.date :date
      t.time :begin_time
      t.time :end_time
      t.string :status
      t.string :responsible
      t.text :reason
      t.text :passengers
      t.references :user, index: true
      t.references :vehicle, index: true
      t.references :driver, index: true

      t.timestamps
    end
  end
end
