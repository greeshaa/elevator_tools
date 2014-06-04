# -*- encoding : utf-8 -*-
class EquipmentMovementsController < ApplicationController
before_filter :signed_in_user

  def show
    @e_move = EquipmentMovement.find(params[:id])
  end

  def new
    @e_move = EquipmentMovement.new
    @porch = Porch.all
    @equipment = Equipment.find(params[:equipment_id])
  end

  def create
     count = 0
     porch = Porch.find(params[:equipment_movement][:porch_id])
     current_equipment_buffer.equipment_line_items.each do |item|
      @equipment_movement = current_user.equipment_movements.build(params[:equipment_movement])
      equipment = Equipment.find_by_id(item.equipment.id)
      @equipment_movement.update_attributes(equipment_id: equipment.id) 
      porch.equipment << equipment
      if @equipment_movement.save
        if count == 0
          @message = equipment.equipment_list.name + " s/n: " + equipment.factory_sn
          count +=1
        else
          @message += ' и ' + equipment.equipment_list.name + " s/n: " + equipment.factory_sn
        end
      end
     end
    okmessage = @message + " перенесен(ы) в " + porch.name + ' на ' + porch.build.street.name + ' ' + porch.build.name
    flash[:success] = okmessage

    @equipment_move_buffer = current_equipment_buffer
    @equipment_move_buffer.destroy
    session[:cart_id] = nil
    redirect_to equipment_index_path
  end

  def edit
     @e_move = EquipmentMovement.find(params[:id])
  end

  def update
    @e_move = EquipmentMovement.find(params[:id])
    if @e_move.update_attributes(params[:equipment_movement])
      flash[:success] = "Категория оборудования успешно обновлена"
      redirect_to @e_move
    else
      render 'edit'
    end
  end

  def index
    @e_moves = EquipmentMovement.order('created_at DESC')
  end
end
