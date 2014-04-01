# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: equipment_lists
#
#  id                :integer          not null, primary key
#  equipment_type_id :integer
#  manufacturer      :string(255)
#  name              :string(255)
#  description       :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: equipment_lists
#
#  id                :integer          not null, primary key
#  equipment_type_id :integer
#  manufacturer      :string(255)
#  description       :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  name              :string(255)
#
class EquipmentList < ActiveRecord::Base
  attr_accessible :description, :manufacturer, :name, :equipment_type_id
  validates :name, presence: true, uniqueness: true
  belongs_to :equipment_type
  has_many :equipment
end
