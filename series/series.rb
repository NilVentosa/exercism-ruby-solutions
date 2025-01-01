class Series
  def initialize(serie)
    raise ArgumentError if serie.empty?

    @serie = serie
  end

  def slices(n)
    raise ArgumentError if n > @serie.size || n < 1

    result = []
    while @serie.size >= n
      result.push(@serie[0...n])
      @serie = @serie[1..]
    end
    result
  end
end
