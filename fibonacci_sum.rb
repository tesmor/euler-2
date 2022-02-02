# frozen_string_literal: true

# Finds the sum of fibonacci terms starting with [1, 2 ...] within a given range including even and/or odd terms.
# When no limit/parity is specified, it defaults to solving euler 2 (sum of even terms not exceeding 4 million).
class FibonacciSum
  def initialize(lower_limit = 0, upper_limit = 4_000_000, include_even: true, include_odd: false)
    unless lower_limit.is_a?(Integer) && upper_limit.is_a?(Integer)
      raise ArgumentError, 'please use numerical type arguments for limit values'
    end

    unless [true, false].include?(include_even) && [true, false].include?(include_odd)
      raise ArgumentError, 'please use boolean type arguments for parity settings'
    end

    @lower_limit = lower_limit
    @upper_limit = upper_limit
    @include_even = include_even
    @include_odd = include_odd
  end

  def sum
    return 0 unless sum_not_zero?

    sum = 0
    first_num = 1
    second_num = 2
    sum += first_num if valid_term?(first_num)
    sum += second_num if valid_term?(second_num)

    while second_num <= @upper_limit
      next_term = first_num + second_num # get next term
      sum += next_term if valid_term?(next_term)

      first_num = second_num
      second_num = next_term
    end

    sum
  end

  def sequence
    return [] unless sum_not_zero?

    sequence = []
    first_num = 1
    second_num = 2
    sequence << first_num if valid_term?(first_num)
    sequence << second_num if valid_term?(second_num)

    while second_num <= @upper_limit
      next_term = first_num + second_num
      sequence << next_term if valid_term?(next_term)

      first_num = second_num
      second_num = next_term
    end

    sequence
  end

  def describe_sum
    parity_description = if @include_even && @include_odd
                           'both even and odd'
                         elsif @include_even
                           'only even'
                         elsif @include_odd
                           'only odd'
                         else
                           'neither even nor odd'
                         end

    "The sum of fibonacci numbers, including #{parity_description} numbers, within #{@lower_limit} and #{@upper_limit}."
  end

  private

  def valid_term?(term)
    ((@include_even && term.even?) ||
      (@include_odd && term.odd?)) &&
      (term <= @upper_limit) &&
      (term >= @lower_limit)
  end

  def sum_not_zero?
    (@include_even || @include_odd) && @upper_limit.positive? && @lower_limit < @upper_limit
  end
end
