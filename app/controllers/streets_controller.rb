# -*- encoding : utf-8 -*-
class StreetsController < ApplicationController
before_filter :signed_in_user

  def index
    @streets = Street.search(params[:search]).sort_by(&:"#{:name}")
  end

  def show
    @street = Street.find(params[:id])
    @streetkind = @street.street_kind.name
    @builds = @street.builds.order(:name)
  end

  def new
  	@street = Street.new
    @city = City.all
    @streetkind = StreetKind.all
  end

  def create
    @city = City.all
    @streetkind = StreetKind.all
    @street = Street.new(params[:street])
    if @street.save
    	okmessage = @street.street_kind.full_name + ' ' + @street.name + " успешно добавлен(а)."
      flash[:success] = okmessage
      redirect_to @street
    else
      render 'new'
    end
  end

  def edit
     @street = Street.find(params[:id])
     @city = City.all
    @streetkind = StreetKind.all
  end

  def update
    @street = Street.find(params[:id])
    if @street.update_attributes(params[:street])
      flash[:success] = @street.street_kind.name + @street.name + " успешно обновлен(а)"
      redirect_to @street
    else
      render 'edit'
    end
  end
end
