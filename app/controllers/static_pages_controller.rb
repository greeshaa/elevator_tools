# -*- encoding : utf-8 -*-
class StaticPagesController < ApplicationController
before_filter :signed_in_user

  def main
  	@equipment_movements = EquipmentMovement.order(created_at: :desc).first(3)
  	@nodes_last 		 = Node.order(created_at: :desc).first(3)
  	@inspection_last     = Inspection.last(3)
  end

  def about
  end

end
