# -*- encoding : utf-8 -*-
class DowntimesController < ApplicationController
	before_filter :signed_in_user

	def new
		session[:return_to] ||= request.referer
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
      redirect_to session.delete(:return_to)
		else
			flash[:success] = "something is wrong"
      #render 'new'
    end
	end

	def index

	end
end
