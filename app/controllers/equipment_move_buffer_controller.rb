# -*- encoding : utf-8 -*-
class EquipmentMoveBufferController < ApplicationController
	before_filter :signed_in_user
	def show
		@equipment_move_buffer = current_equipment_buffer
		#@equipment_move_buffer = equipment_move_buffer.equipment_line_items
		@equipment_movements = EquipmentMovement.new
		#@porches = Por.new
		@streets = Street.all
	end

	def destroy
		@equipment_move_buffer = current_equipment_buffer
		@equipment_move_buffer.destroy
		session[:cart_id] = nil

		flash[:success] = "Буфер успешно очищен!"
    redirect_to equipment_index_path
		#respond_to do |format|
			#format.html { redirect_to equipment_index_path, notice: 'Буфер успешно очищен!'}
			#format.json { head :ok}
		#end
	end

end
