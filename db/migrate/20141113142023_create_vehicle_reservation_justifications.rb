# -*- encoding : utf-8 -*-
class CreateVehicleReservationJustifications < ActiveRecord::Migration
  def change
    create_table :vehicle_reservation_justifications do |t|
      t.text :reason
      t.references :vehicle_reservation

      t.timestamps
    end
    add_index :vehicle_reservation_justifications, :vehicle_reservation_id, name: "vehicle_index"
  end
end
