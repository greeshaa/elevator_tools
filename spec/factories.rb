FactoryGirl.define do
  factory :user do
    name     "first.last"
    email    "first.last@tomsklift.ru"
    password "123456"
    password_confirmation "123456"
  end
end