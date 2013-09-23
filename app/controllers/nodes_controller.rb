# -*- encoding : utf-8 -*-

class NodesController < ApplicationController
before_filter :signed_in_user

  def show
  	@node = Node.find(params[:id])
  	@street = Street.find_by_id(@node.street_id) 
  	@build = Build.find_by_id(@node.build_id)  	
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