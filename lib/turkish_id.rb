require "turkish_id/version"

class TurkishId
  attr_reader :id_number, :checksum, :elder_relative, :younger_relative

  def initialize(id_number)
    @id_number = get_id_array(id_number)
    @checksum = calculate_checksum(@id_number)
    @elder_relative = generate_relatives(@id_number, :up)
    @younger_relative = generate_relatives(@id_number, :down)
  end

  def is_valid?
    # Early termination, bad length or first digit
    return false if @id_number.length != 11 || @id_number.first == 0

    # Calculate checksum if not already calculated
    @checksum ||= calculate_checksum(@id_number)

    # Check if tenth or eleventh digits match the algorithm
    return false if @id_number[9] != @checksum[0] || @id_number[10] != @checksum[1]

    true  # All conditions met
  end

  private

  def calculate_checksum(id_array)
    # Calculate the sums of odd and even digits
    odds = id_array.values_at(0, 2, 4, 6, 8).reduce(:+)
    evens = id_array.values_at(1, 3, 5, 7).reduce(:+)

    # Generate checksum digits
    d10 = ((odds * 7) - evens) % 10
    d11 = (id_array.take(9).reduce(:+) + d10) % 10

    # Return checksum
    [d10, d11]
  rescue
    []
  end

  def append_checksum(id)
    id_core = split_num(id)
    join_num(id_core + calculate_checksum(id_core))
  end

  def next_relative(id_array, direction)
    tree = { up: 1, down: -1 }
    get_core(id_array) + 29999 * tree[direction]
  end

  def generate_relatives(id_array, direction)
    Enumerator.new do |y|
      id = join_num(id_array)
      loop do
        id = next_relative(id, direction)
        y << append_checksum(id)
      end
    end
  end

  def get_id_array(id)
    split_num(Integer(id)) rescue []
  end

  def split_num(num)
    n = Math.log10(num).floor
    (0..n).map{ |i| (num / 10 ** (n - i)) % 10 }
  end

  def join_num(id_array)
    id_array.inject{ |a, i| a * 10 + i }
  end

  def get_core(id_array)
    join_num(split_num(id_array).take(9))
  end
end
