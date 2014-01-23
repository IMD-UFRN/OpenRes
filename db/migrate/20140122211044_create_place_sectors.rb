# -*- encoding : utf-8 -*-
class CreatePlaceSectors < ActiveRecord::Migration
  def change
    create_table :place_sectors do |t|
      t.integer :sector_id
      t.integer :place_id
      t.references :sector
      t.references :place
    end
  end
end
