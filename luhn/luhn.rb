class Luhn

  MINIMUM_CLEAN_ID_LENGTH = 2

  def self.run_luhn_algorithm(clean_id)
    clean_id.chars.reverse.map!.with_index do |digit, i|
      digit = digit.to_i
      digit = (i % 2).zero? ? digit : digit * 2
      digit >= 10 ? digit - 9 : digit
    end
  end

  def self.reasonable?(clean_id)
    clean_id =~ /^\d+$/ && clean_id.size >= MINIMUM_CLEAN_ID_LENGTH
  end

  def self.remove_spaces(string)
    string.gsub(/\s/, '')
  end

  private_class_method :reasonable?, :run_luhn_algorithm, :remove_spaces
  private_constant :MINIMUM_CLEAN_ID_LENGTH

  def self.valid?(id)
    clean_id = remove_spaces(id)
    return false unless reasonable?(clean_id)

    (run_luhn_algorithm(clean_id).sum % 10).zero?
  end

end
