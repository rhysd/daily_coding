#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'open-uri'
require 'nokogiri'

#
# main
#
if __FILE__ == $0 then

    (1..383).each do |no|
        puts "#{no}..."
        url = "http://odz.sakura.ne.jp/projecteuler/index.php?cmd=read&page=Problem%20#{no}"
        doc = Nokogiri::HTML open(url)
        text = doc.xpath('//div[@id="body"]')[0]
        text.xpath('.//h2[@id="content_1_0"]')[0].unlink
        File.open("#{no}.data","w") do |f|
            f.puts url
            f.puts
            f.puts text
        end
        sleep 1
    end

end

