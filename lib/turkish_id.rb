require "turkish_id/version"

class TurkishId
  attr_reader :id_number, :checksum

  def initialize(id_number)
    @id_number = digitize(id_number)
    @checksum = calculate_checksum(@id_number)
  end

  def is_valid?
    id = @id_number  # For brevity

    # Early termination, bad length or first digit
    return false if id.length != 11 || id.first == 0

    # Calculate checksum if not already calculated
    @checksum ||= calculate_checksum(id_number)

    # Check if the tenth digit matches the algorithm
    return false if id[9] != @checksum[0]

    # Check if the eleventh digit matches the algorithm
    return false if id[10] != @checksum[1]

    true  # All conditions met
  end

  private

  def calculate_checksum(id_number)
    # Calculate the sums of odd and even digits
    odds = id_number.values_at(0, 2, 4, 6, 8).reduce(:+)
    evens = id_number.values_at(1, 3, 5, 7).reduce(:+)

    # Generate checksum digits
    d10 = ((odds * 7) - evens) % 10
    d11 = (id_number.take(9).reduce(:+) + d10) % 10

    # Return checksum
    [d10, d11]
  rescue
    []  # Unable to calculate checksum, initial value remains unchainged
  end

  def digitize(id_number)
    # Narrow down scope of accepted types
    return [] unless [String, Integer, Fixnum].include?(id_number.class)

    # Convert string of numbers into an array of integers
    id_number.to_s.split('').map { |s| Integer(s) }
  end

end
