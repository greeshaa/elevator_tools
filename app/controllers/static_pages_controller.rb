# -*- encoding : utf-8 -*-
class StaticPagesController < ApplicationController
before_filter :signed_in_user

  def main
    @main_page_banners = []
    messages.each do |m|
      if m[:count] == 0
      else
        message = Hash.new
        message[:color] = m[:color]
        message[:icon]  = m[:icon]
        message[:count] = m[:count]
        message[:name]  = m[:name]
        message[:note]  = m[:note]
        message[:link]  = m[:link]
        @main_page_banners.push(message)
      end
    end
    @equipment_movements = EquipmentMovement.order(created_at: :desc).first(3)
    @nodes_last          = Node.order(created_at: :desc).first(3)
  end

  def about
  end

  def statistics
  end
end