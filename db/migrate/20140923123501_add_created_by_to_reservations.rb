class AddCreatedByToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :created_by_id, :integer

    Reservation.all.each do |r|

      if r.created_by.nil?
        r.created_by_id = r.user_id

        r.save
      end
    end

  end
end
