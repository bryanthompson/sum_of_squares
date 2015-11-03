#!/usr/bin/env ruby

require_relative "../sum_of_squares.rb"

# This script will take a number and give back the fewest square numbers that have the sum of the given number
#
# USAGE:
# $ ruby sum_of_square.rb number
#
# Example:
# $ ./sum_of_squares.rb 472
# Solving for 472
# ["21^2", "5^2", "2^2", "1^2", "1^2"]

ENV["DEBUG"] = "TRUE"

puts SumOfSquares.solve(ARGV).inspect
