# -*- encoding : utf-8 -*-
class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|

      t.string :plate
      t.string :car_model
      t.string :description
      t.integer :capacity

      t.timestamps
    end
  end
end
