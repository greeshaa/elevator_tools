# -*- encoding : utf-8 -*-
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
    @@lastinspection = @lift.inspections.last
		@inspection = @@inspection = @lift.inspections.build

	end

	def create

		@inspection = @@inspection
		@lift = @inspection.lift

		@inspection.update_attributes(inspection_at: params[:inspection_at])
			next_inspect_at =  @inspection.inspection_at.next_year()
    	if next_inspect_at.cwday == 6
    	 	@inspection.next_inspection_at = next_inspect_at.next_day(2)
    	elsif next_inspect_at.cwday == 7
    		 @inspection.next_inspection_at = next_inspect_at.next_day()
    	else
      	@inspection.next_inspection_at = next_inspect_at
    	end
		if @inspection.save
			@@lastinspection.update_attributes(active: false) if @@lastinspection != nil
			okmessage = "Отметка о ТО успешно добавлена."
      flash[:success] = okmessage
      redirect_to @lift
		else
			flash[:success] = "something is wrong"
      #render 'new'
    end
	end

	def index
		@inspections = Inspection.all.order(created_at: :desc, lift_id: :asc)
	end

	def overdue
		@inspections = Inspection.where(active: true).where(next_inspection_at: (Date.today - Time.now.to_a[7])..(Date.today - 1.day))
		@title = 'Лифты с просроченным ПТО'
		render 'index'
	end

	def next
		@inspections = Inspection.where(next_inspection_at: Date.today..(Date.today + 7.day)).order(:next_inspection_at)
		@title = 'Лифты с ПТО запланированным на следующую неделю'
		render 'index'
	end

	def last
		@inspections = Inspection.where(created_at: (Date.today - 7.day)..Date.today + 1.day).order(:created_at)
		@title = 'Лифты с ПТО на прошедшей неделе'
		render 'index'
	end
end
