# == Schema Information
#
# Table name: mechanics
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  foreman_id :integer
#

# -*- encoding : utf-8 -*-
class Mechanic < ActiveRecord::Base
	include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  attr_accessible :name, :foreman_id
  validates :name, presence: true, length: { minimum: 7, maximum: 24 }, uniqueness: true
  #validates :foreman_id, presence: true
  #before_save { name.capitalize! }
  has_many :lifts
  has_many :temp_serv_meches
  belongs_to :foreman
end
