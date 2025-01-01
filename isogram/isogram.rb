class Isogram
  def self.isogram?(word)
    thing = word.downcase.scan(/[a-z]/)
    thing == thing.uniq
  end
end
