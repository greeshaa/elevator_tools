# == Schema Information
#
# Table name: equipments_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EquipmentsGroup < ActiveRecord::Base
  attr_accessible :name
end
