class NilInputException     < Exception; end
class InvalidInputException < Exception; end

class SumOfSquares

  def self.validate_input argv_arr
    # argv_arr shouldn't really ever be nil, but if this class were extracted or used
    # within another script somewhere, it would be possible to pass a nill here, so
    # we might as well catch it.
    if argv_arr.nil?
      puts "Usage: $ ruby sum_of_squares.rb number-to-solve" if ENV["DEBUG"]
      raise NilInputException.new

    # if this were used in another script somewhere, it would also be possible to
    # pass in a single number rather than a normal ARGV array.  So, we can cast our
    # argv_arr to an array and get the first element for validation.
    elsif ([argv_arr].flatten)[0].to_i <= 0
      if ENV["DEBUG"]
        puts "Please enter a number greater than zero for the first and only param."
        puts "Example: $ ruby sum_of_squares.rb 254"
      end
      raise InvalidInputException.new
    end
  end

  def self.solve argv_arr
    # since this is a bash script, we'll simply run a validation and it will exit out and print
    # feedback if it can't validate properly. Normally, we'd check a .valid? method on our
    # object and deal with it, but since this script will simply abort, we can just call it and
    # move on if it validates successfully.
    validate_input(argv_arr)

    # using the same validation and reasoning as our validation, we'll set our number to the
    # first element in the argv_arr as an integer.
    number = ([argv_arr].flatten)[0].to_i

    puts "Solving for #{number}" if ENV["DEBUG"]

    possible_solutions = []
    best_solution = nil
    have_result_with_3 = false
    remainder = number

    # setting our halfway point to the square root of our number since it would be the biggest possible square
    # that fits into the number.
    halfway  = Math.sqrt(number).floor

    while halfway > 0 do
      squares = []

      square = halfway
      squares.push square
      remainder = number - square*square

      halfway -= 1

      while remainder > 0
        # First, get the biggest square for our number
        square = largest_square(remainder)

        # before we go any further, if this square exists in any possible solution we already
        # found, we should bail out, because we don't need to repeat our work.

        # add it to our array of results
        squares.push(square)
        # now subtract it from our current number so we can find the biggest remaining square
        remainder = remainder - square*square
      end

      # per Lagrange's four-square theorem, we can ignore any results with more than 4 squares,
      # because we know for sure that there will be results with 4 or fewer
      if squares.length > 4
        next
      end

      possible_solutions.push squares

      # there's no reason to continue if we get a result with 1 or 2 squares, since it is clearly the optimal solution
      if squares.length == 1 || squares.length == 2
        best_solution = squares
        break
      end

    end

    # if we got this far, the shortest result will have either 3 or 4 squares, and we'll need more
    # information before deciding which possibility is actually the one we want.

    unless best_solution
      best_solution = select_best_solution(possible_solutions)
    end

    return best_solution
  end

  # this could be made more sophsticated with more criteria as to what makes one set of squares
  # more correct than another.  We could just as easily sort this list to find the shortest
  # set with the biggest square, or find the shortest set with the squares that are closest to each other
  def self.select_best_solution possible_solutions
    return possible_solutions.uniq.sort{ |a, b| a.count <=> b.count }[0]
  end

  # Using Newton's Method to find the largest square for our number.
  def self.largest_square n
    x = n
    while true do
      y = (x + n/x) / 2
      return x if ( y >= x )
      x = y
    end

  end
end

