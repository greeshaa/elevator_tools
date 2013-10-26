# -*- encoding : utf-8 -*-

class BuildsController < ApplicationController
before_filter :signed_in_user

  def show
  	@build = Build.find(params[:id])
      @street = @build.street.name
      @node = @build.node
      @porches = @build.porches#.paginate(page: params[:page])
      @streets = @build.street.id.to_s
  end

  def new
  	@build = Build.new
     @streets = Street.all
  end

  def create
    @build = Build.new(params[:build])
    if @build.save
    	okmessage = "Здание "  + @build.name + " успешно добавлено."
      flash[:success] = okmessage
      redirect_to @build
    else
      render 'new'
    end
  end

  def index
  	@builds = Build.all #paginate(page: params[:page])
  end
end