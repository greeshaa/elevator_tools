# -*- encoding : utf-8 -*-
class BuildsController < ApplicationController
before_filter :signed_in_user

  def index
    @builds = Build.all
  end

  def show
    @build      = Build.find(params[:id])
    @lifts      = @build.lifts
    @street     = @build.street.name
    @streetkind = @build.street.street_kind.full_name
    @porches    = @build.porches
    @streets    = @build.street.id.to_s
    if @lifts.empty?
      @node     = Node.find_by_id('2')
    else
      @node     = @lifts.first.node
    end
    @equipment  = []
    @porches.each do |porch|
      equipment = porch.equipment.order(:equipment_list_id)
      equipment.each do |equip|
        @equipment.push(equip)
      end
    end 
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
    @streets = Street.all
    @nodes = Node.all
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
