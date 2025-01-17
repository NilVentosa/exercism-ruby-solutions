module Year

  def self.leap?(year)
    return true if year.divisible_by? 400 
    return true if year.divisible_by? 4 unless year.divisible_by? 100
  end

end

class Integer

  def divisible_by?(divisor)
    self % divisor == 0
  end

end
