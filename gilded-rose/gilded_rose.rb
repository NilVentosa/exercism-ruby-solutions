Item = Struct.new(:name, :sell_in, :quality)
class Item
  def conjured?
    name.start_with?('Conjured ')
  end
end

class GildedRose
  private

  AGED_BRIE = 'Aged Brie'.downcase.freeze
  BACKSTAGE_PASSES = 'Backstage passes to a TAFKAL80ETC concert'.downcase.freeze
  SULFURAS = 'Sulfuras, Hand of Ragnaros'.downcase.freeze
  MAX_QUALITY = 50

  def initialize(items)
    @items = items
  end

  def update_brie!(item)
    item.quality += 1 if item.sell_in <= 0 && item.quality < MAX_QUALITY
    item.quality += 1 if item.quality < MAX_QUALITY
  end

  def update_backstage_passes!(item)
    item.quality -= 1 if item.conjured?

    case item.sell_in
    when 11..Float::INFINITY then item.quality += 1
    when 6..10 then item.quality += 2
    when 1..5 then item.quality += 3
    else item.quality = 0
    end

    item.quality = [item.quality, MAX_QUALITY].min
  end

  def update_normal_item!(item)
    if item.conjured?
      item.quality -= 2 unless item.quality.zero?
      item.quality -= 2 if item.sell_in <= 0 && item.quality.positive?
      item.quality = 0 if item.quality.negative?
    else
      item.quality -= 1 unless item.quality.zero?
      item.quality -= 1 if item.sell_in <= 0 && item.quality.positive?
    end
  end

  def update_common!(item)
    item.quality = 0 if item.conjured? && !item.sell_in.positive?
    item.sell_in -= 1
  end

  public

  def update!
    @items.each do |item|
      clean_name = item.name.gsub(/Conjured /, '').downcase
      case clean_name
      when AGED_BRIE then update_brie!(item)
      when SULFURAS then next unless item.conjured?
      when BACKSTAGE_PASSES then update_backstage_passes!(item)
      else update_normal_item!(item)
      end
      update_common!(item)
    end
  end
end
