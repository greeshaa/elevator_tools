# -*- encoding : utf-8 -*-
class AddressController < ApplicationController
before_filter :signed_in_user

	def index
		unless params[:search].nil?
    	address = params[:search].split(', ')
      #@addr1 = "%#{address[0]}%"
      #@addr2 = "%#{address[1]}%"
      @address = Hash.new
    	if address[0] != nil && address[1] != nil 
     		street = Street.where('LOWER(name) LIKE ?', "%#{address[0]}%")
     		if street.nil?
     			okmessage = "Улица ненайдена."
        	flash[:success] = okmessage
          redirect_to 'index'
     		else
     			street.each do |street|
            @address.store(street, Build.where('street_id = ? AND name = ?', street.id, "#{address[1]}") )
					end
				end
    	elsif address[0] != nil && address[1].nil?
    		street = Street.where('LOWER(name) LIKE ?', "%#{address[0]}%")
     		street.each do |street|
     			@address.store(street, Build.where('street_id = ?', street.id) )
     		end
    	end
		end
	end

  def new
    
  end
  def list
    @address = Hash.new
    street = Street.all.order('name')
        street.each do |street|
          @address.store(street, Build.where('street_id = ?', street.id) )
        end
    render 'index'
  end
end
