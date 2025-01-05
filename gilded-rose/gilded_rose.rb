class Item

  MAX_QUALITY = 50

  def initialize(name:, sell_in:, quality:)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  attr_accessor :name, :sell_in, :quality

  def conjured?
    name.start_with?('Conjured ')
  end

  def update_brie
    self.quality += 1 if sell_in <= 0 && quality < MAX_QUALITY
    self.quality += 1 if quality < MAX_QUALITY
    update_common
  end

  def update_backstage_passes
    self.quality -= 1 if conjured?

    case sell_in
    when 11... then self.quality += 1
    when 6..10 then self.quality += 2
    when 1..5 then self.quality += 3
    when ...1 then self.quality = 0
    end

    self.quality = [quality, MAX_QUALITY].min
    update_common
  end

  def update_normal_item
    if conjured?
      self.quality -= 2 unless quality.zero?
      self.quality -= 2 if sell_in <= 0 && quality.positive?
      self.quality = 0 if quality.negative?
    else
      self.quality -= 1 unless quality.zero?
      self.quality -= 1 if sell_in <= 0 && quality.positive?
    end
    update_common
  end

  def update_sulfuras
    update_common if conjured?
  end

  def update_common
    self.quality = 0 if conjured? && sell_in <= 0
    self.sell_in -= 1
  end

end

class GildedRose

  AGED_BRIE = 'Aged Brie'.downcase
  BACKSTAGE_PASSES = 'Backstage passes to a TAFKAL80ETC concert'.downcase
  SULFURAS = 'Sulfuras, Hand of Ragnaros'.downcase

  def initialize(items)
    @items = items
  end

  attr_reader :items

  def update!
    items.each do |item|
      clean_name = item.name.gsub(/Conjured /, '').downcase
      case clean_name
      when AGED_BRIE then item.update_brie
      when SULFURAS then item.update_sulfuras
      when BACKSTAGE_PASSES then item.update_backstage_passes
      else item.update_normal_item
      end
    end
  end
end
