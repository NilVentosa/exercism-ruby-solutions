class Clock

  MINUTES_IN_DAY = 1440
  MINUTES_IN_HOUR = 60

  private_constant :MINUTES_IN_DAY, :MINUTES_IN_HOUR

  private attr_writer :minutes

  def initialize(hour: 0, minute: 0)
    self.minutes = (hour * MINUTES_IN_HOUR + minute) % MINUTES_IN_DAY
  end

  attr_reader :minutes

  def to_s
    '%02d:%02d' % minutes.divmod(MINUTES_IN_HOUR)
  end

  def ==(other)
    minutes == other.minutes
  end

  def +(other)
    Clock.new(minute: minutes + other.minutes)
  end

  def -(other)
    self + Clock.new(minute: -other.minutes)
  end

end
