class EliudsEggs
  def self.egg_count(num)
    return 0 unless num.positive?
    (num % 2) + egg_count(num / 2)
  end
end
