module AnswersHelper

  def current_user_faved?(answer)
    favs = answer.favs
    favs.each do |fav|
      return true if logged_in? && fav.user_id == current_user.id
    end
    false
  end

end
