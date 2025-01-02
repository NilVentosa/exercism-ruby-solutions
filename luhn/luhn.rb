class Luhn

  MINIMUM_NUMBER_SIZE = 2

  def self.valid?(identification_number)
    clean_number = remove_spaces(identification_number)
    return false unless can_number_be_validated?(clean_number) 

    (run_luhn_algorithm(clean_number).sum % 10).zero?
  end

  def self.run_luhn_algorithm(clean_number)
    clean_number.chars.reverse.map!.with_index { |digit, i| 
      digit = digit.to_i
      digit = (i % 2).zero? ? digit : digit * 2
      digit >= 10 ? digit - 9 : digit
    }
  end

  def self.can_number_be_validated?(number)
    number =~ /^\d+$/ && number.size >= MINIMUM_NUMBER_SIZE
  end

  def self.remove_spaces(string)
    string.gsub(/\s/, '')
  end

  private_class_method :can_number_be_validated?, :run_luhn_algorithm, :remove_spaces

end
