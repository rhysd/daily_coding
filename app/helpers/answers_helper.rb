module AnswersHelper
  def current_user_faved?(answer)
    favs = answer.fav
    favs.each do |fav|
      return true if fav.user_id == current_user.id
    end
    false
  end
end
