# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: equipment_movements
#
#  id           :integer          not null, primary key
#  equipment_id :integer
#  movement     :string(255)
#  reason       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  user_id      :integer
#  node_id      :integer
#  porch_id     :integer
#  build_id     :integer
#  street_id    :integer
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
require 'spec_helper'

describe EquipmentMovement do
  pending "add some examples to (or delete) #{__FILE__}"
end
