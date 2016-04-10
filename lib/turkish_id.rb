require "turkish_id/version"

class String
  def digitize
    self.split('').map { |s| Integer(s) }
  end
end

class TurkishId

  def initialize(id_number)
    begin
      @id_number = id_number.digitize  # Convert string into array of integers
    rescue
      @id_number = ''  # Suppress error & return false (eventually)
    end
  end


  def core
    @id_number.take(9)
  end


  def self.get_checksum(id_core)

    # Calculate the sums of odd and even digits
    odds = id_core.values_at(0, 2, 4, 6, 8).reduce(:+)
    evens = id_core.values_at(1, 3, 5, 7).reduce(:+)

    # Generate checksum digits
    d10 = ((odds * 7) - evens) % 10
    d11 = (id_core.reduce(:+) + d10) % 10

    [d10, d11]
  end

  def self.add_checksum(id_core)
    id_core + TurkishId.get_checksum(id_core)
  end

  def is_valid?
    id = @id_number  # +1 brevity point

    # Early elimination, bad length or first digit
    return false if id.length != 11 || id.first == 0

    # Get checksum digits
    d10, d11 = TurkishId.get_checksum(id)

    # Check if the tenth digit matches the algorithm
    return false if id[9] != d10

    # Check if the eleventh digit matches the algorithm
    return false if id[10] != d11

    true  # All conditions met
  end

  def get_relatives(num, direction='up')

    id = self.core.join.to_i  # Our core id as integer

    tree = {'up' => 1, 'down' => -1}      # + or - based on direction
    magic = 131 * 229 * tree[direction]   # Eliminates if statement

    relatives = []

    num.times do
      id += magic      # Gives us the next relative
      relatives << id  # Collecting ids in an array
    end

    # Traverse relatives and append checksum digits
    relatives.map { |r| TurkishId.add_checksum(r.to_s.digitize).join }
  end

end
