defmodule Exercises do

  def all?([], _), do: true
  
  def all?([head| tail], func) do
    # this will run to the end of the list
    # but we could short circuit if it's ever false
    func.(head) && all?(tail, func)
  end

  def each([], _), do: []
  
  def each([head|tail], func) do
    [func.(head) | each(tail, func)]
  end


  def filter([], _), do: []
  
  def filter([head|tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end


  # Instead of index and counter, we could decrement index
  # and when it hit zero, return
  def split(list, index, counter \\ 0, first \\ [])

  # instead of ++, we could add head via [head|first] then reverse
  # when it's time to return
  def split([head|tail], index, counter, first) when counter < index do
    split(tail, index, counter + 1, first ++ [head])
  end    
  
  def split([head|tail], index, counter, first) when counter == index do
    {first, [head|tail]}
  end


  # derp, could just use split and take the first element...
  # also the same thing about decrementing index instead of keeping
  # a counter

  # also better to use defp _take/3 and def take/2 instead of
  # havinf default values of parameters that users won't use
  def take(list, index, counter \\ 0)
  
  def take([head|tail], index, counter) when counter < index do
      [head|take(tail, index, counter+1)]
  end

  def take(_, index, counter) when counter == index, do: []

  
  def flatten([]), do: []

  # a different way to do this is defin flatten(head) for the non-list
  # instances
  def flatten([head|tail]) when is_list head do
    flatten(head) ++ flatten(tail)
  end

  def flatten([head|tail]) do
    [head|flatten(tail)]
  end

  # a different approach can use flatten([[h|t]|tail], result)
  # you can do [h,t|tail]

  # Valim's solution:
  def JVflatten(list), do: do_flatten(list, [])

  def do_flatten([h|t], tail) when is_list(h) do
    do_flatten(h, do_flatten(t, tail))
  end

  def do_flatten([h|t], tail) do
    [h|do_flatten(t, tail)]
  end

  def do_flatten([], tail) do
    tail
  end
  # this is actually pretty close to mine, but without concatting
  

  
end

    
    
