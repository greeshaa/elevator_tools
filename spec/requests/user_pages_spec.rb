# -*- encoding : utf-8 -*-

require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }

    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.runame) }
    it { should have_selector('title', text: user.runame) }

    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end
  end


  describe "signup page" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit signup_path
    end

    it { should have_selector('h1',    text: 'Добавление пользователя') }
    it { should have_selector('title', text: full_title('Добавление пользователя')) }
  end

  describe "signup" do

    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit signup_path
    end

    let(:submit) { "Добавить пользователя" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Логин:",         with: "Example User"
        fill_in "Имя пользователя:",         with: "Example User"
        fill_in "Адрес электронной почты:",  with: "user@example.com"
        fill_in "Пароль:",     with: "foobar"
        fill_in "Подтверждение пароля:", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
     sign_in user 
     visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Редактирование профиля") }
      it { should have_selector('title', text: "Редактирование профиля") }
    end

    describe "with invalid information" do
      before { click_button "Сохранить изменения" }

      it { should have_content('error') }
    end
  end
end