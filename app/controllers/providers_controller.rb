# -*- encoding : utf-8 -*-
class ProvidersController < ApplicationController
	before_filter :signed_in_user
	def index
		@providers = Provider.all
	end
end
