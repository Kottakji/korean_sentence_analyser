defmodule Mix.Tasks.ImportRhinoDict do
  use Mix.Task
  import Ksa.Ets.DictFile, only: [init: 0, find: 2]

  @path "external/rhino_dict.txt"

  @shortdoc "Imports the external dictionary"
  def run(_) do
    IO.inspect("Starting")

    init()

    Path.join(:code.priv_dir(:ksa), @path)
    |> File.stream!()
    |> Stream.map(fn x ->
      case Regex.named_captures(~r/^(?<korean>[가-힣]+?)	(?<type>.+?)$/, x) do
        %{"korean" => korean, "type" => types} when byte_size(korean) > 3 ->
          cond do
            # Not too reliable?
            #                  String.contains?(types, ["VV"]) ->
            #                    case find(korean, "verb/verb.txt") do
            #                      nil ->
            #                        {:ok, file} = File.open(Path.join(:code.priv_dir(:ksa), "verb/verb.txt"), [:append])
            #                        IO.binwrite(file, "#{korean}\n")
            #                        File.close(file)
            #                      _ ->
            #                        nil
            #                    end

            String.contains?(types, ["VA"]) ->
              case find(korean, "adjective/adjective.txt") do
                nil ->
                  {:ok, file} = File.open(Path.join(:code.priv_dir(:ksa), "adjective/adjective.txt"), [:append])
                  IO.binwrite(file, "#{korean}\n")
                  File.close(file)

                _ ->
                  nil
              end

            true ->
              # Ignore others, just add the type(s) above
              nil
          end

        _ ->
          nil
      end
    end)
    |> Stream.run()

    IO.inspect("Success")
  end
end
