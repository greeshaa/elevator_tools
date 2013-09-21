# -*- encoding : utf-8 -*-

class StreetsController < ApplicationController
before_filter :signed_in_user

  def show
    @street = Street.find(params[:id])
    @builds = @street.builds.paginate(page: params[:page])
  end

  def new
  	@street = Street.new
  end

  def create
    @street = Street.new(params[:street])
    if @street.save
    	okmessage = "Улица " + @street.name + " успешно добавлена."
      flash[:success] = okmessage
      redirect_to @street
    else
      render 'new'
    end
  end

  def edit
     @street = Street.find(params[:id])
  end

  def update
    @street = Street.find(params[:id])
    if @street.update_attributes(params[:street])
      flash[:success] = "Улица " + @street.name + " обновлена"
      redirect_to @street
    else
      render 'edit'
    end
  end

  def index
    @streets = Street.paginate(page: params[:page])
  end

end