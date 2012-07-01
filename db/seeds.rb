require 'date'

# 繰り返し実行されることを考慮
Problem.delete_all

(1..383).each do |no|
  File.open("db/euler/#{no}.data","r") do |file|
    texts = file.read.split "\n"
    url = texts.shift
    texts.shift
    content = texts.join "\n"
    Problem.create(content: content, url: url, proposed_at: Date.today + no - 1)
  end
end
