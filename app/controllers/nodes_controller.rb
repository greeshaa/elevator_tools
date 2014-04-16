# -*- encoding : utf-8 -*-
class NodesController < ApplicationController
before_filter :signed_in_user

  def show
  	@node = Node.find(params[:id])
    @ipa  = @node.ip_addresses

    if @node.street.nil?
    else
      @porch = @node.porch
      @build = @node.build
      @street = @node.street.name
      @equipment = @node.equipment
  	end
  end

  def new
    @streets = Street.all
    @builds = Build.all
    @providers = Provider.all
    @node = Node.new
    @node.ip_addresses.build
  end

  def create
    @node = Node.new(node_params)
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
  end

  def update
    @node = Node.find(params[:id])
    if @node.update_attributes(params[:node]) 
      flash[:success] = @node.name + " обновлен"
      redirect_to @node
    else
      render 'edit'
    end
  end

  def edit_ip
    @node = Node.find(params[:id])
    @ip = @node.ip_addresses    
  end

  private
  def node_params
    params.require(:node).permit(:name, :description, :street_id, :build_id, :porch_id, :dataport, :soundport, 
      ip_addresses_attributes: [:id, :name, :ip, :mask, :gate, :provider_id])
  end


end
