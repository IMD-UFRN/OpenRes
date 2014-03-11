# -*- encoding : utf-8 -*-
class Justification < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :reservation_group
  belongs_to :user
end
