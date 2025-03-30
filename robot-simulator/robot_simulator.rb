class Robot

  DIRECTION = %i[east south west north]

  private

  def initialize(x: 0, y: 0, bearing: :north)
    @coordinates = [x, y]
    @bearing = bearing
  end

  def turn(side)
    index_modifier = {left: -1, right: 1}[side] || raise(DirectionError "Invalid direction #{side}")

    new_index = (DIRECTION.find_index(bearing) + index_modifier) % 4
    orient(DIRECTION[new_index])
  end

  private_constant :DIRECTION

  public

  attr_accessor :coordinates, :bearing

  def at(x, y)
    self.coordinates = [x, y]
  end

  def orient(bearing)
    DIRECTION.include?(bearing) ? self.bearing = bearing : raise(ArgumentError)
  end

  def turn_right
    turn :right
  end

  def turn_left
    turn :left
  end

  def advance
    movement = {
      north: [0, 1],
      east:  [1, 0],
      south: [0, -1],
      west:  [-1, 0]
    }

    dx, dy = movement[bearing]
    self.coordinates[0] += dx
    self.coordinates[1] += dy
  end

end

class Simulator

    LETTER_TO_INSTRUCTION = {L: :turn_left, R: :turn_right, A: :advance}

  private

  def parse_instruction(letter)
    LETTER_TO_INSTRUCTION[letter.to_sym]
  end

  private_constant :LETTER_TO_INSTRUCTION

  public

  def instructions(raw_instructions)
    raw_instructions.chars.map { |raw_instruction| parse_instruction(raw_instruction) }
  end

  def place(robot, x:, y:, direction:)
    robot.at(x, y)
    robot.orient(direction)
  end

  def evaluate(robot, raw_instructions)
    instructions(raw_instructions).each { |instruction| robot.public_send(instruction) }
  end

end

class DirectionError < ArgumentError
end
