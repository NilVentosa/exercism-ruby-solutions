class Hamming
  def self.compute(one, two)
    raise ArgumentError if one.size != two.size

    one.chars.zip(two.chars).count { |a, b| a != b }
  end
end
