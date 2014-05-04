class IpAddressController < ApplicationController
	
	def new
		@providers = Provider.all
		@node = Node.find(params[:node_id])
		@node.ip_addresses.build
	end

	def create
		@node = Node.find(params[:node_id])
		@ip_address = @node.ip_addresses.build(params[:ip_address])
		if @ip_address.save
			okmessage = @ip_address.name + " успешно добавлен."
      flash[:success] = okmessage
      redirect_to @node
		else
      render 'new'
    end	
	end

	def edit
		@ip_address = IpAddress.find(params[:id])
		@providers = Provider.all
	end

	def update
		@ip_address = IpAddress.find(params[:id])
		@node = @ip_address.node
    if @ip_address.update_attributes(params[:ip_address]) 
      flash[:success] = @ip_address.name + " ip для УМ " + @node.name + " обновлен"
      redirect_to @node
    else
      render 'edit'
    end
	end	  
end