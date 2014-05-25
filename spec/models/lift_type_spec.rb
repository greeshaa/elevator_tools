# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: lift_types
#
#  id              :integer          not null, primary key
#  manufacturer_id :integer
#  capacity        :integer
#  function        :string(255)
#  doors           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  model           :string(255)
#  elevation       :integer
#  speed           :integer
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
require 'spec_helper'

describe LiftType do
  pending "add some examples to (or delete) #{__FILE__}"
end
