# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: streets
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  city_id        :integer
#  street_kind_id :integer
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Street do
  pending "add some examples to (or delete) #{__FILE__}"
end
