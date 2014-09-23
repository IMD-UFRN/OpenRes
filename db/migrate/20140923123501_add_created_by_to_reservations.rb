class AddCreatedByToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :created_by_id, :integer
  end
end
