# -*- encoding : utf-8 -*-
class PorchesController < ApplicationController
before_filter :signed_in_user

  def show
      @porch  = Porch.find(params[:id])
      @build  = @porch.build    
      @street = @build.street.name
      @node   = @porch.node
      @lifts  = @porch.lifts 
      
  	
  end

  def new
    @node = Node.new
    @streets = Street.all
    @builds = Build.all #find_by_id(:street_id)
  end

  def create
    @porch = Porch.new(params[:porch])
    if @porch.save
      okmessage = "УМ " + @porch.name + " успешно добавлен."
      flash[:success] = okmessage
      redirect_to @build
    else
      render 'new'
    end
  end

  def index
  	@porches = Porch.all 
  end

end
