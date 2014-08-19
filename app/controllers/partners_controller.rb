class PartnersController < ApplicationController
	before_filter :signed_in_user

	def index
		@partners = Partner.all
	end

	def show
		@partner = Partner.find(params[:id])
		@partnername = @partner.name if @partner.name != nil
		@contracts = @partner.contracts
	end

	def new
		@partner = Partner.new
	end

	def create
		@partner = Partner.new(params[:partner])
		if @partner.save
    	okmessage = "Контрагент " + @partner.name + " успешно добавлен."
      flash[:success] = okmessage
      redirect_to @partner
    else
      render 'new'
    end
	end

	def edit
		@partner = Partner.find(params[:id])
	end

	def destroy
    partner = Partner.find(params[:id]).destroy
    flash[:success] = "Контрагент " + partner.name + " удален."
    redirect_to partners_path
  end

end
