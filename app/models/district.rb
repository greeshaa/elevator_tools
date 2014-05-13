class District < ActiveRecord::Base
	attr_accessible :name
	has_many :lifts
end
