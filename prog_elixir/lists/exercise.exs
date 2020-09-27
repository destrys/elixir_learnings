defmodule Exercises do

  def mapsum(list, func, value \\ 0)

  def mapsum([], _func, value), do: value

  def mapsum([head | tail], func, value), do: mapsum(tail, func, value + func.(head))

  def maxx(list, value \\ 0)

  def maxx([], value), do: value

  def maxx([head|tail], value) when head >= value, do: maxx(tail, head)

  def maxx([head|tail], value) when head < value, do: maxx(tail, value)

  def caesar([], _n), do: []

  def caesar([head|tail], n) when head + n > 122, do: [rem(head + n, 123) + 97 | caesar(tail, n)]

  def caesar([head|tail], n), do: [head + n | caesar(tail, n)]                                          
  
end
