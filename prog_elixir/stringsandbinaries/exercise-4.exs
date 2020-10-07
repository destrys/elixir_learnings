#(Hard) Write a function that takes a single-quoted string of the form number [+-*/] number and returns the result of the calculation.
# The individual numbers do not have leading plus or minus signs.

#calculate('123 + 27') # => 150

# I think I like mine more than the solutions.
defmodule StringExercise do

  def calculate(formula) do
    [value1, func, value2] = _parse_formula(formula)
    func.(value1, value2)
  end

  # parses a charlist formula into a [number, func, number] list
  defp _parse_formula(formula) do
    [value1, func_char, value2] =
      formula
      |> Enum.chunk_by(&(&1 == 32))
      |> Enum.filter(&(&1 != [32]))
    [_number_digits(value1, 0),
     _arithmetic_char_to_func(func_char),
     _number_digits(value2, 0)]
  end

  defp _arithmetic_char_to_func(char) do
    case char do
      '+' -> &+/2
      '-' -> &-/2
      '*' -> &*/2
      '/' -> &//2
    end
  end
  
  defp _number_digits([], value), do: value
  defp _number_digits([digit | tail], value)
  when digit in '0123456789' do
    _number_digits(tail, value*10 + digit - ?0)
  end
  defp _number_digits([ non_digit | _ ], _) do
    raise "Invalid digit '#{[non_digit]}'"
  end

  
end
