# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: elevator_control_stations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# -*- encoding : utf-8 -*-
class ElevatorControlStation < ActiveRecord::Base
  attr_accessible :name
  has_many :lift
end
