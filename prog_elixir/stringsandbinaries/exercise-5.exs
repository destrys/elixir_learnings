# Write a function that takes a list of double-quoted strings and prints each on a separate line,
# centered in a column that has the width of the longest string. Make sure it works with UTF characters.

defmodule StringExercise do

  def print_column(words) do
    width =
      words
      |> Enum.map(&String.length(&1))
      |> Enum.max

    for word <- words, do: IO.puts center_word(word, width)
  end

  def center_word(word, width) do
    # find front pad amount
    length = String.length word
    new_length =
      width - length
      |> div(2)
      |> Kernel.+(length)
    # front pad
    String.pad_leading(word, new_length)
  end

end
