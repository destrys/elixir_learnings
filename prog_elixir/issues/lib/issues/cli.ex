defmodule Issues.CLI do

  import Issues.TableFormatter, only: [print_table_for_columns: 2]

  @default_count 4

  @moduledoc """
  Handle the command line parsing and the dispatch to the various functions
  that end up generating a table of the last _n_ issues in a github project
  """

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a github user name, project name, and (optionally) the number
  of entries to format.

  Return a tuple of `{ user, project, count }`, or `:help` if help was given.
  """
  def parse_args(argv) do
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> args_to_internal_representation()
  end

  def args_to_internal_representation([user, project, count]) do
    { user, project, String.to_integer(count)}
  end

  def args_to_internal_representation([user, project]) do
    { user, project, @default_count}
  end
  
  def args_to_internal_representation(_), do: :help

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@default_count} ]
    """
    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response()
    |> sort_into_decending_order()
    |> last(count)
    |> print_table_for_columns(["number", "created_at", "title"])
  end

  def decode_response({:ok, body}), do: body
  def decode_response({:error, error}) do
    IO.puts "Error fetching from Github: #{error["message"]}"
    System.halt(2)
  end

  def sort_into_decending_order(list_of_issues) do
    list_of_issues
    |> Enum.sort(fn i1, i2 -> i1["created_at"] >= i2["created_at"] end)
  end

  def last(list, count) do
    list
    |> Enum.take(count)
    |> Enum.reverse
  end

  def display_table(issues) do
    issues
    |> add_header()
    |> Enum.map(&(IO.puts(&1)))
  end

  def add_header(issues=[head|_tail]) do
    column_widths = 
      head 
      |> get_column_widths()
    [num_width, created_width, column_width] = column_widths
    num_string = String.pad_trailing(" #", num_width)
    created_string = String.pad_trailing(" created_at", created_width)
    title_string = String.pad_trailing(" title", column_width)
    header_line = "#{num_string}|#{created_string}|#{title_string}"

    dashes = for x <- column_widths, do: String.duplicate("-", x)  
    div_line = Enum.join(dashes, "+")
    [header_line, div_line | issues]
  end

  def get_column_widths(issue) do
    issue
    |> String.split("|")
    |> (fn x -> for column <- x, do: String.length(column) end).()
  end
    
    

end
