class MechanicsController < ApplicationController

	def index
		@mechanics = Mechanic.all.order(:name)
	end

	def show
		@mechanic = Mechanic.find(params[:id])
		@lifts    = @mechanic.lifts.order(:tlr_id, :porch_id)
		@lcount = @lifts.count
		@zlcount = @lifts.where('tlr_id = ?', 1).count
		@olcount = @lifts.where('tlr_id = ?', 2).count
	end
end
