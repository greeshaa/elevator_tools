# -*- encoding : utf-8 -*-
class EquipmentListsController < ApplicationController
before_filter :signed_in_user

  def show
    @e_list = EquipmentList.find(params[:id])
    @equip_store = @e_list.equipment.where("porch_id = 1 AND broken = '0'")
    @equip_work = @e_list.equipment.where("porch_id > 1")
    @equip_broken = @e_list.equipment.where("broken = '1'")
  end

  def new
    @e_list = EquipmentList.new
    @e_types = EquipmentType.all
  end

  def create
    @e_types = EquipmentType.all
    @e_list = EquipmentList.new(params[:equipment_list])
    if @e_list.save
    	okmessage = "Новый тип оборудования успешно добавлен."
      flash[:success] = okmessage
      redirect_to equipment_lists_path
    else
      render 'new'
    end
  end

  def edit
     @e_list = EquipmentList.find(params[:id])
     @e_types = EquipmentType.all
  end

  def update
    @e_types = EquipmentType.all
    @e_list = EquipmentList.find(params[:id])
    if @e_list.update_attributes(params[:equipment_list])
      flash[:success] = "Тип оборудования обновлен"
      redirect_to @e_list
    else
      render 'edit'
    end
  end

  def index
    @e_lists = EquipmentList.all.order(:manufacturer, :name)
  end
end
