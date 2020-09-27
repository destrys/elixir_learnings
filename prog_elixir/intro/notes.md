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