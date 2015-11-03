require "spec_helper"
require_relative "../sum_of_squares.rb"

RSpec.describe SumOfSquares do

  # first some basic validation on input.
  it ".solve() accepts a positive integer" do
    result = SumOfSquares.solve(7)
    expect(result).to be_an Array
  end
  it ".solve() does not accept nil" do
    expect{SumOfSquares.solve(nil)}.to raise_error(NilInputException)
  end
  it ".solve() does not accept a negative integer" do
    expect{SumOfSquares.solve(-1)}.to raise_error(InvalidInputException)
  end

  # test the largest square method with some known input
  it "gives the largest square of 81" do
    result = SumOfSquares.largest_square(81)
    expect(result).to eql(9)
  end
  it "gives the largest square of 144" do
    result = SumOfSquares.largest_square(144)
    expect(result).to eql(12)
  end

  # now we'll test some values to make sure we get known results
  # solving for one square
  it "solves for 100, which has just one square" do
    result = SumOfSquares.solve(100)
    expect(result).to eql([10])
  end
  # solving for two squares
  it "solves for 89 and gives optimal two squares" do
    result = SumOfSquares.solve(89)
    expect(result).to eql([8, 5])
  end
  # solving for three squares
  it "solves for 99 and gives known results" do
    result = SumOfSquares.solve(99)
    expect(result).to eql([7, 7, 1])
  end
  # solving for four squares
  it "solves for 7 and gives known results" do
    result = SumOfSquares.solve(7)
    expect(result).to eql([2, 1, 1, 1])
  end



end

