class Tournament

  TEMPLATE  = "%-30s | %2s | %2s | %2s | %2s | %2s\n"
  HEADERS   = %w[Team MP W D L P]
  DELIMITER = ';'
  WIN       = 'win'
  LOSS      = 'loss'
  DRAW      = 'draw'

  def self.to_s(tally)
    result = [TEMPLATE % HEADERS]
    tally.values.sort.each { |standing| result << standing.to_s }
    result.join
  end

  def self.tally(games)
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

    def self.template
      TEMPLATE
    end

    to_s(tally)
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

  attr_accessor :win, :loss, :draw, :name

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

  def to_s
      Tournament.template % [name, matches_played, win, draw, loss, points]
  end

end
