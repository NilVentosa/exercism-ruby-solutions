class Roll
  private

  def initialize(sides:, die:, drop: nil)
      @sides = sides
      @die = die
      @drop = drop
  end

  def roll
    rand(1..@sides)
  end

  public

  def total
    total = @die.times.map { roll }
    case @drop
    when :lowest then total = total.max(@die - 1)
    when :highest then total = total.min(@die - 1)
    end
    total.sum
  end
end

class DndCharacter

  ATTRIBUTES = %i[strength dexterity constitution intelligence wisdom charisma]
  BASE_HITPOINTS = 10
  DICE_SIDES = 6
  DICE_COUNT = 4

  def self.modifier(constitution)
    (constitution.to_i - 10) / 2
  end

  private

  def initialize
    ATTRIBUTES.each { |attr| instance_variable_set("@#{attr}", score) }
  end

  public

  attr_reader(*ATTRIBUTES)

  def hitpoints
    BASE_HITPOINTS + DndCharacter.modifier(constitution)
  end

  def score
    Roll.new(sides: DICE_SIDES, die: DICE_COUNT, drop: :lowest).total
  end

end
