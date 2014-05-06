# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
protect_from_forgery
  include SessionsHelper

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end

  private

  def current_equipment_buffer
  	EquipmentMoveBuffer.find(session[:equipment_move_buffer_id])
  rescue ActiveRecord::RecordNotFound
  	equipment_move_buffer = EquipmentMoveBuffer.create
  	session[:equipment_move_buffer_id] = equipment_move_buffer.id
  	equipment_move_buffer
  end
end
