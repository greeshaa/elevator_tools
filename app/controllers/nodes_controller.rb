# -*- encoding : utf-8 -*-
class NodesController < ApplicationController
before_filter :signed_in_user

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

      okmessage = "УМ " + @node.name + " успешно добавлен."
      flash[:success] = okmessage
      redirect_to @node
    else
      render 'new'
    end
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

  def show
    @node = Node.find(params[:id])
    if @node.id == 1
      @node_name = @node.name
    else
      @node_name = "УМ " + @node.name
    end
    @connections  = @node.porch.connections

    if @node.street.nil?
      @address = "Группа лифтов, которые не выводятся в ЦД и не принадлежат какому-либо УМ"
    else
      if @node.porch.nil?
        @address = "ул." + @node.street.name + ", д." + @node.build.name
      elsif @node.porch.id == 2
        @address = "ул." + @node.street.name + ", д." + @node.build.name
        else
        @address = "ул." + @node.street.name + ", д." + @node.build.name + ", " + @node.porch.name
      end
    end
    @equipment     = @node.porch.equipment
    @lifts         = @node.lifts
    @klsh          = @equipment.where("equipment_list_id=? or equipment_list_id=?", 10, 18)
    @klsh_count    = @klsh.count
    if  @klsh_count == 0
      @klsh        = @equipment.where("equipment_list_id=? or equipment_list_id=?", 12, 13)
      @klsh_count  = @klsh.count
      @monoblk     = 1
    end

    @lifts_count   = @lifts.count
    @address_stack = @klsh_count * 31
    @free_address  = @address_stack - @lifts.count
  end

  def index
    if (params[:search]).blank?

    else
      streets = Street.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
      if streets.empty?
        @nodes = Node.search(params[:search])
      else
        @nodes = Node.search(params[:search])
        streets.each do |s|
          nodes = s.nodes
          nodes.each do |n|
            @nodes.push(n)
          end
        end
      end
    end
  end

  def all
    @nodes  = Node.all
    @nodes.each
    render 'index'
  end

  def lift_move
    @node = Node.find(params[:id])
    @nodes = Node.all.order(:name)
    if @node.id == 1
      @node_name = @node.name
    else
      @node_name = "УМ " + @node.name
    end
    if @node.street.nil?
      @address = "Группа лифтов, которые не выводятся в ЦД и не принадлежат какому-либо УМ"
    else
      if @node.porch.nil?
        @address = "ул." + @node.street.name + ", д." + @node.build.name
      else
        @address = "ул." + @node.street.name + ", д." + @node.build.name + ", " + @node.porch.name
      end
    end

    @lifts    = @node.lifts.order(:tlr_id, :porch_id)
  end

  private
  def node_params
    params.require(:node).permit(:name, :description, :street_id, :build_id, :porch_id, :dataport, :soundport,
      ip_addresses_attributes: [:id, :name, :ip, :mask, :gate, :provider_id])
  end


end
