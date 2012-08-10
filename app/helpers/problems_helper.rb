module ProblemsHelper
  def langs
    DailyCoding::GistUtil::LANG2EXT_TABLE.keys
  end
end
