# -*- encoding : utf-8 -*-
class StaticPagesController < ApplicationController
before_filter :signed_in_user

  def main
  	@equipment_movements = EquipmentMovement.last(5)
  end

  def about
  end

end
