# -*- encoding : utf-8 -*-
class ContractsController < ApplicationController

	def index
		@contracts = Contract.all
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
      flash[:success] = @contract.number + " обновлен"
      redirect_to @contract
    else
      render 'edit'
    end

	end

end