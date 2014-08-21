# -*- encoding : utf-8 -*-
class AddConfirmedAtToReservationGroup < ActiveRecord::Migration
  def change
    add_column :reservation_groups, :confirmed_at, :datetime

    ReservationGroup.all.each do |rg|
      rg.confirmed_at = DateTime.now
      rg.save
    end
  end
end
