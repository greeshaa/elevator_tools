# -*- encoding : utf-8 -*-
class EquipmentMovementsController < ApplicationController
before_filter :signed_in_user

  def show
    @e_move = EquipmentMovement.find(params[:id])
  end

  def new
    @e_move = EquipmentMovement.new
    @equipment = Equipment.all
    @node = Node.all
  end

  def create
     @equipment = Equipment.find(params[:e_move])
     @node = Node.find(params[:e_move])
     current_user.equipment_movements.create(destination_id: "2", movement: "Установка на узел", equipment_id: equipment.id)
    if @e_move.save
      @node.equipment << @equipment
    	okmessage = "Оборудование пересено на новый адрес"
      flash[:success] = okmessage
      redirect_to @e_move
    else
      render 'new'
    end
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
    @e_moves = EquipmentMovement.paginate(:page => params[:page]).order('created_at DESC')
  end
end
