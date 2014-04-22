# -*- encoding : utf-8 -*-
module SessionsHelper

  def sign_in(user)
    #remember_token = User.new_remember_token
    #cookies.permanent[:remember_token] = remember_token
    #user.update_attribute(:remember_token, User.encrypt(remember_token))
    #self.current_user = user
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    #redirect_to signin_url, warning: "Пожалуйста, авторизируйтесь!" unless signed_in?
    unless signed_in?
      flash[:warning] = "Пожалуйста, авторизируйтесь!"
      redirect_to signin_url
    end
  end

  def sign_out
    #current_user.update_attribute(:remember_token,
    #                              User.encrypt(User.new_remember_token))
    #cookies.delete(:remember_token)
    #self.current_user = nil
    self.current_user = nil
    cookies.delete(:remember_token)
  end
end
