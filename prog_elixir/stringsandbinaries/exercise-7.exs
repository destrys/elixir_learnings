# Chapter 7 had an exercise about calculating sales tax on page 114.
# We now have the sales information in a file of comma-separated id, ship_to, and amount values.
# Write a function that reads and parses this file and then passes the result to the sales_tax function.
# Remember that the data should be formatted into a keyword list,
# and that the fields need to be the correct types (so the id field is an integer, and so on).


defmodule ReadOrders do

  def from_file(filename) do
    File.stream!(filename)
    |> Stream.map(&String.trim/1)    
    |> Stream.map(&String.split(&1, ","))
    |> Stream.filter(fn [id,_,_] -> id != "id" end)
    |> Enum.map(&parse_line(&1))
  end

  def parse_line([id, state, net_amount]) do
    [id: String.to_integer(id),
     ship_to: String.to_atom(String.trim(state, ":")),
     net_amount: String.to_float(net_amount)]
  end
  
end

defmodule Taxes do

  def orders_with_total(orders, tax_rates) do
    orders |> Enum.map(&append_total_amount(&1, tax_rates))
  end
  
  def append_total_amount(order = [id: _, ship_to: state, net_amount: net_amount], tax_rates) do
    tax_rate = Keyword.get(tax_rates, state, 0)
    total = net_amount + (net_amount * tax_rate)
    order ++ [total_amount: total]
  end

end

tax_rates = [ NC: 0.075, TX: 0.08 ]
IO.inspect ReadOrders.from_file("orders.csv") |> Taxes.orders_with_total(tax_rates)
