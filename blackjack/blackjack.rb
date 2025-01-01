module Blackjack
  CARDS_VALUES = {
    'ace' => 11,
    'one' => 1,
    'two' => 2,
    'three' => 3,
    'four' => 4,
    'five' => 5,
    'six' => 6,
    'seven' => 7,
    'eight' => 8,
    'nine' => 9,
    'ten' => 10,
    'jack' => 10,
    'queen' => 10,
    'king' => 10
  }.freeze

  def self.parse_card(card)
    CARDS_VALUES[card] || 0
  end

  def self.card_range(card1, card2)
    value = parse_card(card1) + parse_card(card2)
    case value
    when 4..11 then 'low'
    when 12..16 then 'mid'
    when 17..20 then 'high'
    when 21 then 'blackjack'
    end
  end

  def self.first_turn(card1, card2, dealer_card)
    if card1 == card2 && card2 == 'ace' then return 'P' end
    if card_range(card1, card2) == 'blackjack'
      if parse_card(dealer_card) < 10
        return 'W'
      else
        return 'S'
      end
    end
    if card_range(card1, card2) == 'high' then return 'S' end
    if card_range(card1, card2) == 'mid' && parse_card(dealer_card) > 6 then return 'H' end
    if card_range(card1, card2) == 'mid' then return 'S' end
    if card_range(card1, card2) == 'low' then return 'H' end
  end
end
