# -*- encoding : utf-8 -*-
class ProvidersController < ApplicationController
	def index
		@providers = Provider.all		
	end
end
