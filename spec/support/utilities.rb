# -*- encoding : utf-8 -*-

include ApplicationHelper

#def full_title(page_title)
#  base_title = "ЗАО Томсклифтремонт"
#  if page_title.empty?
#    base_title
#  else
#    "#{base_title} | #{page_title}"
#  end
#end

def sign_in(user)
  visit signin_path
  fill_in "Имя пользователя", with: user.name
  fill_in "Пароль",           with: user.password
  click_button "Войти"
  # Вход без Capybara.
  cookies[:remember_token] = user.remember_token
end