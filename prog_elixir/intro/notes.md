```
a = 1
^a = 2
```
will throw a MatchError

`^` is the *pin operator*

"the main difference being that Elixir allows a match to reassign to a variable
 that was assigned in a prior match, whereas in Erlang a variable can be assigned only once"


----

No fixed size limit for integers?

Floats are IEEE 754, so ~16 digits of accuracy

regex = pcre.org

references? `make_ref`


---

Tuple = {1, 2}
"A typical Elixir tuple has two to four elements—any more and you’ll probably want to look at maps ... or structs"
"It is common for functions to return a tuple where the first element is the atom :ok if there were no errors."

List = [1, 2, 3]
"A list may either be empty or consist of a head and a tail. The head contains a value and the tail is itself a list."
"this recursive definition of a list is the core of much Elixir programming."
"It is always cheap to get the head of a list and to extract the tail of a list."
concat -- [1] ++ [2]
diff -- [1,2,3,4] -- [2,4]
[1,3]
membership -- 1 in [1,2]
true

Keyword list:
[ name: "Dave", city: "Dallas", likes: "Programming" ]
becomes
[ {:name, "Dave"}, {:city, "Dallas"}, {:likes, "Programming"} ]

this is a little confusing:
{1, fred: 1, dave: 2}
becomes
{1, [fred: 1, dave: 2]}
the keyword pairs at the end of a tuple become a keyword list as the last element in the tuple?


Maps:
`%{ key => value, key => value }`

"Although typically all the keys in a map are the same type, that isn’t required."
"If the key is an atom, you can use the same shortcut that you use with key- word lists:"
`colors = %{red: "red", blue: "blue"}`
"Maps allow only one entry for a particular key, whereas keyword lists allow the key to be repeated."
"In general, use keyword lists for things such as command-line parameters and passing around options,
 and use maps when you want an associative array."


"Module, record, protocol, and behavior names start with an uppercase letter and are BumpyCase. All other identifiers start with a lowercase letter or an underscore, and by convention use underscores between words"

<- operator when using `with`


-----
Functions

anon functions need to be called with a dot:
`sum = fn (a, b) -> a + b end`
`sum.(1, 2)`
named functions don't need the dot

Q: How do you return?


----
s = &"bacon and #{&1}"


---
Guard clauses:
"These are predicates that are attached to a function defi- nition using one or more when keywords. When doing pattern matching, Elixir first does the conventional parameter-based match and then evaluates any when predicates, executing the function only if at least one predicate is true."
"You can write only a subset of Elixir expressions in guard clauses" -
comparison
boolean and negation
arithmetic
join
in
type_checks
a handfull of other functions

----
Default Params
`param \\ value`

---
Private functions:
`defp`
"you cannot have some heads private and others public"

---
PIPES
"The |> operator takes the result of the expression to its left and inserts it as the first parameter of the function invocation to its right."
"Let me repeat that—you should always use parentheses around function parameters in pipelines."

---
import directive
`import Module [, only:|except: ]`
e.g.
`import List, only: [flatten: 1]`
"You write only: or except:, followed by a list of name: arity pairs."
"It is a good idea to use import in the smallest possible enclosing scope and to use only: to import just the functions you need." - unlike python

---
alias directive
`alias My.Other.Module.Parser, as: Parser`
`alias My.Other.Module.{Parser, Runner}` (it defaults to the last part of the module name)

---
require directive


---
libraries:
standard: https://elixir-lang.org/docs.html

---
maps:
"Maps are the go-to key/value data structure in Elixir. They have good perfor- mance at all sizes."
"You can’t bind a value to a key during pattern matching."


---
structs

defstruct
%Attendee{}

accessing nested structs:
put_in
update_in
get_in
get_and_update_in

----
Enums

`to_list`
`concat`
`map`
`at`
`filter`
`reject` opposite of filter?
`sort`
`max`
`max_by`
`take`
`take_every`
`take_while`
`split`
`split_while`
`join`
`all?`
`any?`
`member?`
`empty?`
`zip`
`with_index`
`reduce`


----
streams

"The good news is that there is no intermediate storage. The bad news is that it runs about two times slower than the previous version"

"Instead, you probably want to use some helpful wrapper functions to do the heavy lifting. There are a number of these, including cycle, repeatedly, iterate, unfold, and resource."


`cycle`:

iex> Stream.cycle(~w{ green white }) |>
...> Stream.zip(1..5) |>
...> Enum.map(fn {class, value} ->
...> "<tr class='#{class}'><td>#{value}</td></tr>\n" end) |>
...> IO.puts

`repeatedly`:
Stream.repeatedly(&:random.uniform/0) |> Enum.take(3)

`iterate`:
Stream.iterate(2, &(&1*&1)) |> Enum.take(5)

`unfold`:
fibonacci:
Stream.unfold({0,1}, fn {f1,f2} -> {f1, {f2, f1+f2}} end) |> Enum.take(15)

"You supply an initial value and a function. The function uses the argument to create two values, returned as a tuple. The first is the value to be returned by this iteration of the stream, and the second is the value to be passed to the function on the next iteration of the stream. If the function returns nil, the stream terminates."


aside: where did sigils get skipped?
~w{green white} = ["green", "white"] - cool

`resource`
example:
```
Stream.resource(
  fn -> File.open!("sample") end,
  fn file ->
    case IO.read(file, :line) do
      data when is_binary(data) -> {[data], file}
      _ -> {:halt, file}
    end
  end,
  fn file -> File.close(file) end)
```
"The first function opens the file when the stream becomes active, and passes it to the second function. This reads the file, line by line, returning either a line and the file as a tuple, or a :halt tuple at the end of the file. The third function closes the file."


----
collectables

"warning: the Collectable protocol is deprecated for non-empty lists. The behaviour of things like Enum.into/2 or "for" comprehensions with an :into option is incorrect when collecting into non-empty lists. If you're collecting into a non-empty keyword list, consider using Keyword.merge/2 instead. If you're collecting into a non-empty list, consider concatenating the two lists with the ++ operator."

Output streams are collectable, so the following code lazily copies standard input to standard output:
`Enum.into IO.stream(:stdio, :line), IO.stream(:stdio, :line)`



----
comprehensions!

!!
If we have two generators, their operations are nested,


---
binaries

"The first rule of binaries is “if in doubt, specify the type of each field.” Available types are binary, bits, bitstring, bytes, float, integer, utf8, utf16, and utf32."
Use hyphens to separate multiple attributes for a field:
<< length::unsigned-integer-size(12), flags::bitstring-size(4) >> = data