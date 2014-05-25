# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: experts
#
#  id         :integer          not null, primary key
#  partner_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Expert < ActiveRecord::Base
	attr_accessible :partner_id
	belongs_to :partner
	has_many :lifts
end
