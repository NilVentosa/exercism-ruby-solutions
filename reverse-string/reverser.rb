class Reverser
  def self.reverse(thing)
    # I guess I should not use String.reverse
    thing.chars.inject('') { |acc, char| acc.prepend(char) }
  end
end
