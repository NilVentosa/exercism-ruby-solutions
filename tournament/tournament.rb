class Tournament

  TEMPLATE = "%-30s | %2s | %2s | %2s | %2s | %2s\n"

  def self.generate_result(tally)
    result_lines = [TEMPLATE % ["Team", "MP", "W", "D", "L", "P"]]
    tally.values.sort.each { |team| result_lines << generate_result_line(team) }
    result_lines.join
  end

  def self.generate_result_line(team)
      TEMPLATE % [ team.name, team.matches_played, team.win, team.draw, team.loss, team.points ]
  end

  private_class_method :generate_result, :generate_result_line

  def self.tally(results)
    tally = {}

    results.each_line do |line|
      next if line.strip.empty?
      team_a, team_b, game_result = line.split(";")
      tally[team_a] = Standing.new(team_a) unless tally.key?(team_a)
      tally[team_b] = Standing.new(team_b) unless tally.key?(team_b)

      case game_result.strip
      when 'win'
        tally[team_a].win += 1
        tally[team_b].loss += 1
      when 'loss'
        tally[team_b].win += 1
        tally[team_a].loss += 1
      when 'draw'
        tally[team_b].draw += 1
        tally[team_a].draw += 1
      end
    end

    generate_result(tally)
  end
end

class Standing

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
    win * 3 + draw
  end

  def <=>(other)
    return other.points <=> points unless points == other.points
    name <=> other.name
  end

end
