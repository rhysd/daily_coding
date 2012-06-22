# -*- coding: utf-8 -*-

class User < SmartTwitter::GenericUser
  self.table_name = 'smart_twitter_users'
  has_many :answers
  has_many :favs

end
