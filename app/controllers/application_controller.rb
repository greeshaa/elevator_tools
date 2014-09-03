# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  protect_from_forgery
    include SessionsHelper
    include MechanicsHelper

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end

  def search
    unless params[:search].nil?
      address = params[:search].split(', ')
      #@addr1 = "%#{address[0]}%"
      #@addr2 = "%#{address[1]}%"
      @address = Hash.new
      @equip = []
      if address[0] != nil && address[1] != nil
        street = Street.where('LOWER(name) LIKE ?', "%#{address[0]}%")
        if street.nil?
          okmessage = "Улица ненайдена."
          flash[:success] = okmessage
          redirect_to 'index'
        else
          street.each do |street|
            @address.store(street, Build.where('street_id = ? AND name = ?', street.id, "#{address[1]}") )
          end
        end
      elsif address[0] != nil && address[1].nil?
        street = Street.where('LOWER(name) LIKE ?', "%#{address[0]}%")
        if street.nil?
          okmessage = "Улица ненайдена."
          flash[:success] = okmessage
          redirect_to 'index'
        else
          street.each do |street|
            @address.store(street, Build.where('street_id = ?', street.id) )
          end
        end
        equip = Equipment.where('UPPER(factory_sn) LIKE ?', "%#{address[0]}%")
        if equip.empty?
          equiplist = EquipmentList.where('LOWER(name) LIKE ? OR LOWER(manufacturer) LIKE ? OR LOWER(description) LIKE ?', "%#{address[0]}%", "%#{address[0]}%", "%#{address[0]}%")
          if equiplist.empty?
            okmessage = "девайс ненайдена."
            flash[:success] = okmessage
            redirect_to 'index'
          else
            equiplist.each do |equiplist|
              equip = Equipment.where('equipment_list_id = ?', equiplist.id)
              equip.each do |e|
                @equip.push(e)
              end

            end
          end
        else
           @equip = equip
          #equip.each do |e|
          #  @equip.store(e.equipment_list, e)
          #end
        end
    end
  end

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
