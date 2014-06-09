# -*- encoding : utf-8 -*-
class UpdateUserSectors < ActiveRecord::Migration
  def change
    User.all.each do |user|
      UserSector.create(user_id: user.id, sector_id: user.sector.id)
    end
  end
end
