# -*- coding: utf-8 -*-

class User < SmartTwitter::GenericUser
  self.table_name = 'smart_twitter_users'
  has_many :answer
  has_many :fav

end
