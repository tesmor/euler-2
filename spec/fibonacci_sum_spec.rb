# frozen_string_literal: true

require_relative './../fibonacci_sum'
require 'spec_helper'

RSpec.describe FibonacciSum do
  context 'when summing a variety of ranges' do
    it 'correctly sums fibonacci numbers between 100 and 1000' do
      fib_sum = FibonacciSum.new(100, 1000, include_even: true, include_odd: true)
      expect(fib_sum.sum).to eq(2_351)
    end

    it 'correctly sums fibonacci numbers between 0 and 10000000000' do
      fib_sum = FibonacciSum.new(0, 10_000_000_000, include_even: true, include_odd: true)
      expect(fib_sum.sum).to eq(20_365_011_072)
    end

    it 'sums fibonacci numbers between (and including) 34 and 5702887' do
      fib_sum = FibonacciSum.new(34, 5_702_887, include_even: true, include_odd: true)

      expect(fib_sum.sum).to eq(14_930_297)
    end
  end

  context 'when solving euler-2' do
    it 'defaults to summing even numbers up to 4 million' do
      fib_sum = FibonacciSum.new
      sum = fib_sum.sum
      expect(sum).to eq(4_613_732)
    end

    it 'correctly sums even numbers up to 4 million' do
      fib_sum = FibonacciSum.new(0, 4_000_000, include_even: true, include_odd: false)
      sum = fib_sum.sum
      expect(sum).to eq(4_613_732)
    end
  end

  context 'with bad user inputs' do
    it 'handles no range limit inputs' do
      fib_sum = FibonacciSum.new(900, 5, include_even: true, include_odd: true)
      sum = fib_sum.sum
      expect(sum).to eq(0)
    end

    it 'handles no parity inclusion' do
      fib_sum = FibonacciSum.new(0, 200, include_even: false, include_odd: false)
      sum = fib_sum.sum
      expect(sum).to eq(0)
    end

    it 'handles bad type inputs' do
      expect { FibonacciSum.new('yes', 0, include_even: 'ok', include_odd: true) }.to raise_error(ArgumentError)
      expect { FibonacciSum.new(2, 0, include_even: 'ok', include_odd: true) }.to raise_error(ArgumentError)
    end
  end
end
