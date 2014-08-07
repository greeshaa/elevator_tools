# -*- encoding : utf-8 -*-

module ApplicationHelper

	# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "elevatorTools"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def current_user=(user)
    @current_user = user
  end

  
  
end
