# -*- encoding : utf-8 -*-
class NodesController < ApplicationController
before_filter :signed_in_user

  def show
  	@node = Node.find(params[:id])
    if @node.street.nil?
    else
      @porch = @node.porch
      @build = @node.build
      @street = @node.street.name
      @equipment = @node.equipment
  	end
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
  	@nodes = Node.search(params[:search])
  end

  def update
    @node = Node.find(params[:id])
    if @node.update_attributes(params[:node])
      flash[:success] = "УМ " + @node.name + " обновлен"
      redirect_to @node
    else
      render 'edit'
    end
  end
end