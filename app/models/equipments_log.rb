# == Schema Information
#
# Table name: equipments_logs
#
#  id           :integer          not null, primary key
#  equipmentlog :string(255)
#  description  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class EquipmentsLog < ActiveRecord::Base
  attr_accessible :description, :equipmentlog
end
