# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: equipments_sns
#
#  id           :integer          not null, primary key
#  serialnumber :string(255)
#  description  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class EquipmentsSn < ActiveRecord::Base
  attr_accessible :description, :serialnumber
end
