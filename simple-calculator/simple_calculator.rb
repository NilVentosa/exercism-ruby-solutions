class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  def self.calculate(first_operand, second_operand, operation)
    raise UnsupportedOperation.new('') unless ALLOWED_OPERATIONS.include?(operation)
    raise ArgumentError.new('') unless first_operand.instance_of?(Integer) && second_operand.instance_of?(Integer)

    begin
      result = case operation
               when '+' then first_operand + second_operand
               when '*' then first_operand * second_operand
               when '/' then first_operand / second_operand
               end
      "#{first_operand} #{operation} #{second_operand} = #{result}"
    rescue ZeroDivisionError => _e
      'Division by zero is not allowed.'
    end
  end

  class UnsupportedOperation < StandardError
  end
end
