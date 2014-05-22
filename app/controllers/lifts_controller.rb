# -*- encoding : utf-8 -*-
class LiftsController < ApplicationController
before_filter :signed_in_user

  def show
  	@lift   = Lift.find(params[:id])
  	@porch  = @lift.porch
    if @porch.nil?
      @build_name  = 'Номер здания неизвестен' 
      @street_name = 'Улица неизвестна'
      @city_name   = 'Населенный пункт неизвестен'

    else
  	@build  = @porch.build  
  	@street = @build.street
    @city   = @street.city
    @node   = @build.node
    end
    @date_of_decommiss = @lift.introduced_at + 25

  end
  def index
  	#@lifts = Lift.search(params[:search])
    if Lift.search(params[:search]).nil?
    else
      streets = Street.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
      if streets.empty?
        @lifts = Lift.search(params[:search])
      else
        @lifts = Lift.search(params[:search])
        streets.each do |s|
          lifts = s.lifts
          lifts.each do |n|
            @lifts.push(n)
          end
        end
      end   
    end 
  end

  def new
    @streets = Street.all
    @builds = Build.all
    @porch = Porch.all
    @lift = Lift.new 
  end

  def inspections
    @lifts = Lift.all
  end

  def list
    @lifts = Lift.all
  end

  def fulliftsdata
    @lifts = Lift.all
  end
 
end
