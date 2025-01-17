class Robot

  VALID_DIRECTIONS = %i[east south west north]

  private

  def initialize(x: 0, y: 0, bearing: :north)
    @coordinates = [x, y]
    @bearing = bearing
  end

  def turn(side)
    index_modifier = { left: -1, right: 1 }[side] || raise(ArgumentError)

    new_index = (VALID_DIRECTIONS.find_index(bearing) + index_modifier) % 4
    orient(VALID_DIRECTIONS[new_index])
  end

  private_constant :VALID_DIRECTIONS

  public

  attr_accessor :coordinates, :bearing

  def at(x, y)
    self.coordinates = [x, y]
  end

  def orient(bearing)
    VALID_DIRECTIONS.include?(bearing) ? self.bearing = bearing : raise(ArgumentError)
  end

  def turn_right
    turn :right
  end

  def turn_left
    turn :left
  end

def advance
  movement = { north: [0, 1], east:  [1, 0], south: [0, -1], west:  [-1, 0] }

  dx, dy = movement[self.bearing]
  self.coordinates[0] += dx
  self.coordinates[1] += dy
end

end

class Simulator

  private

  def parse_instruction(letter)
    { L: :turn_left, R: :turn_right, A: :advance }[letter.to_sym]
  end

  public

  def instructions(instructions)
    instructions.chars.map { |instruction| parse_instruction(instruction) }
  end

  def place(robot, x:, y:, direction:)
    robot.at(x, y)
    robot.orient(direction)
  end

  def evaluate(robot, instructions)
    instructions(instructions).each { |instruction| robot.send(instruction) }
  end

end
