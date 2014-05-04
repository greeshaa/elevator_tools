class StreetKind < ActiveRecord::Base
	attr_accessible :name, :full_name
	has_many :streets
end
