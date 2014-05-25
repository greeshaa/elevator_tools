# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: equipment_move_buffers
#
#  id           :integer          not null, primary key
#  equipment_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class EquipmentMoveBuffer < ActiveRecord::Base
	has_many :equipment_line_items, dependent: :destroy
end
