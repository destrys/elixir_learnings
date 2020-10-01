cast = [
  %{character: "buttercup",
    actor: %{
      first: "Robin",
      last: "Wright"
    },
    role: "princess"
   },
  %{character: "westley",
    actor: %{
      first: "Cary",
      last: "Elwes"
    },
    role: "farm boy"
  }
]


IO.inspect get_in(cast, [Access.all(), :character])

IO.inspect get_in(cast, [Access.at(1), :role])

IO.inspect get_and_update_in(cast, [Access.all(), :actor, :last],
  fn (val) -> {val, String.upcase(val)} end)
