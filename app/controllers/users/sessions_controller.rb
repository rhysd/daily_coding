class Users::SessionsController < ApplicationController
  def new
    # token = session[:oauth_token]
    # Github API Clinet
    redirect_to :problems_today
  end

  def destroy
    session[:oauth_token] = nil
    redirect_to :root
  end
end
