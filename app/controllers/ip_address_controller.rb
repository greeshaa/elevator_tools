class IpAddressController < ApplicationController
	
	def edit
		@ip_address = IpAddress.find(params[:id])
		@providers = Provider.all
	end

	def update
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
