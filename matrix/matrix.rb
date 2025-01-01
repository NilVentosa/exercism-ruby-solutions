class Matrix
  def initialize(matrix)
    @matrix = matrix
    @rows = matrix.split("\n").map { |row| row.split(' ').map(&:to_i) }
  end

  def row(n)
    @rows[n - 1]
  end

  def column(n)
    @rows.map { |row| row[n - 1] }
  end
end
