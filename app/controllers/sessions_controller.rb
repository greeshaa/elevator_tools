# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_name(params[:session][:name].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to main_path
    else
      flash.now[:danger] = 'Неверная комбинация "Имя пользователя/Пароль"' # Not quite right!
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
