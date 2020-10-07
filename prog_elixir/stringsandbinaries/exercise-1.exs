# Write a function that returns true if a single-quoted string contains only printable ASCII characters (space through tilde).

defmodule StringExercise do

  def only_ascii?([]), do: true
  def only_ascii?([head | tail]) do
    if head < 32 or head > 126 do
      false
    else
      only_ascii?(tail)
    end
  end

end

