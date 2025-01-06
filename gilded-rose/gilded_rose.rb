class GildedRose

  def initialize(items)
    self.items = items
  end

  attr_accessor :items

  def update!
    items.each(&:update)
  end
end

class Item

  MAX_QUALITY = 50
  AGED_BRIE = 'Aged Brie'.downcase
  BACKSTAGE_PASSES = 'Backstage passes to a TAFKAL80ETC concert'.downcase
  SULFURAS = 'Sulfuras, Hand of Ragnaros'.downcase

  def initialize(name:, sell_in:, quality:)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def update
    if name.downcase.include? AGED_BRIE
      thing = Brie.new(name:, sell_in:, quality:)
      thing.update
      self.sell_in = thing.sell_in
      self.quality = thing.quality
    elsif name.downcase.include? SULFURAS
      thing = Sulfuras.new(name:, sell_in:, quality:)
      thing.update
      self.sell_in = thing.sell_in
      self.quality = thing.quality
    elsif name.downcase.include? BACKSTAGE_PASSES
      thing = BackstagePasses.new(name:, sell_in:, quality:)
      thing.update
      self.sell_in = thing.sell_in
      self.quality = thing.quality
    else
      thing = Normal.new(name:, sell_in:, quality:)
      thing.update
      self.sell_in = thing.sell_in
      self.quality = thing.quality
    end
  end

  attr_accessor :name, :sell_in, :quality

  def conjured?
    name.start_with?('Conjured ')
  end

  def expired?
    sell_in <= 0
  end

end

class Normal < Item 

  def update
    if conjured?
      self.quality -= 2 unless quality.zero?
      self.quality -= 2 if expired? && quality.positive?
      self.quality = 0 if quality.negative?
    else
      self.quality -= 1 unless quality.zero?
      self.quality -= 1 if expired? && quality.positive?
    end
    self.quality = 0 if conjured? && expired?
    self.sell_in -= 1
  end

end

class Brie < Item

  def update
    self.quality += 1 if expired? && quality < MAX_QUALITY
    self.quality += 1 if quality < MAX_QUALITY
    self.quality = 0 if conjured? && expired?
    self.sell_in -= 1
  end

end

class Sulfuras < Item

  def update
    return unless conjured?

    self.quality = 0 if conjured? && expired?
    self.sell_in -= 1
  end

end

class BackstagePasses < Item

  def update
    self.quality -= 1 if conjured?

    case sell_in
    when 11... then self.quality += 1
    when 6..10 then self.quality += 2
    when 1..5 then self.quality += 3
    when ...1 then self.quality = 0
    end

    self.quality = [quality, MAX_QUALITY].min
    self.quality = 0 if conjured? && expired?
    self.sell_in -= 1
  end

end
