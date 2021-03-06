# -*- encoding : utf-8 -*-
class DowntimesController < ApplicationController
	before_filter :signed_in_user

	def new
		@lift   = Lift.find(params[:id])
		@porch  = @lift.porch
    @build  = @porch.build
    @street = @build.street
    @city = @street.city
    @downtime = @@downtime = @lift.downtimes.build
	end

	def create
		@downtime = @@downtime
		@lift = @downtime.lift
		@downtime.update_attributes(params[:downtime])
		if @downtime.save
			okmessage = "Отметка о простое добавлена."
      flash[:success] = okmessage
      redirect_back_or_default(store_location)
		else
			flash[:success] = "something is wrong"
      #render 'new'
    end
	end

	def index
		@title = 'Простои лифтов'
		downtimes = Downtime.all
		@downtimes = []
		downtimes.each do |d|
			downtime = []
			downtime.push(d.lift)
			downtime.push(d.dt_date)
			downtime.push(d.reason)
			@downtimes.push(downtime)
		end
	end
end
