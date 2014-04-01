# -*- encoding : utf-8 -*-
class BuildsController < ApplicationController
before_filter :signed_in_user

  def index
    @builds = Build.all #paginate(page: params[:page])
  end

  def show
      @build   = Build.find(params[:id])
      @lifts   = @build.lifts
      @street  = @build.street.name
      @node    = @build.node
      @porches = @build.porches#.paginate(page: params[:page])
      @streets = @build.street.id.to_s
      
  end

  def new
      @build = Build.new
      @streets = Street.all
      @nodes = Node.all
  end

  def edit
     @build = Build.find(params[:id])
     @streets = Street.all
     @nodes = Node.all
  end

  def addporches(build)
    porch_count = build.porch_count
    porch_count.times do | p |
      name = "#{p+1} подъезд"
      build_id = build.id
      porch = Porch.create(name: name, build_id: build_id)
      build.porches << porch
    end
  end
  
  def create
      @build = Build.new(params[:build])
        if @build.save
          addporches(@build)
          okmessage = "Здание успешно добавлено."
          flash[:success] = okmessage
          redirect_to @build
        else
          render 'new'
        end
  end

  def update
      @build = Build.find(params[:id])
      @build.update_attributes(params[:build])
        if @build.save
          #addporches(@build)
          okmessage = "Данные успешно обновлены."
          flash[:success] = okmessage
          redirect_to @build
        else
          render 'edit'
        end
  end


  #def viewlifts(build)
  #  porch_count = build.porch_count
  #  porch_count.times do | p |
  #end
  
end
