class InspectionsController < ApplicationController

	def new
		@lift = Lift.find(params[:lift_id])	
	end

	def create
		@lift = Lift.find(params[:lift_id])
		inspection = Inspection.new(params[:inspection])
		if @inspection.save
			@lift.inspections << inspection
			okmessage = "Отметка о ТО успешно добавлена."
      flash[:success] = okmessage
      redirect_to @lift
		else
			flash[:success] = "something is wrong"
      #render 'new'
    end
	end
end
