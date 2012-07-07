require 'spec_helper'

describe AnswersController do
  before(:each) do
    user = FactoryGirl.create(:user_with_answers)
    current_user= user
    FactoryGirl.create(:problem_with_answers)
  end

  describe "POST 'create'" do
    before(:each) do
      post 'create', params = { :gisturl => 'https://gist.github.com/2716212', :problem_id => 1 }
    end
    it "returns redirect success status" do
      response.should be_redirect
    end
    it "redirects to problems/show/:id" do
      response.should redirect_to(:controller => 'problems', :action => 'show', :id => 1)
    end
  end

  describe "GET 'destroy'" do
    before(:each) do
      request.env["HTTP_REFERER"] = 'http://test.host/problems/1'
      delete 'destroy', params = {:id => 1}
    end
    it "returns redirect status" do
      response.should be_redirect
    end
    it "redirects to back" do
      response.should redirect_to :back
    end
  end

  describe "GET 'answers/:problem_id'" do
    it "returns 200 status" do
      get 'answers', params = { :problem_id => 1 }
      response.should be_success
    end
  end

  describe "GET 'answers_by_lang/:problem_id/:lang'" do
    it "returns 200 status" do
      get 'answers_by_lang', params = { :problem_id => 1, :lang => 'ruby' }
      response.should be_success
    end
  end
end
