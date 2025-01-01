class ResistorColorDuo
  MAP = %w[black brown red orange yellow green blue violet grey white].freeze

  def self.value(colors)
    colors.first(2).map { |color| MAP.index(color) }.join.to_i
  end
end
