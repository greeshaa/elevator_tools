# == Schema Information
#
# Table name: inspections
#
#  id                 :integer          not null, primary key
#  lift_id            :integer
#  inspection_at      :date
#  created_at         :datetime
#  updated_at         :datetime
#  next_inspection_at :date
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Inspection do
  pending "add some examples to (or delete) #{__FILE__}"
end
