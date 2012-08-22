module ProblemsHelper
  def author_for_each_answers(answers)
    answers.map(&:user)
  end

  def answers_by_lang(answers, lang)
    answers.select {|a| a.lang == lang}
  end

  def langs
    DailyCoding::GistUtil::LANG2EXT_TABLE.keys
  end
end
