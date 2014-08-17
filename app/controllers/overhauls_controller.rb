# -*- encoding : utf-8 -*-
class OverhaulsController < ApplicationController
	def index
		@overhauls = Overhaul.all
		@title = 'Проведенные ремонты'
	end

	def show
		@overhaul = Overhaul.find(params[:id])
		@title = 'Информация о ремонте лифта'
		@address = @overhaul.lift.porch.build.street.name + ', ' + @overhaul.lift.porch.build.name + ' - ' + @overhaul.lift.porch.name
		@produced = @overhaul.produced_at.strftime("%d.%m.%Y")
		@kind = @overhaul.kind
		@new_lifetime = @overhaul.new_lifetime
		@description = @overhaul.description
	end

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
    @@lastoverhaul = @lift.overhauls.last
		@overhaul = @@overhaul = @lift.overhauls.build
		@title = 'Добавление информации о проведении ремонта лифта'
	end

	def create
		@overhaul = @@overhaul
		@lift = @overhaul.lift
		@overhaul.update_attributes(params[:overhaul])
		if @overhaul.save
			@@lastoverhaul.update_attributes(active: false) if @@lastoverhaul != nil
			okmessage = "Отметка о ремонте успешно добавлена."
      flash[:success] = okmessage
      redirect_to @lift
		else
			flash[:success] = "something is wrong"
      #render 'new'
    end
	end
end
