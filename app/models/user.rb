# -*- coding: utf-8 -*-

class User < SmartTwitter::GenericUser
  self.table_name = 'smart_twitter_users'
  has_many :answers, :include => :favs, :dependent => :destroy
  has_many :favs, :dependent => :destroy

end
