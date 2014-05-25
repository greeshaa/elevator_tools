# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: street_kinds
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  full_name  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class StreetKind < ActiveRecord::Base
	attr_accessible :name, :full_name
	has_many :streets
end
