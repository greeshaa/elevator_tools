# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: inspections
#
#  id            :integer          not null, primary key
#  lift_id       :integer
#  inspection_at :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  plained_at    :date
#

require 'spec_helper'

describe Inspection do
  pending "add some examples to (or delete) #{__FILE__}"
end
