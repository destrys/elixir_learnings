defmodule Example do
  @author "Destry"
  def get_author do
    @author
  end
end


IO.puts "Example was written by #{Example.get_author}"
