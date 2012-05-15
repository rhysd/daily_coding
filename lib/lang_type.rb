module DailyCoding

    require 'open-uri'
    require 'nokogiri'
    require './errors.rb'

    def lang_type(url)
        doc = Nokogiri::HTML open(url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE)
        result = doc.xpath('//div[@class="file"]/div').each do |div|
            if div.get_attribute("class") =~ /^data type-(.*)$/
                type = $1
                case type
                when "c"
                    ext = File.extname doc.xpath('//div[@class="file"]')[0].get_attribute("id")
                    type = "cpp" if %w[ .cpp .cc .cxx ].include? ext
                when "viml"
                    type = "vim"
                end
                return type
            end
        end
        raise LangTypeNotFound,url
    end

end
