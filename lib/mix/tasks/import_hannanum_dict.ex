defmodule Mix.Tasks.ImportHannanumDict do
  use Mix.Task
  import Ksa.Ets.DictFile, only: [init: 0, find: 2]

  @path "external/hannanum_dict.txt"

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
            String.contains?(types, ["ncpa", "ncps", "ncn"]) ->
              case find(korean, "noun/nouns.txt") do
                nil ->
                  {:ok, file} = File.open(Path.join(:code.priv_dir(:ksa), "noun/nouns.txt"), [:append])
                  IO.binwrite(file, "#{korean}\n")
                  File.close(file)

                _ ->
                  nil
              end

            String.contains?(types, ["mag"]) ->
              case find(korean, "adverb/adverb.txt") do
                nil ->
                  {:ok, file} = File.open(Path.join(:code.priv_dir(:ksa), "adverb/adverb.txt"), [:append])
                  IO.binwrite(file, "#{korean}\n")
                  File.close(file)

                _ ->
                  nil
              end

            #            String.contains?(types, ["pvg"]) ->
            #              case find(korean, "verb/verb.txt") do
            #                nil ->
            #                  {:ok, file} = File.open(Path.join(:code.priv_dir(:ksa), "verb/verb.txt"), [:append])
            #                  IO.binwrite(file, "#{korean}\n")
            #                  File.close(file)
            #
            #                _ ->
            #                  nil
            #              end

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
