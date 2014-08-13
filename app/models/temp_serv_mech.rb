# == Schema Information
#
# Table name: temp_serv_meches
#
#  id          :integer          not null, primary key
#  lift_id     :integer
#  mechanic_id :integer
#  start_at    :date
#  end_at      :date
#  created_at  :datetime
#  updated_at  :datetime
#

# -*- encoding : utf-8 -*-
class TempServMech < ActiveRecord::Base
	attr_accessible :lift_id, :mechanic_id, :start_at, :end_at
	belongs_to :mechanic
	belongs_to :lift
end
