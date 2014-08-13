# -*- encoding : utf-8 -*-
class ContractsController < ApplicationController
	def index
		@contracts = Contract.all		
	end

	def show
		@contract = Contract.find(params[:id])	
		@lifts = @contract.lifts	
	end

end
