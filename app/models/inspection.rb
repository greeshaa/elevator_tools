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

class Inspection < ActiveRecord::Base
  attr_accessible :inspection_at, :plained_at

  belongs_to :lift
end
