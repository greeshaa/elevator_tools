# -*- encoding : utf-8 -*-
class LiftsController < ApplicationController
	before_filter :signed_in_user

  def show
  	@lift = Lift.find(params[:id])
  	@porch = @lift.porch
  	@build = @porch.build  
  	@street = @build.street
      @node = @build.node

  end
  def index
  	@lifts = Lift.paginate(page: params[:page])
  end

    def new
    @lift = Lift.new
    @streets = Street.all
    @builds = Build.all
    @porch = Porch.all
  end
end
