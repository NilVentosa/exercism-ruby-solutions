class Tournament

  TEMPLATE = "%-30s | %2s | %2s | %2s | %2s | %2s\n"
  HEADERS = ["Team", "MP", "W", "D", "L", "P"]
  DELIMITER = ';'
  WIN = 'win'
  LOSS = 'loss'
  DRAW = 'draw'

  def self.generate_result(tally)
    result = [TEMPLATE % HEADERS]
    tally.values.sort.each { |standing| result << generate_standing_result(standing) }
    result.join
  end

  def self.generate_standing_result(standing)
      TEMPLATE % [ standing.name, standing.matches_played, standing.win, standing.draw, standing.loss, standing.points ]
  end

  private_class_method :generate_result, :generate_standing_result

  def self.tally(games)
    tally = Hash.new { |hash, key| hash[key] = Standing.new(key) }

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

    generate_result(tally)
  end

end

class Standing

  POINTS_PER_WIN = 3

  def initialize(name)
    @name = name
    @win = 0
    @loss = 0
    @draw = 0
  end

  attr_accessor :win, :loss, :draw, :name

  def matches_played
    win + loss + draw
  end

  def points
    win * POINTS_PER_WIN + draw
  end

  def <=>(other)
    return other.points <=> points unless points == other.points
    name <=> other.name
  end

end
