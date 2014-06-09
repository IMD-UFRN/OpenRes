# -*- encoding : utf-8 -*-
class CreateUserSector < ActiveRecord::Migration
  def change
    create_table :user_sectors do |t|
      t.integer :sector_id
      t.integer :user_id
      t.references :sector
      t.references :user
    end
  end
end
