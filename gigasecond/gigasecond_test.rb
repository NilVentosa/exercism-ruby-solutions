require 'minitest/autorun'
require_relative 'gigasecond'

class GigasecondTest < Minitest::Test
  def test_full_time_specified
    assert_equal Time.utc(2046, 10, 2, 23, 46, 40), Gigasecond.from(Time.utc(2015, 1, 24, 22, 0, 0))
  end

  def test_full_time_with_day_roll_over
    assert_equal Time.utc(2046, 10, 3, 1, 46, 39), Gigasecond.from(Time.utc(2015, 1, 24, 23, 59, 59))
  end
end
