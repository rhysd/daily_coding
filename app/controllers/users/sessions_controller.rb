class Users::SessionsController < Devise::SessionsController
  def new
    redirect_to :problems_today
  end

  # def destroy
  #   redirect_to :root
  # end
end
