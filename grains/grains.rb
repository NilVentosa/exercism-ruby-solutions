module Grains

  VALID_SQUARES_RANGE = (1..64)

  def self.square(square_number)
    raise(ArgumentError) unless VALID_SQUARES_RANGE.include?(square_number)
    2 ** (square_number - 1)
  end

  def self.total
    (2 ** VALID_SQUARES_RANGE.last) - 1
  end

end
