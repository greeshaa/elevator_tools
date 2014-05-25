# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: equipment
#
#  id                :integer          not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  equipment_list_id :integer
#  factory_sn        :string(255)
#  installed_at      :date
#  notes             :string(255)
#  porch_id          :integer
#  broken            :boolean          default(FALSE)
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Equipment do
  pending "add some examples to (or delete) #{__FILE__}"
end
