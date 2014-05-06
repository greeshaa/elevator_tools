# -*- encoding : utf-8 -*-
class EquipmentController < ApplicationController
before_filter :signed_in_user

	def show
			@equipment = Equipment.find(params[:id])
			@e_move = @equipment.equipment_movements.new
	end

	def new
			@e_lists = EquipmentList.all
			@equipment = Equipment.new
	end

	def create
		@e_lists = EquipmentList.all
		@equipment = Equipment.new(params[:equipment])
		if @equipment.save
			current_user.equipment_movements.create(movement: "Поступление на склад", 
				equipment_id: @equipment.id)
			@equipment.installed_at = @equipment.created_at.strftime("%d.%m.%Y")
			@equipment.update_attributes(porch_id: "1")
			okmessage = "Устройство успешно добавлено."
			flash[:success] = okmessage
			redirect_to @equipment
		else
			render 'new'
		end
	end

	def edit
		@equipment = Equipment.find(params[:id])
		@e_lists = EquipmentList.all
	end

	def update
		@e_lists = EquipmentList.all
		@equipment = Equipment.find(params[:id])
		if @equipment.update_attributes(params[:equipment])
			flash[:success] = "Информация об устройстве обновлена"
			redirect_to @equipment
		else
			render 'edit'
		end
	end

	def search
		@equipment = Equipment.search(params[:search])
		render 'search'
	end

	def index

		@equip_all     	 = Equipment.count
		@equip_store   	 = Equipment.count(:conditions => "porch_id = 1 AND broken = '0'")
		@equip_work    	 = Equipment.count(:conditions => "porch_id > 1")
		@equip_broken 	 = Equipment.count(:conditions => "broken = '1'")
		@equip_service 	 = Equipment.count(:conditions => "porch_id > 1 AND broken = '1'")

		#all Выборка количества устройств в каждой категории
		@equip_count = []
		e_list = EquipmentList.all
		e_list.each do |el|
			equipment = el
			name    = el.name
			all     = el.equipment.count
			work    = el.equipment.where("porch_id > 1").count
			store   = el.equipment.where("porch_id = 1 AND broken = '0'").count
			broken  = el.equipment.where("broken = '1'").count
			service = el.equipment.where("porch_id > 1 AND broken = '1'").count
			count   = {equipment: equipment, name: name, all: all, work: work, store: store, broken: broken, service: service}
  			@equip_count.push(count)
		end
			
	end
	def store
		@equip_store   	 = Equipment.all(:conditions => "porch_id = 1 AND broken = '0'")
	end

	def broken
		@equip_store   	 = Equipment.all(:conditions => "broken = '1'")
	end

	def relocation
		@equipment = Equipment.find(params[:id])
	end
end
