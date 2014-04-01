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
  attr_accessible :name
  has_many :lifts
end
