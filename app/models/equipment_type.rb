# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: equipment_types
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# -*- encoding : utf-8 -*-
class EquipmentType < ActiveRecord::Base
  attr_accessible :description, :name
  validates :name, presence: true, uniqueness: true
  has_many :equipment_lists
end
