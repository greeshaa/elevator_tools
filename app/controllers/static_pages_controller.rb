# -*- encoding : utf-8 -*-
class StaticPagesController < ApplicationController
before_filter :signed_in_user

  def main
  	@equipment_movements = EquipmentMovement.order(created_at: :desc).first(3)
  	@nodes_last 		 		 = Node.order(created_at: :desc).first(3)
  	@inspection_last     = Inspection.where(inspection_at: (Date.today - 1.day)..Date.today).first(3)
  	@inspection_next     = Inspection.where(next_inspection_at: Date.today..(Date.today + 7.day)).first(3)
  	@infomessages 			 = []
  end

  def about
  end

  def statistics
  end

end
