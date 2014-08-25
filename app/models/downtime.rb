class Downtime < ActiveRecord::Base
	attr_accessible :dt_date
	belongs_to :lift
end
