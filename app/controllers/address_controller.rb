# -*- encoding : utf-8 -*-
class AddressController < ApplicationController
before_filter :signed_in_user

	def index
		unless params[:search].nil?
    	address = params[:search].split(', ')
    	if address[0] != nil && address[1] != nil 
     		street = Street.find(:all, :conditions => ['name LIKE ?', "#{address[0]}"])
     		if street.nil?
     			okmessage = "Улица ненайдена."
        	flash[:success] = okmessage
     		else
     			street.each do |street|
     				@build = Build.find(:all, :conditions => ['street_id = ? AND name = ?', street.id, "#{address[1]}"])
     				@street = street
					end
				end
    	elsif address[0] != nil && address[1].nil?
    		street = Street.find(:all, :conditions => ['LOWER(name) LIKE ?', "%#{address[0]}%"])
    		@address = Hash.new
     		street.each do |street|
     			@address.store(street , Build.find(:all, :conditions => ['street_id = ?', street.id ]) )
     		end
    	end
		end
	end
end