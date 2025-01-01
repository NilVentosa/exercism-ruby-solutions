class Luhn
  def self.valid?(input)
    clean_input = input.gsub(/\s/, '')
    return false unless clean_input.size > 1
    return false if clean_input =~ /[^\d]/

    reversed_chars = clean_input.chars.map! { |t| t.to_i }.reverse
    doubled = reversed_chars.map.with_index { |e, i| 
      t = (i % 2).zero? ? e : e * 2
      t >= 10 ? t - 9 : t
    }
    (doubled.sum % 10).zero? ? true : false
  end
end
