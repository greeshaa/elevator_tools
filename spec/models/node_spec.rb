# == Schema Information
#
# Table name: nodes
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  street_id   :integer
#  build_id    :integer
#  porch_id    :integer
#  dataport    :integer
#  soundport   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Node do
  pending "add some examples to (or delete) #{__FILE__}"
end
