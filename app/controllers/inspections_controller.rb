class InspectionsController < ApplicationController

	def new
		@lift = Lift.find(params[:lift_id])
		@porch  = @lift.porch
    if @porch.nil?
      @build_name  = 'Номер здания неизвестен' 
      @street_name = 'Улица неизвестна'
      @city_name   = 'Населенный пункт неизвестен'
    else
  	@build  = @porch.build  
  	@street = @build.street
    @city   = @street.city
    @node   = @build.node
    end

		@inspection = @lift.inspections.build
		@@inspection = @inspection
	end

	def create
		@inspection = @@inspection
		@lift = @inspection.lift
		@inspection.update_attributes(params[:inspection])
			next_inspect_at =  @inspection.inspection_at.next_year()
    	if next_inspect_at.cwday == 6
    	 	@inspection.next_inspection_at = next_inspect_at.next_day(2)
    	elsif next_inspect_at.cwday == 7
    		 @inspection.next_inspection_at = next_inspect_at.next_day()
    	else
      	@inspection.next_inspection_at = next_inspect_at
    	end
		if @inspection.save
			okmessage = "Отметка о ТО успешно добавлена."
      flash[:success] = okmessage
      redirect_to @lift
		else
			flash[:success] = "something is wrong"
      #render 'new'
    end
	end

	def index
		@inspections = Inspection.all.order(created_at: :desc)
	end

	def overdue_inspections
		@inspections = Inspection.where(created_at: (Date.today - Time.now.to_a[7])..Date.today).where(next_inspection_at: (Date.today - Time.now.to_a[7])..(Date.today - 1.day))
		render 'index'		
	end
end