# -*- encoding : utf-8 -*-
class EquipmentTypesController < ApplicationController
before_filter :signed_in_user

  def show
    @e_type = EquipmentType.find(params[:id])
    @e_lists = @e_type.equipment_lists.order(:manufacturer, :name)
  end

  def new
  	@e_type = EquipmentType.new
  end

  def create
    @e_type = EquipmentType.new(params[:equipment_type])
    if @e_type.save
    	okmessage = "Новая категория оборудования успешно добавлена."
      flash[:success] = okmessage
      redirect_to @e_type
    else
      render 'new'
    end
  end

  def edit
     @e_type = EquipmentType.find(params[:id])
  end

  def update
    @e_type = EquipmentType.find(params[:id])
    if @e_type.update_attributes(params[:equipment_type])
      flash[:success] = "Категория оборудования успешно обновлена"
      redirect_to @e_type
    else
      render 'edit'
    end
  end

  def index
    @e_types = EquipmentType.all.order(:name)
  end

end
