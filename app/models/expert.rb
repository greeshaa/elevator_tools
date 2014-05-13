class Expert < ActiveRecord::Base
	attr_accessible :partner_id
	belongs_to :partner
	has_many :lifts
end
