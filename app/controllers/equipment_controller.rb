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
			current_user.equipment_movements.create(destination_id: "1", movement: "Поступление на склад", equipment_id: equipment.id)
			@equipment.installed_at = @equipment.created_at.strftime("%d.%m.%Y")
			@equipment.update_attributes(destination_id: "1")
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

		 #.paginate(page: params[:page])
  	
		#@equipment = Equipment.paginate(page: params[:page])
		#@equp_name = @equipment.equipment_list.name

		@equip_all     	 = Equipment.count
		@equip_store   	 = Equipment.count(:conditions => "destination_id = 1")
		@equip_work    	 = Equipment.count(:conditions => "destination_id = 2")
		@equip_service 	 = Equipment.count(:conditions => "destination_id = 3")

		#all Выборка общего количества устройств в каждой категории
		@cnu_all    		 = Equipment.count(:conditions => "equipment_list_id = 1")
		@adsla_all  		 = Equipment.count(:conditions => "equipment_list_id = 3")
		@adslb_all  		 = Equipment.count(:conditions => "equipment_list_id = 4")
		@dir100_all 		 = Equipment.count(:conditions => "equipment_list_id = 6")
		@mono_all   		 = Equipment.count(:conditions => "equipment_list_id = 10")
		@ksl_all    		 = Equipment.count(:conditions => "equipment_list_id = 11")
		@klsh_all   		 = Equipment.count(:conditions => "equipment_list_id = 12")
		@klshpro_all		 = Equipment.count(:conditions => "equipment_list_id = 13")
		@mmi_all    		 = Equipment.count(:conditions => "equipment_list_id = 14")
		#@lbprootis    	 = Equipment.count(:conditions => "equipment_list_id = 16")
		#@lbp6ukl      	 = Equipment.count(:conditions => "equipment_list_id = 28")
		#@lb6cm3otis 		 = Equipment.count(:conditions => "equipment_list_id = 29")
		#@lb6shulk    	 = Equipment.count(:conditions => "equipment_list_id = 30")
		#@lb6cm3otis     = Equipment.count(:conditions => "equipment_list_id = 31")
		#@lbkdk          = Equipment.count(:conditions => "equipment_list_id = 32")


		#store Выборка устройств на складе
		@cnu_store    	 = Equipment.count(:conditions => "equipment_list_id = 1  AND destination_id = 1")
		@adsla_store  	 = Equipment.count(:conditions => "equipment_list_id = 3  AND destination_id = 1")
		@adslb_store  	 = Equipment.count(:conditions => "equipment_list_id = 4  AND destination_id = 1")
		@dir100_store 	 = Equipment.count(:conditions => "equipment_list_id = 6  AND destination_id = 1")
		@mono_store   	 = Equipment.count(:conditions => "equipment_list_id = 10 AND destination_id = 1")
		@ksl_store    	 = Equipment.count(:conditions => "equipment_list_id = 11 AND destination_id = 1")
		@klsh_store   	 = Equipment.count(:conditions => "equipment_list_id = 12 AND destination_id = 1")
		@klshpro_store	 = Equipment.count(:conditions => "equipment_list_id = 13 AND destination_id = 1")
		@mmi_store    	 = Equipment.count(:conditions => "equipment_list_id = 14 AND destination_id = 1")

		#work Выборка устройств на узлах
		@cnu_work    		 = Equipment.count(:conditions => "equipment_list_id = 1  AND destination_id = 2")
		@adsla_work  		 = Equipment.count(:conditions => "equipment_list_id = 3  AND destination_id = 2")
		@adslb_work  		 = Equipment.count(:conditions => "equipment_list_id = 4  AND destination_id = 2")
		@dir100_work 		 = Equipment.count(:conditions => "equipment_list_id = 6  AND destination_id = 2")
		@mono_work   		 = Equipment.count(:conditions => "equipment_list_id = 10 AND destination_id = 2")
		@ksl_work    		 = Equipment.count(:conditions => "equipment_list_id = 11 AND destination_id = 2")
		@klsh_work   		 = Equipment.count(:conditions => "equipment_list_id = 12 AND destination_id = 2")
		@klshpro_work		 = Equipment.count(:conditions => "equipment_list_id = 13 AND destination_id = 2")
		@mmi_work    		 = Equipment.count(:conditions => "equipment_list_id = 14 AND destination_id = 2")

		#service Выборка устройств в ремонте
		@cnu_service     = Equipment.count(:conditions => "equipment_list_id = 1  AND destination_id = 3")
		@adsla_service   = Equipment.count(:conditions => "equipment_list_id = 3  AND destination_id = 3")
		@adslb_service   = Equipment.count(:conditions => "equipment_list_id = 4  AND destination_id = 3")
		@dir100_service  = Equipment.count(:conditions => "equipment_list_id = 6  AND destination_id = 3")
		@mono_service    = Equipment.count(:conditions => "equipment_list_id = 10 AND destination_id = 3")
		@ksl_service     = Equipment.count(:conditions => "equipment_list_id = 11 AND destination_id = 3")
		@klsh_service    = Equipment.count(:conditions => "equipment_list_id = 12 AND destination_id = 3")
		@klshpro_service = Equipment.count(:conditions => "equipment_list_id = 13 AND destination_id = 3")
		@mmi_service     = Equipment.count(:conditions => "equipment_list_id = 14 AND destination_id = 3")
	end
	def store
		@equip_store   	 = Equipment.all(:conditions => "destination_id = 1")
	end
end
