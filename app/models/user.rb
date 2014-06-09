# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  POSSIBLE_ROLES = %w(admin sector_admin secretary basic receptionist)

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name, :cpf, :role, :sector_ids
  validates_uniqueness_of :cpf

  validates_inclusion_of :role, in: POSSIBLE_ROLES

  belongs_to :sector
  has_many :reservations

  has_many :user_sectors
  has_many :sectors, through: :user_sectors

  def open_reservations
    reservations.where.status=="open"
  end

end
