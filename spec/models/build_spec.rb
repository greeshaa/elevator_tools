# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: builds
#
#  id          :integer          not null, primary key
#  street_id   :integer
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  node_id     :integer
#  porch_count :integer
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Build do
  pending "add some examples to (or delete) #{__FILE__}"
end
