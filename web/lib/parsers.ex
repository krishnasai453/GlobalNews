defmodule NewsApp.Parsers do
  alias NewsApp.{News, Repo, Source}

def now() do
   DateTime.utc_now |> DateTime.to_string
 end

end