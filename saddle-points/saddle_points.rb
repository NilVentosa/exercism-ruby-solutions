module Grid

  private

  def self.indices(array, item)
    indices = []
    array.each_with_index do |value, index|
      indices << index if value == item
    end
  end

  def self.indices_of_max(array)
    indices(array, array.max)
  end

  def self.indices_of_min(array)
    indices(array, array.min)
  end

  def column(grid, index)
    grid.map { |row| row[index] }
  end

  public

  def self.saddle_points(grid)
    result = []

    grid.each do |row|
      highest = indices_of_max(row)
      highest.each do |high|
        column = column(grid, high)
        lows = indices_of_min(column)
        lows.each do |low|
          result << { "row" => low + 1, "column" => high + 1 } if 
        end
      end
    end

    result.uniq
  end

end
