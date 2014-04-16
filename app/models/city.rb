# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class City < ActiveRecord::Base
	attr_accessible :name
	validates :name, presence: true, uniqueness: {case_sensitive: false}, length: { minimum: 5 }
	
	has_many :streets
end
