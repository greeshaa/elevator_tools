# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: nodes
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  street_id   :integer
#  build_id    :integer
#

# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Node do
  pending "add some examples to (or delete) #{__FILE__}"
end
