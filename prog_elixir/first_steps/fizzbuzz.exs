fizzbuzzer = fn
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Fizz"
  (_, 0, _) -> "Buzz"
  (_, _, a) -> a
end

#IO.puts fizzbuzzer.(1, 2, 3)
#IO.puts fizzbuzzer.(0, 0, "azzz")
#IO.puts fizzbuzzer.(0, 1, 45)
#IO.puts fizzbuzzer.("asd", 0, "dsa")

remmer = fn n -> fizzbuzzer.(rem(n, 3), rem(n, 5), n) end

IO.puts remmer.(10)
IO.puts remmer.(11)
IO.puts remmer.(12)
IO.puts remmer.(13)
IO.puts remmer.(14)
IO.puts remmer.(15)
IO.puts remmer.(16)

