class EquipmentLineItem < ActiveRecord::Base
	attr_accessible :equipment_id

	belongs_to :equipment
	belongs_to :equipment_move_buffer
end
