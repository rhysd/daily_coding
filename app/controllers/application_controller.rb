class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :twitter_client

  rescue_from DailyCoding::Exceptions::InvalidURLError, :with => :error_page
  rescue_from DailyCoding::Exceptions::NoProblemError, :with => :error_page
  rescue_from ActiveRecord::RecordInvalid, :with => :error_page
  rescue_from DailyCoding::Exceptions::InvalidResourceError, :with => :error_page

  def twitter_client
    @twitter_clinet ||= Twitter.configure do |config|
      config.consumer_key = Devise.omniauth_configs[:twitter].args.first
      config.consumer_secret = Devise.omniauth_configs[:twitter].args.last
      config.oauth_token = current_user.twitter.access_token
      config.oauth_token_secret = current_user.twitter.access_secret
    end
  end

  private

  def error_page(e)
    @error_message = e
    render :template => 'application/error', :layout => 'application'
  end
end
