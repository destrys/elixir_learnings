# Write a function to capitalize the sentences in a string.
# Each sentence is terminated by a period and a space.
# Right now, the case of the characters in the string is random.

# capitalize_sentences("oh. a DOG. woof. ")
# "Oh. A dog. Woof. "

defmodule StringExercise do

  def capitalize_sentences(sentences) do
    sentences
    |> String.split(". ")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(". ")
  end

end
