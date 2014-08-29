# -*- encoding : utf-8 -*-
class TimeSheet < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: Proc.new{ |controller, model| controller.current_user }
	attr_accessible :time_sheet_kind_id, :mechanic_id, :start_at, :end_at

  belongs_to :mechanic
  belongs_to :time_sheet_kind
end
