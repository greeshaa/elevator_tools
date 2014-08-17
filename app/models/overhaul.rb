class Overhaul < ActiveRecord::Base
	attr_accessible  :active, :lift_id, :kind, :produced_at, :description, :new_lifetime

  belongs_to :lift
end
