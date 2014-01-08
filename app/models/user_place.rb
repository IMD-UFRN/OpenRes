class UserPlace < ActiveRecord::Base

  validates_presence_of :code

  belongs_to :user

  delegate :sector, to: :user

end
