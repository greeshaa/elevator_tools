# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: mechanics
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Mechanic < ActiveRecord::Base
  attr_accessible :name, :foremen_id
  validates :name, presence: true, length: { minimum: 7, maximum: 24 }, uniqueness: true
  validates :foremen_id, presence: true
  #before_save { name.capitalize! }
  has_many :lifts
  has_many :temp_serv_meches
  belongs_to :foreman
end
