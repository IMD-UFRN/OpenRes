class CreateReservationGroups < ActiveRecord::Migration
  def change
    create_table :reservation_groups do |t|
      t.string :name
      t.text :notes

      t.timestamps
    end
  end
end
