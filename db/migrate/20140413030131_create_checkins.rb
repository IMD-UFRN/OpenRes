class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.references :reservation, index: true
      t.time :begin_time
      t.time :end_time
      t.date :date

      t.timestamps
    end
  end
end
