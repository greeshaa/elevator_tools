# -*- encoding : utf-8 -*-
class EquipmentLineItemsController < ApplicationController
  before_action :set_equipment_line_item, only: [:show, :edit, :update, :destroy]

  # GET /equipment_line_items
  # GET /equipment_line_items.json
  def index
    @equipment_line_items = EquipmentLineItem.all
  end

  # GET /equipment_line_items/1
  # GET /equipment_line_items/1.json
  def show
  end

  # GET /equipment_line_items/new
  def new
    @equipment_line_item = EquipmentLineItem.new
  end

  # GET /equipment_line_items/1/edit
  def edit
  end

  # POST /equipment_line_items
  # POST /equipment_line_items.json
  def create
    @equipment_move_buffer = current_equipment_buffer
    equipment = Equipment.find(params[:equipment_id])
    @equipment_line_item = @equipment_move_buffer.equipment_line_items.build(equipment_id: equipment.id)

    respond_to do |format|
      if @equipment_line_item.save
        format.html { redirect_to @equipment_line_item.equipment_move_buffer, notice: 'Equipment line item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @equipment_line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @equipment_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment_line_items/1
  # PATCH/PUT /equipment_line_items/1.json
  def update
    respond_to do |format|
      if @equipment_line_item.update(equipment_line_item_params)
        format.html { redirect_to @equipment_line_item, notice: 'Equipment line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @equipment_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment_line_items/1
  # DELETE /equipment_line_items/1.json
  def destroy
    @equipment_line_item.destroy
    respond_to do |format|
      format.html { redirect_to equipment_line_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment_line_item
      @equipment_line_item = EquipmentLineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_line_item_params
      params.require(:equipment_line_item).permit(:equipment_id, :equipment_move_buffer_id)
    end
end
