# -*- encoding : utf-8 -*-
class PricesController < ApplicationController
	before_filter :signed_in_user
	def index
		prices = Price.all
		prices.each do |p|
			case p.floor
			when 1
				@pricesnull = [] if @pricesnull.nil?
				@pricesnull.push(p)
			when 2
				@prices2fl = [] if @prices2fl.nil?
				@prices2fl.push(p)
			when 3
				@prices3fl = [] if @prices3fl.nil?
				@prices3fl.push(p)
			when 4
				@prices4fl = [] if @prices4fl.nil?
				@prices4fl.push(p)
			when 5
				@prices5fl = [] if @prices5fl.nil?
				@prices5fl.push(p)
			when 6
				@prices6fl = [] if @prices6fl.nil?
				@prices6fl.push(p)
			when 7
				@prices7fl = [] if @prices7fl.nil?
				@prices7fl.push(p)
			when 8
				@prices8fl = [] if @prices8fl.nil?
				@prices8fl.push(p)
			when 9
				@prices9fl = [] if @prices9fl.nil?
				@prices9fl.push(p)
			when 10
				@prices10fl = [] if @prices10fl.nil?
				@prices10fl.push(p)
			when 11
				@prices11fl = [] if @prices11fl.nil?
				@prices11fl.push(p)
			when 12
				@prices12fl = [] if @prices12fl.nil?
				@prices12fl.push(p)
			when 13
				@prices13fl = [] if @prices13fl.nil?
				@prices13fl.push(p)
			when 14
				@prices14fl = [] if @prices14fl.nil?
				@prices14fl.push(p)
			when 15
				@prices15fl = [] if @prices15fl.nil?
				@prices15fl.push(p)
			when 16
				@prices16fl = [] if @prices16fl.nil?
				@prices16fl.push(p)
			when 17
				@prices17fl = [] if @prices17fl.nil?
				@prices17fl.push(p)
			when 18
				@prices_pod_esk = [] if @prices_pod_esk.nil?
				@prices_pod_esk.push(p)
			else

			end
		end
	end

	def edit
		@price = Price.find(params[:id])
	end

	def update
		@price = Price.find(params[:id])
    if @price.update_attributes(params[:price])
      flash[:success] = "Стоимость обслуживания для " + @price.title + " обновлена"
      redirect_to prices_path
    else
      render 'edit'
    end

	end
end
