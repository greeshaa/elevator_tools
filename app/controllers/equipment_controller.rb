class EquipmentController < ApplicationController
		before_filter :signed_in_user

  def show
  	@equipment = Equipment.find(params[:id])
  end

  def index
  	@equipment = Equipment.paginate(page: params[:page])
  end
end
