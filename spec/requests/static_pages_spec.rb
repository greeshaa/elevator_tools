# -*- encoding : utf-8 -*-

require 'spec_helper'

describe "Static pages" do
  subject { page }

   let(:user) { FactoryGirl.create(:user) }

  describe "Main page" do
    
  	before do
     sign_in user 
     visit main_path 
    end

    # it { should have_selector('h1', text: 'Корпоративный портал') }
    it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector('title', text: '| Главная') }
  end

  describe "About page" do
    before do
     sign_in user 
     visit about_path
    end

    it { should have_selector('h1', text: 'О портале') }
    it { should have_selector('title', text: full_title('О портале')) }
  end

  #it "should have the right links on the layout" do
    #visit root_path
    #click_link "О портале"
    #page.should have_selector 'title', text: full_title('О портале')
    #click_link "Главная"
    #click_link "Вход в систему"
    #page.should have_selector 'title', text: full_title('Вход в систему')
    #click_link "Томсклифтремонт"
    #page.should have_selector 'title', text: full_title('')
  #end

end
