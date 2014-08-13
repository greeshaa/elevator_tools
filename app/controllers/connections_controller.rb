# -*- encoding : utf-8 -*-
class ConnectionsController < ApplicationController
	def index
		@connections = Connection.all
	end

	def show
		@connection = Connection.find(params[:id])		
	end

	def new
    @providers = Provider.all
    @nodes = Node.all
    @streets = Street.all
    @connection = Connection.new
    @connection.build_ip_address

	end

	def create
    @providers = Provider.all
    @nodes = Node.all
    @streets = Street.all
    @connection = Connection.new(params[:connection])
    if @connection.save
    	okmessage = "Подключение для успешно создано."
      flash[:success] = okmessage
      redirect_to @connection
    else
      render 'new'
    end
		
	end

end
