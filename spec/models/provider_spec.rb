# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: providers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  phone      :string(255)
#  email      :string(255)
#  contact    :string(255)
#  note       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Provider do
  pending "add some examples to (or delete) #{__FILE__}"
end
