# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: lift_types
#
#  id              :integer          not null, primary key
#  manufacturer_id :integer
#  model           :string(255)
#  function        :string(255)
#  doors           :string(255)
#  capacity        :integer
#  speed           :integer
#  elevation       :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

# -*- encoding : utf-8 -*-
class LiftType < ActiveRecord::Base
  attr_accessible :capacity, :doors, :function, :model, :speed
  
  #belongs_to :manufacturer
  #has_many :lifts
end
