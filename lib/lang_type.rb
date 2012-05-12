module DailyCoding

    require 'open-uri'
    require 'nokogiri'
    require './errors'

    def lang_type(url)
        doc = Nokogiri::HTML open(url)
        doc.xpath('//div[@class="file"]/div').each do |div|
            return $1 if div.get_attribute("class") =~ /^data type-(.*)$/
        end
        raise LangTypeNotFound,url
    end

end
