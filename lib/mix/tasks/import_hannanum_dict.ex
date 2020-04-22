defmodule Mix.Tasks.ImportHannanumDict do
  use Mix.Task
  import Ksa.Ets.DictFile, only: [init: 0, find: 2]
  
  @path "external/hannanum_dict.txt"
  @target_path "noun/nouns.txt"
  
  @shortdoc "Imports the external dictionary"
  def run(_) do
    IO.inspect "Starting"
    
    init()
    
    {:ok, target_file} = File.open(Path.join(:code.priv_dir(:ksa), @target_path), [:append])
    
    Path.join(:code.priv_dir(:ksa), @path)
    |> File.stream!()
    |> Stream.map(
         fn x ->
           case Regex.named_captures(~r/^(?<korean>[가-힣]+?)	(?<type>.+?)$/, x) do
             %{"korean" => korean, "type" => types} when byte_size(korean) > 3 ->
              Enum.map(String.split(types, ["\t", " "], [:trim, parts: 2]), fn type ->
                cond do
                  type == "ncpa" ->
                    case find(korean, "noun/nouns.txt") do
                      nil ->
                        IO.binwrite(target_file, "#{korean}\n")
                      _ ->
                        nil
                    end
                  true->
                    nil # Ignore others, just add the type(s) above
                end
              end)
             _ -> nil
           end
         end
       )
    |> Stream.run()
    
    File.close(target_file)
    
    IO.inspect "Success"
  end
end