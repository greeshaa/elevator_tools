# -*- encoding : utf-8 -*-
class ContractsController < ApplicationController
before_filter :signed_in_user
	def index
		@contracts = Contract.all.order(:number)
	end

	def show
		@contract = Contract.find(params[:id])
		@lifts = @contract.lifts
	end

	def new
		@contract = Contract.new
		@partners = Partner.all.order(:name)
	end

	def create
		@contract = Contract.new(params[:contract])
    if @contract.save
    	okmessage = "Договор " + @contract.number + " успешно добавлен."
      flash[:success] = okmessage
      redirect_to @contract
    else
      render 'new'
    end
	end

	def edit
		@contract = Contract.find(params[:id])
		@partners = Partner.all.order(:name)
	end

	def update
		@contract = Contract.find(params[:id])
    if @contract.update_attributes(params[:contract])
      flash[:success] = "Договор " + @contract.number + " обновлен"
      redirect_to @contract
    else
      render 'edit'
    end

	end

	def lift_move
		@contract  = Contract.find(params[:id])
		@contracts = Contract.all.order(:number)
		@lifts     = @contract.lifts
	end

end