# -*- encoding : utf-8 -*-
class InspectionsController < ApplicationController
before_filter :signed_in_user
	def new
		session[:return_to] ||= request.referer
		@@lift = @lift = Lift.find(params[:id])
		@porch = @lift.porch
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
		@inspection = Inspection.new
	end

	def create
		@lastinspection = @@lift.inspections.last
		if params[:notes] == "1"
			@inspection = @@lift.inspections.create(inspection_at: params[:inspection_at], rebuke: true)
		else
			@inspection = @@lift.inspections.create(inspection_at: params[:inspection_at], rebuke: false)
		end
		@inspection.update_attributes(comment: params[:comment]) if params[:comment] != nil
		if @inspection.save
			@lastinspection.update_attributes(active: false) if @lastinspection != nil
			okmessage = "Отметка о ТО успешно добавлена."
      flash[:success] = okmessage
      redirect_to session.delete(:return_to)
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

	def rebuke
		@inspections = Inspection.where(active: true).where(rebuke: true)
		@title = 'Лифты с запретом на эксплуатацию'
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

	def month
		if params[:date].nil?
			@month = Date.today
		else
			@month = Date.parse(params[:date])
		end
		@smonth    = @month.at_beginning_of_month
		@emonth    = @month.at_end_of_month
		@inspections = Inspection.where(active: true).where(next_inspection_at: @smonth..@emonth)
		render 'index'
	end
end
