# -*- encoding : utf-8 -*-
class LiftsController < ApplicationController
before_filter :signed_in_user

  def show
  	@lift   = Lift.find(params[:id])
  	@porch  = @lift.porch
  	@build  = @porch.build  
  	@street = @build.street
    @node   = @build.node
    @date_of_decommiss = @lift.introduced_at + @lift.standart_life

  end
  def index
  	@lifts = Lift.search(params[:search]) #.paginate(page: params[:page])
  end

  def new
    @streets = Street.all
    @builds = Build.all
    @porch = Porch.all
    @lift = Lift.new 
  end

  def inspections
    @lifts = Lift.all
  end
 
end
