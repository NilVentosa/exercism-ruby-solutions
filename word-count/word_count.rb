class Phrase
  def initialize(phrase)
    @words = phrase.downcase.scan(/\b[\w']+\b/)
  end

  def word_count
    @words.tally
  end
end
