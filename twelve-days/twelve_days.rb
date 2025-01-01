class TwelveDays
  DAYS = %w[first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth].freeze
  WHAT = 'twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, a Partridge in a Pear Tree'.split(', ').reverse.freeze

  def self.song
    result = ''
    gave = '.'
    for i in 0..11 do
      gave.prepend('and ') if i == 1
      gave.prepend(', ') if i.positive?
      gave.prepend(WHAT[i])
      result += "On the #{DAYS[i]} day of Christmas my true love gave to me: #{gave}\n"
      result += "\n" if i < 11
    end
    result
  end
end
