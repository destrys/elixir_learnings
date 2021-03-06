defmodule Exercise7 do


  def span(from, to) when from > to, do: []

  def span(from, to) do
    [from | span(from+1, to)]
  end

  def primes(n) do
    range = span(2, n)
    range -- (for a <- range, b <- range, a <= b, a*b <= n, do: a*b)
  end
  

end
