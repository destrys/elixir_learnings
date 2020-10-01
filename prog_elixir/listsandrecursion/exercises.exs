defmodule Exercises do

  def all?([], _), do: true
  
  def all?([head| tail], func) do
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


  def split(list, index, counter \\ 0, first \\ [])

  def split([head|tail], index, counter, first) when counter < index do
    split(tail, index, counter + 1, first ++ [head])
  end    
  
  def split([head|tail], index, counter, first) when counter == index do
    {first, [head|tail]}
  end


  def take(list, index, counter \\ 0)
  
  def take([head|tail], index, counter) when counter < index do
      [head|take(tail, index, counter+1)]
  end

  def take(_, index, counter) when counter == index, do: []

  def flatten([]), do: []

  def flatten([head|tail]) when is_list head do
    flatten(head) ++ flatten(tail)
  end

  def flatten([head|tail]) do
    [head|flatten(tail)]
  end
 
end

    
    
