# -*- coding: utf-8 -*-

desc "update proposal colum on problem table" 
task :cron => :environment do
  Problem.close_today
end
