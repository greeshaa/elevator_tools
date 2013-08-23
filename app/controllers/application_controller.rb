# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
protect_from_forgery
  include SessionsHelper

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
  
  def signed_in_user
    redirect_to signin_url, notice: "Пожалуйста, авторизируйтесь!" unless signed_in?
  end

end
