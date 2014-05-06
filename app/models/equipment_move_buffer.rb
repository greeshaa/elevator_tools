class EquipmentMoveBuffer < ActiveRecord::Base
	has_many :equipment_line_items, dependent: :destroy
end
