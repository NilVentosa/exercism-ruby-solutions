class SpiralMatrix
  attr_accessor :size

  def initialize(size)
    @size = size
  end

  def matrix
    return [] if size.zero?
    return [[1]] if size == 1

    d =  [[0, 1], [1, 0], [0, -1], [-1, 0]]
    di = 0

    result = Array.new(rows) { Array.new(columns, -1) }
    x = 0
    y = 0

    (size * size).times do |thing|
      result[y][x] = thing
      x += d[di][0]
      y += d[di][1]
    end
  end
end
