class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from DailyCoding::Exceptions::InvalidURLError, :with => :error_page

  private

  def error_page(e)
    @error_message = e
    render :template => 'application/error'
  end
end
