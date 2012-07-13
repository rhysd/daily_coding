# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentication, :class => 'Authentications' do
    user_id 1
    provider "MyString"
    uid "MyString"
    screen_name "MyString"
    name "MyString"
    access_token "MyString"
    access_secret "MyString"
    bio "MyString"
    image_url "MyString"
    web_url "MyString"
  end
end
