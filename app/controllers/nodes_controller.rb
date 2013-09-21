class NodesController < ApplicationController
	before_filter :signed_in_user

  def show
  	@node = Node.find(params[:id])
  	@street = Street.find_by_id(@node.street_id) 
  	@build = Build.find_by_id(@node.build_id)  	
  end

  def new
  	@node = Node.new
  	@street = Street.all
  end

  def index
  	@nodes = Node.paginate(page: params[:page])
  end
end