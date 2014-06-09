# -*- encoding : utf-8 -*-
class UserSector < ActiveRecord::Base
  belongs_to :user
  belongs_to :sector
end
