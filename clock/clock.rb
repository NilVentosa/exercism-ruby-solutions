class Clock

  MINUTES_IN_DAY = 1440
  MINUTES_IN_HOUR = 60
  CLOCK_FACE = '%<hour>02i:%<minute>02i'

  private_constant :MINUTES_IN_DAY, :MINUTES_IN_HOUR, :CLOCK_FACE

  private attr_writer :minutes

  def initialize(hour: 0, minute: 0)
    self.minutes = (hour * MINUTES_IN_HOUR + minute) % MINUTES_IN_DAY
  end

  protected attr_reader :minutes

  def to_s
    CLOCK_FACE % { hour:, minute: }
  end

  def ==(other)
    minutes == other.minutes
  end

  def +(other)
    self.minutes = (minutes + other.minutes) % MINUTES_IN_DAY
    self
  end

  def -(other)
    self.minutes = (minutes - other.minutes) % MINUTES_IN_DAY
    self
  end

  def hour
    minutes / MINUTES_IN_HOUR
  end

  def minute
    minutes % MINUTES_IN_HOUR
  end

end
