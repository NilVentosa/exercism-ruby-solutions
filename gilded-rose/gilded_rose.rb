class GildedRose

  private

  def initialize(items)
    self.items = items
  end

  attr_accessor :items

  public

  def update!
    items.each(&:update)
  end
end

class Item

  MAX_QUALITY = 50
  MIN_QUALITY = 0
  CONJURED_PREFIX = /Conjured /

  def self.klass_mapping
    {
      'aged brie' => Brie,
      'backstage passes to a tafkal80etc concert' => BackstagePasses,
      'sulfuras, hand of ragnaros' => Sulfuras
    }.tap { |mapping| mapping.default = Normal }
  end

  def initialize(name:, sell_in:, quality:)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  private

  def unconjure(name)
    name.gsub(CONJURED_PREFIX, '')
  end

  protected

  def conjured?
    name.start_with?(CONJURED_PREFIX)
  end

  def expired?
    sell_in <= 0
  end

  def modify_quality(amount)
    set_quality(amount + quality)
  end

  def set_quality(amount)
    self.quality = (amount).clamp(MIN_QUALITY, MAX_QUALITY) 
  end

  public

  attr_accessor :name, :sell_in, :quality

  def update
    klass = self.class.klass_mapping[unconjure(name).downcase]
    item = klass.new(name:, sell_in:, quality:).tap(&:update)
    self.sell_in, self.quality = item.sell_in, item.quality
  end

end

class Normal < Item 

  def update
    if conjured?
      expired? ? set_quality(MIN_QUALITY) : modify_quality(-2)
    else
      expired? ? modify_quality(-2) : modify_quality(-1)
    end
    self.sell_in -= 1
  end

end

class Brie < Item

  def update
    expired? ? modify_quality(2) : modify_quality(1)
    set_quality(MIN_QUALITY) if conjured? && expired?
    self.sell_in -= 1
  end

end

class Sulfuras < Item

  def update
    return unless conjured?

    set_quality(MIN_QUALITY) if expired?
    self.sell_in -= 1
  end

end

class BackstagePasses < Item

  def update
    modify_by = case sell_in
                when 11... then 1
                when 6..10 then 2
                when 1..5 then 3
                when ...1 then -quality
                end
    conjured? ? modify_quality(modify_by - 1) : modify_quality(modify_by)
    set_quality(MIN_QUALITY) if conjured? && expired?
    self.sell_in -= 1
  end

end
