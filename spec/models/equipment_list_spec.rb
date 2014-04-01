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

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
require 'spec_helper'

describe EquipmentList do
  pending "add some examples to (or delete) #{__FILE__}"
end
