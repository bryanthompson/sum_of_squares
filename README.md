# SumOfSquares puzzle

Goal: Given an integer, return the shortest combination of squares that sums to this number.

Example: 
```
472 = 21^2, 5^2, 2^2, 1^2, 1^2
7   = 2^2, 1^2, 1^2, 1^2
89  = 8^2, 5^2
```

## Research and assumptions

There are some variations of this puzzle that include exercises in summing various sequences to get
squares, and there are some square factoring patterns that appeared to be geared toward making 'best fit'
results for statistics and such.

I'm taking this as a puzzle without knowing the use case, so I have to make some assumptions.

1. The best solution has exactly one square factor (as in, 100 = [10^2])
2. The second-best solution has exactly two square factors (as in, 89 = [8^2, 5^2])
3. A solution that has multiple sets of three squares (and has no solutions that are one or two squares), then each set of three is equal and we can take the first set.  This is true until more criteria is given for the usage of the result.
4. A solution that has multiple sets of four squares (and has no solutions that are one, two, or three squares), then each set of three is equal and we can take the first set.  This is true until more criteria is given for the usage of the result.
5. Lagrange's four-square theorem states that any real number can be stated as the sum of four squares, which means we can ignore any result set containing more than 4 squares.

I used the following sources to gain some understanding and was able to use modulo functions to poke and learn a bit.
- https://en.wikipedia.org/wiki/Proofs_of_Fermat%27s_theorem_on_sums_of_two_squares
- https://en.wikipedia.org/wiki/Legendre%27s_three-square_theorem
- https://en.wikipedia.org/wiki/Lagrange%27s_four-square_theorem

## Initial attempt

My initial attempt turned out to be incorrect because it didn't iterate through to find alternate sets.  I simply found the biggest square, subtracted it, and found the biggest square of the remainder.  This gave a nice set of squares in a pretty efficient way, but not a set that actually optimizes for the goal. :)

## Second approach

My second attempt has the potential to iterate through many more options and compare results more deeply should criteria change that defines the optimal result set.

1. Uses the square root of the original number as the starting point and rounds it down.  We'll never have a square that is greater than this point.
2. Iterating downward from this point, it then finds the largest remaining squares, using the pattern described in my initial attempt.
3. If it finds that the square root of the original number _is_ the square, then it returns it without doing any additional work.
4. If, while iterating through possibilities, it encounters a result set that has exactly two squares, it returns it without doing any additional work.
5. It ignores all sets that have more than four squares.
6. Assuming only three and four square results are found, it sorts the results by the number of results, then grabs the first set that has the fewest squares.

## My ideas as a non-mathematician

Math on its own isn't my strong suit, however, I see some patterns and suspect that there's a more obvious algorithm somewhere that I am just not aware of.  In real life, when encountered with an algorithm problem like this, I'd ask for advice and I've hired an actual mathematician for help in translating R code and for advice on efficiency, best route, etc.  Clarity.fm is one great place to find people for quick answers and help.  

I found several examples where the best set of squares included a large prime number. If, instead of iterating downward from the point where I did, you iterated through prime squares, would it be faster for results that do have prime factors in the optimized set?  I don't know, but I would like to try this at some point. Obviously all results did not include a large prime, so this might be an optimization that would waste more time in cases where it isn't part of the correct answer. 

## Usage

```bash
$ ruby bin/solve.rb 7
$ rspec
```
