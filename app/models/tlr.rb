# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: tlrs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Tlr < ActiveRecord::Base
	attr_accessible :name
	has_many :lifts
end
