# -*- coding: utf-8 -*-

class User < SmartTwitter::GenericUser
  set_table_name :smart_twitter_users
  has_many :answer

end
