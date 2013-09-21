# -*- encoding : utf-8 -*-

class EquipmentController < ApplicationController
before_filter :signed_in_user

  def show
      @equipment = Equipment.find(params[:id])
  end

  def new
      @equipment = Equipment.new
  end

  def create
    @equipment = Equipment.new(params[:equipment])
    if @equipment.save
      okmessage = "Устройство " + @equipment.name + " успешно добавлено."
      flash[:success] = okmessage
      redirect_to @equipment
    else
      render 'new'
    end
  end

  def edit
    @equipment = Equipment.find(params[:id])
  end

  def update
    @equipment = Equipment.find(params[:id])
    if @equipment.update_attributes(params[:equipment])
      flash[:success] = "Улица " + @equipment.name + " обновлена"
      redirect_to @equipment
    else
      render 'edit'
    end
  end

  def index
      @equipment = Equipment.paginate(page: params[:page])
  end
end
