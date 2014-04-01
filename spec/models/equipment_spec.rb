# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: equipment
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  equipment_list_id :integer
#  factory_sn        :string(255)
#  installed_at      :date
#  notes             :string(255)
#  destination_id    :integer
#  node_id           :integer
#  lift_id           :integer
#

# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Equipment do
  pending "add some examples to (or delete) #{__FILE__}"
end
