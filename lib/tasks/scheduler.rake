# -*- coding: utf-8 -*-

desc "update proposal colum on problem table" 
task :cron => :environment do
  problem = Problem.today
  problem.proposed = true
  problem.save
end
