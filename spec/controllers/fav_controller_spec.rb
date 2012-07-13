require 'spec_helper'

describe FavController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @problem = FactoryGirl.create(:problem)
    @answer = FactoryGirl.create(:answer)
    FactoryGirl.create(:fav, user: @user, answer: @answer)
  end

  context "when a user logins" do
    before(:each) do
      controller.stub(:user_signed_in?).and_return(true)
      controller.stub!(:current_user).and_return(@user)
    end

    describe "POST 'create'" do
      before(:each) do
        post 'create', params = { :answer_id => @answer.id }
      end
      it "returns created status" do
        response.status.should be(201)
      end
    end

    describe "DELETE 'destroy'" do
      before(:each) do
        delete 'destroy', params = { :answer_id => @answer.id }
      end
      it "returns success status" do
        response.should be_success
      end
    end
  end

  context "when a user doesn't 'login" do
    before(:each) do
      controller.stub(:user_signed_in?).and_return(false)
    end

    describe "POST 'create'" do
      before(:each) do
        post 'create', params = { :answer_id => @answer.id }
      end
      it "returns unauthorized status" do
        response.status.should be(401)
      end
    end

    describe "DELETE 'destroy'" do
      before(:each) do
        delete 'destroy', params = { :answer_id => @answer.id }
      end
      it "returns unauthorized status" do
        response.status.should be(401)
      end
    end

  end
end
