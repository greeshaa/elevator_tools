# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: destinations
#
#  id         :integer          not null, primary key
#  node_id    :integer
#  lift_id    :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Destination < ActiveRecord::Base
  attr_accessible :name
  
end
