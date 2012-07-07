require 'spec_helper'

describe ProblemsController do
  before(:each) do
    user = FactoryGirl.create(:user_with_answers)
    current_user= user
    FactoryGirl.create(:problem_with_answers)
  end

  describe "GET 'index'" do
    it "returns 200 status" do
      get 'index', params = {:page => 1}
      response.should be_success
    end
  end

  describe "GET 'show/:id'" do
    it "returns 200 status" do
      get 'show', params = {:id => 1}
      response.should be_success
    end
  end

  describe "GET 'show/today'" do
    it "returns 200 status" do
      get 'today', params = {:id => 1}
      response.should be_success
    end
  end

end
