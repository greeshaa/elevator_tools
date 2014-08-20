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
	include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

	attr_accessible :lift_id, :mechanic_id, :start_at, :end_at
	belongs_to :mechanic
	belongs_to :lift
end
