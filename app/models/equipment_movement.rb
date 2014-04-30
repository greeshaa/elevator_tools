# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: equipment_movements
#
#  id             :integer          not null, primary key
#  destination_id :integer
#  equipment_id   :integer
#  movement       :string(255)
#  reason         :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  node_id        :integer
#

# -*- encoding : utf-8 -*-
class EquipmentMovement < ActiveRecord::Base
  attr_accessible :made_at, :movement, :reason, :destination_id, :equipment_id 
  belongs_to :user
  belongs_to :equipment
  belongs_to :destination
  belongs_to :node
end
