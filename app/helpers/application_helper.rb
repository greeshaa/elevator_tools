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

  def page_header(page_title)
    if page_title.empty?
      "??? Нет названия ???"
    else
      "#{page_title}"
    end
  end

  def current_user=(user)
    @current_user = user
  end

  def to_phones(phone)
    i = phone.to_s.split('')
    case i.length
    when 11
        s = i[0]+"-"+i[1]+i[2]+i[3]+"-"+i[4]+i[5]+i[6]+"-"+i[7]+i[8]+"-"+i[9]+i[10]
    when 6
        s = i[0]+i[1]+"-"+i[2]+i[3]+"-"+i[4]+i[5]
    else
    end
    s
  end

end
