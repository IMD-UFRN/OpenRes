# -*- encoding : utf-8 -*-
class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.date :date
      t.time :begin_time
      t.time :end_time
      t.string :status
      t.string :responsible
      t.text :reason
      t.references :reservation_group, index: true
      t.references :user, index: true
      t.references :place, index: true

      t.timestamps
    end
  end
end
