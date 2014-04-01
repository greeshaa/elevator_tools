# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: contracts
#
#  id         :integer          not null, primary key
#  partner_id :integer
#  number     :string(255)
#  signed_at  :date
#  lifetime   :date
#  note       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Contract do
  pending "add some examples to (or delete) #{__FILE__}"
end
