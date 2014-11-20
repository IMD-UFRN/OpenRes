# -*- encoding : utf-8 -*-
class AddReservableToVehicle < ActiveRecord::Migration
  def change
    add_column :vehicles, :reservable, :boolean

    Vehicle.all.each do |v|
      v.reservable = true
      v.save
    end
  end
end
