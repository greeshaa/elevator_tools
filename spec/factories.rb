# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :user do
    sequence(:name)    { |n| "login #{n}" }
    sequence(:runame)  { |n| "Person #{n}" }
    sequence(:email)   { |n| "person_#{n}@example.com"}
    password "123456"
    password_confirmation "123456"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
end
