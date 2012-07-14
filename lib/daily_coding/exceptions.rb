module DailyCoding
  module Exceptions

    class LangTypeNotFound < StandardError
    end

    class InvalidURLError < StandardError
    end

    class NoProblemError < StandardError
    end

    class InvalidResourceError < StandardError
    end
  end
end
