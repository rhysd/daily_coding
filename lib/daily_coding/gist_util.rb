module DailyCoding
  module GistUtil

    LANG2EXT_TABLE = {
      'C' => 'c',
      'C++' => 'cpp',
      'C#' => 'cs',
      'Clojure' => 'clj',
      'CoffeeScript' => 'coffee',
      'Common Lisp' => 'clisp',
      'Coq' =>  'v',
      'D' => 'd',
      'Erlang' => 'erl',
      'F#' => 'fs',
      'Fortran' => 'for',
      'Go' => 'go',
      'Groovy' => 'groovy',
      'Haskell' => 'hs',
      'Io' => 'io',
      'Java' => 'java',
      'JavaScript' => 'js',
      'Lua' => 'lua',
      'Objective-C' => 'objc',
      'Ocaml' => 'ml',
      'Perl' => 'pl',
      'PHP' => 'php',
      'Prolog' => 'pro',
      'Python' => 'py',
      'Ruby' => 'rb',
      'Scala' => 'scala',
      'Smalltalk' => 'st',
      'Standard ML' => 'sml',
      'Others' => 'txt',
    }

    def gist_url?(url)
      uri = URI.parse(url)
      uri.host == "gist.github.com" && uri.path =~ /\d{1,8}/ # github.com/12345678
    end

    def gist_content_by_url(url)
      uri = URI.parse(url + '.json')
      begin
        content = uri.read
      rescue
        return nil
      end
      (content.status == "404" || content.status == "302" || gist_url?(url) == false) and return nil
      hash_from_gist(content)
    end

    def convert2ext(lang)
      LANG2EXT_TABLE[lang.to_s].presence or 'txt'
    end

    private

    def hash_from_gist(content)
      json = JSON.parse content
      json['div']
    end

  end
end
