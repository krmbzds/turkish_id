require "turkish_id/version"

class TurkishId

  def initialize(id_number)
    begin
      # Convert string into array of integers
      @id_number = id_number.split('').map { |s| Integer(s) }
    rescue
      @id_number = ''  # Suppress error & return false (eventually)
    end
  end

  def is_valid?
    id = @id_number  # +1 brevity point

    # Early elimination, bad length or first digit
    return false if id.length != 11 || id.first == 0

    # Calculate the sums of odd and even digits
    odds = id.values_at(0, 2, 4, 6, 8).reduce(:+)
    evens = id.values_at(1, 3, 5, 7).reduce(:+)

    # Check if the tenth digit matches the algorithm
    return false if id[9] != ((odds * 7) - evens) % 10

    # Check if the eleventh digit matches the algorithm
    return false if id[10] != id[0..9].reduce(:+) % 10

    return true  # All conditions met
  end

end
