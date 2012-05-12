# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 繰り返し実行されることを考慮
Problem.delete_all

(1..383).each do |no|
    File.open("db/euler/#{no}.data","r") do |file|
        texts = file.read.split "\n"
        url = texts.shift
        texts.shift
        content = texts.join "\n"
        Problem.create(content: content, url: url)
    end
end
