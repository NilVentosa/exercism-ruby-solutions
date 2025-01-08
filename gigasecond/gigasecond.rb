class Gigasecond
  def self.from(input_time)
    Time.at(1000000000) + input_time.to_r
  end
end
