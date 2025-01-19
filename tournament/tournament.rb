module Tournament

  LINE  = "%-30s | %2s | %2s | %2s | %2s | %2s\n"
  HEADER   = %w[Team MP W D L P]
  DELIMITER = ';'
  WIN       = 'win'
  LOSS      = 'loss'
  DRAW      = 'draw'

  def self.to_s(games)
    result = [LINE % HEADER]
    games.values.sort.each { |standing| result << standing.to_s }
    result.join
  end

  def self.tally(games)
    to_s(thing(games))
  end

  def self.thing(games)
    tally = Hash.new { |tally, name| tally[name] = Standing.new(name) }

    games.each_line do |line|
      next if line.strip.empty?
      team_a, team_b, game_result = line.split(DELIMITER)

      case game_result.strip
      when WIN
        tally[team_a].win += 1
        tally[team_b].loss += 1
      when LOSS
        tally[team_b].win += 1
        tally[team_a].loss += 1
      when DRAW
        tally[team_b].draw += 1
        tally[team_a].draw += 1
      end
    end
    tally
  end

  def self.line
    LINE
  end

end

class Standing

  POINTS_PER_WIN = 3

  def initialize(name)
    @name = name
    @win  = 0
    @loss = 0
    @draw = 0
  end

  protected

  def <=>(other)
    return other.points <=> points unless points == other.points
    name <=> other.name
  end

  def matches_played
    win + loss + draw
  end

  def points
    win * POINTS_PER_WIN + draw
  end

  public

  attr_accessor :win, :loss, :draw, :name

  def to_s
    Tournament.line % [name, matches_played, win, draw, loss, points]
  end

end
