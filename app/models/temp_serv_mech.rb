class TempServMech < ActiveRecord::Base
	attr_accessible :lift_id, :mechanic_id, :start_at, :end_at
	belongs_to :mechanic
	belongs_to :lift
end
