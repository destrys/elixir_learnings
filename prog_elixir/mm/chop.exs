defmodule Chop do

  def guess(actual, a..b) do
    g = div(b-a, 2) + a
    IO.puts "Is it #{g}"
    guess(actual, a..b, g)
  end

  def guess(actual, _..b, g) when g < actual do
    guess(actual, g..b)
  end

  def guess(actual, a.._, g) when g > actual do
    guess(actual, a..g)
  end

  def guess(actual, _.._, g) when g == actual do
    IO.puts "#{g}"
  end
  
end
