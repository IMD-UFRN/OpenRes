class CreateReservationGroups < ActiveRecord::Migration
  def change
    create_table :reservation_groups do |t|
      t.string :name
      t.text :notes
      t.integer :user_id
      t.references :user

      t.timestamps
    end
  end
end
