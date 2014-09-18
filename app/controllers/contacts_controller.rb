# -*- encoding : utf-8 -*-
class ContactsController < ApplicationController
	before_filter :signed_in_user

	def new
		@contact = Contact.new
		@@partner = Partner.find(params[:id])
	end

	def create
		@contact = @@partner.contacts.create(params[:contact])
		if @contact.save
			okmessage = "Контактное лицо успешно добавлено."
      flash[:success] = okmessage
      redirect_back_or_default(store_location)
		else
			flash[:success] = "something is wrong"
    end
	end

	def add_existing
		@contacts = Contact.all
		@@partner = Partner.find(params[:id])
	end

	def add_existing_save
		@contact = Contact.find_by_id(params[:contact_id])
		@@partner.contacts<<@contact
		if @contact.save
			okmessage = "Контактное лицо успешно добавлено."
      flash[:success] = okmessage
      redirect_back_or_default(store_location)
		else
			flash[:success] = "something is wrong"
    end
	end

	def edit
		@contact = Contact.find(params[:id])
	end

	def update
		@contact = Contact.find(params[:id])
    if @contact.update_attributes(params[:contact])
      flash[:success] = "Контактные данные обновлены"
      redirect_back_or_default(store_location)
    else
      render 'edit'
    end
	end

	def destroy
    contact = Contact.find(params[:id]).destroy
    flash[:success] = "Контактные данные удалены"
    redirect_back_or_default(store_location)
  end
end
