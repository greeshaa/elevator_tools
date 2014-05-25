# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: equipment_line_items
#
#  id                       :integer          not null, primary key
#  equipment_id             :integer
#  equipment_move_buffer_id :integer
#  created_at               :datetime
#  updated_at               :datetime
#

class EquipmentLineItem < ActiveRecord::Base
	attr_accessible :equipment_id

	belongs_to :equipment
	belongs_to :equipment_move_buffer
end
