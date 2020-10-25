defmodule Issues.FormatIssues do

  def format_issues(issues) do
    #fields = ~w{ number created_at title }
    field_widths =
      issues
      |> Enum.reduce([0,0,0], &find_max_field_widths/2)
    
    issues
    |> Enum.map(&format_issue(&1, field_widths))
  end

  def find_max_field_widths(%{"number" => number,
                          "created_at" => created_at,
                          "title" => title},[max_num, max_created_at, max_title]) do
    [max(max_num, String.length(Integer.to_string(number))),
     max(max_created_at, String.length(created_at)),
     max(max_title, String.length(title))]
  end
  

  def format_issue(%{"number" => number,
                     "created_at" => created_at,
                     "title" => title}, [num_length, created_at_length, title_length]) do
    num_string = String.pad_trailing(Integer.to_string(number), num_length)
    created_string = String.pad_trailing(created_at, created_at_length)
    title_string = String.pad_trailing(title, title_length)
    "#{num_string} | #{created_string} | #{title_string}"
  end


end
