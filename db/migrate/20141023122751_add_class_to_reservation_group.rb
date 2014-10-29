# -*- encoding : utf-8 -*-
class AddClassToReservationGroup < ActiveRecord::Migration
  def change
    add_column :reservation_groups, :from_class, :boolean
  end
end
