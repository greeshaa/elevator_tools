# -*- encoding : utf-8 -*-
class NodesController < ApplicationController
before_filter :signed_in_user

  def show
  	@node = Node.find(params[:id])
    @ipa = @node.ip_address
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
    @builds = Build.all
  end

  def create
    @node = Node.new(params[:node])
    if @node.save
      okmessage = @node.name + " успешно добавлен."
      flash[:success] = okmessage
      redirect_to @node
    else
      render 'new'
    end
  end

  def index
  	@nodes = Node.search(params[:search])
  end

  def edit
    @node = Node.find(params[:id])
    @streets = Street.all
    pia = @node.primary_ip_address
    sia = @node.secondary_ip_address
    if pia != nil
      @primary_ip_address = PrimaryIpAddress.where('node_id = ?', @node.id)
    else
      @primary_ip_address = @node.create_primary_ip_address(node_id: @node.id)
    end
    if sia != nil
      @secondary_ip_address = SecondaryIpAddress.where('node_id = ?', @node.id)
    else
      @secondary_ip_address = @node.create_secondary_ip_address(node_id: @node.id)
    end
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