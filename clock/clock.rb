class Clock

  private attr_writer :minutes

  def initialize(hour: 0, minute: 0)
    self.minutes = (hour * 60 + minute) % 1440
  end

  attr_reader :minutes

  def to_s
    h, m = minutes.divmod(60)
    '%02d:%02d' % [h, m]
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
