# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  before_filter :signed_in_user #, only: [:edit, :update, :show ]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user,   only: :destroy #, :edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
    	okmessage = "Пользователь " + @user.name + " успешно добавлен."
      flash[:success] = okmessage
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Профиль обновлен"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.all
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Пользователь удален."
    redirect_to users_url
  end

  private

   # def signed_in_user
   #   redirect_to signin_url, notice: "Please sign in." unless signed_in?
   # end

    def correct_user
      @user = User.find(params[:id])
      redirect_to user_url, notice: "Вы не можете редактировать этого пользователя." unless current_user?(@user) || current_user.admin?
    end

    def admin_user
      redirect_to user_url, notice: "Вы не можете редактировать этого пользователя." unless current_user.admin?
    end

end
