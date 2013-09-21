# -*- encoding : utf-8 -*-

class BuildsController < ApplicationController
before_filter :signed_in_user

  def show
  	@build = Build.find(params[:id])
  	@street = Street.find_by_id(@build.street_id)
    @nodes = @build.nodes.paginate(page: params[:page])
  end

  def new
  	@build = Build.new
  end

  def create
    @build = Build.new(params[:build])
    if @build.save
    	okmessage = "Здание " + @build.name + " успешно добавлено."
      flash[:success] = okmessage
      redirect_to @build
    else
      render 'new'
    end
  end

  def index
  	#@builds = Build.paginate(page: params[:page])
  end
end
