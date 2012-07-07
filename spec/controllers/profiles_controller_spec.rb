require 'spec_helper'

describe ProfilesController do
  before(:each) do
    user = FactoryGirl.create(:user_with_answers)
    current_user= user
    FactoryGirl.create(:problem_with_answers)
  end

  describe "GET 'codes/:user_id'" do
    it "returns 200 status" do
      get 'codes', params = {:user_id => 1}
      response.should be_success
    end
  end

  describe "GET 'stared_codes/:user_id'" do
    it "returns 200 status" do
      get 'stared_codes', params = {:user_id => 1}
      response.should be_success
    end
  end

end
