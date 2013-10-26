# -*- encoding : utf-8 -*-

class PorchesController < ApplicationController
before_filter :signed_in_user

  def show
      @porch = Porch.find(params[:id])
      @lifts = @porch.lifts   
      @build = @porch.build    
      @street = @build.street.name
      @node = @build.node
      
  	
  end

  def new
    @node = Node.new
    @streets = Street.all
    @builds = Build.all #find_by_id(:street_id)
  end

  def create
    @node = Node.new(params[:node])
    if @node.save
      okmessage = "УМ " + @node.name + " успешно добавлен."
      flash[:success] = okmessage
      redirect_to @node
    else
      render 'new'
    end
  end

  def index
  	@nodes = Node.paginate(page: params[:page])
  end
end
