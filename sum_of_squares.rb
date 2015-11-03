#!/usr/bin/env ruby

# This script will take a number and give back the fewest square numbers that have the sum of the given number
#
# USAGE:
# $ ruby sum_of_square.rb number
#
# Example:
# $ ./sum_of_squares.rb 472
# Solving for 472
# ["21^2", "5^2", "2^2", "1^2", "1^2"]

class SumOfSquares

  def self.validate_input argv_arr
    # argv_arr shouldn't really ever be nil, but if this class were extracted or used
    # within another script somewhere, it would be possible to pass a nill here, so
    # we might as well catch it.
    if argv_arr.nil?
      puts "Usage: $ ruby sum_of_squares.rb number-to-solve"
      exit 1

    # if this were used in another script somewhere, it would also be possible to
    # pass in a single number rather than a normal ARGV array.  So, we can cast our
    # argv_arr to an array and get the first element for validation.
    elsif ([argv_arr].flatten)[0].to_i <= 0
      puts "Please enter a number greater than zero for the first and only param."
      puts "Example: $ ruby sum_of_squares.rb 254"
      exit 1
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

    puts "Solving for #{number}"

    possible_solutions = []
    best_solution = nil
    remainder = number

    # starting at the halfway point and working our way down because we're going to end up with several
    # possible solutions.
    halfway  = Math.sqrt(number).floor

    while halfway > 0 do
      squares = []
      puts "*" * 50
      puts halfway

      square = halfway
      squares.push square
      remainder = number - square*square

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

      puts squares.inspect

      # there's no reason to continue if we get a result with 1 or 2 squares, since it is clearly the optimal solution
      if squares.length == 1 || squares.length == 2
        puts "BEST SOLUTION"
        best_solution = squares
        break
      end

      halfway -= 1
    end

    puts possible_solutions.inspect

    # if this were feeding the data to another function rather than just echoing to the screen,
    # we could just return squares and hand them off.  Instead, we'll exit gracefully.

    exit 0
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

# First, we'll dump our input into a simple validation method.  We only need one param, and it needs to
# be a number > 0.

SumOfSquares.solve(ARGV)
