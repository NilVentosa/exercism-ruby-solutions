class Die
  def initialize(sides: 6)
    @value = rand(1..sides)
  end

  attr_reader :value
end

class Roll
  private

  ##
  # Creates a new dice roll
  # @param sides How many sides does each die have
  # @param die how many dies will roll
  # @param drop Which die should we drop, :lowest, :highest or default: nil
  def initialize(sides: 6, die:, drop: nil)
      @sides = sides
      @die = die
      @drop = drop
  end

  public

  attr_reader :sides, :die, :drop

  def total
    total = die.times.map { Die.new(sides: sides).value }
    case drop
    when :lowest then total = total.max(die - 1)
    when :highest then total = total.min(die - 1)
    end
    total.sum
  end
end

class DndCharacter

  def self.modifier(constitution)
    (constitution.to_i - 10) / 2
  end

  private

  ATTRIBUTES = %i[strength dexterity constitution intelligence wisdom charisma]
  BASE_HITPOINTS = 10
  DICE_COUNT = 4


  def initialize
    ATTRIBUTES.each { |attr| instance_variable_set("@#{attr}", score) }
  end

  public

  attr_reader(*ATTRIBUTES)

  def hitpoints
    BASE_HITPOINTS + DndCharacter.modifier(constitution)
  end

  def score
    Roll.new(die: DICE_COUNT, drop: :lowest).total
  end

end
