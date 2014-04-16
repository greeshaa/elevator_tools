class IpAddressController < ApplicationController
	
	def edit
		#@node = Node.find(params[:id])
		@ip_address = IpAddress.find(params[:id])
	end

	def update
		#@node = Node.find(params[:id])
		@ip_address = IpAddress.find(params[:id])
		@node = @ip_address.node
    if @ip_address.update_attributes(params[:ip_address]) 
      flash[:success] = @ip_address.name + " ip для " + @node.name + " обновлен"
      redirect_to @node
    else
      render 'edit'
    end
	end
		  
end
