class Anagram
  def initialize(word)
    @word = word
  end

  def match(args)
    word_tally = @word.downcase.chars.tally
    args.select { |arg| arg.downcase.chars.tally == word_tally && arg.downcase != @word.downcase }
  end
end
