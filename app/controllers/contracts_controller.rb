# -*- encoding : utf-8 -*-
class ContractsController < ApplicationController
before_filter :signed_in_user
	def index
		@contracts_zao = Contract.where(tlr_id: 1).order(:number)
		@contracts_ooo = Contract.where(tlr_id: 2).order(:number)
		@contracts_other = Contract.where(tlr_id: nil).order(:number)
	end

	def show
		store_location
		@contract = Contract.find(params[:id])
		@lifts = @contract.lifts
		@contacts = @contract.partner.contacts
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

	def destroy
    @contract = Contract.find(params[:id]).destroy
    flash[:success] = "Договор " + @contract.number + " успешно удален"
    redirect_back_or_default(store_location)
  end

	def lift_move
		@contract  = Contract.find(params[:id])
		@contracts = Contract.all.order(:number)
		@lifts     = @contract.lifts
	end

	def lift_move_zo
		store_location
		@contract  = Contract.find(params[:id])
		@contracts = Contract.all.order(:number)
		@tlr = Tlr.all
		@lifts    = @contract.lifts.order(:tlr_id, :porch_id)
	end

end