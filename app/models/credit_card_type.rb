#phelps code
class CreditCardType
  attr_reader :name, :pattern
  # examples of name would be "VISA", "DISC", and the like
  # pattern would be a regex that numbers for this card type must adhere to

  def initialize(name, pattern)
    @name, @pattern = name, pattern
  end

  # a simple method to see if a particular number matches the card type pattern
  def match(number)
    number.to_s.match(pattern)
  end
end
