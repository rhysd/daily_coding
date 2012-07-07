# -*- coding: utf-8 -*-

require 'date'

FactoryGirl.define do
  factory :user do
    sequence(:login) { |n| "user#{n}" }
    sequence(:twitter_id, 10000)
    access_token "token"
    access_secret "secret"
    sequence(:remember_token) { |n| "remember_token#{n}" }
    remember_token_expires_at Time.now + 10.days.ago
    name "ゆううきてすと"
    location "Kyoto"
    description "しんじゃ"
    profile_image_url "http://examples.com/image"
    url "http://yuuki.org"
    protected false
    friends_count 200
    statuses_count 5000
    followers_count 100
    favourites_count 900
    # t.integer  "utc_offset"
    time_zone "Asia/Tokyo"

    factory :user_with_answers do
      ignore do
        answers_count 5
      end

      after(:create) do |user, evaluator|
        FactoryGirl.create_list(:answer, evaluator.answers_count)
      end
    end
  end

  factory :problem do
    content "no proposed html"
    sequence(:url) { |n| "http://problem.com/#{n}" }
    proposed false
    proposed_at Date.today
    created_at Time.now - 10.days.ago
    updated_at Time.now - 10.days.ago

    factory :problem_with_answers do
      ignore do
        answers_count 5
      end

      after(:create) do |problem, evaluator|
        FactoryGirl.create_list(:answer, evaluator.answers_count, problem: problem)
      end
    end
  end

  factory :answer do
    sequence(:url) { |n| "https://gist.github.com/#{n}" }
    lang "ruby"
    body "html ruby sample code"
    created_at Time.now - 1.hours.ago
    updated_at Time.now - 1.hours.ago
    user
    problem
  end
end
