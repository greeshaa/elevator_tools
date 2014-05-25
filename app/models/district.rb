# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: districts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class District < ActiveRecord::Base
	attr_accessible :name
	has_many :lifts
end
