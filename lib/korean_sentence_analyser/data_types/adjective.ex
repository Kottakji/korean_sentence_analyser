defmodule KoreanSentenceAnalyser.DataTypes.Adjective do
  alias KoreanSentenceAnalyser.DataTypes.Eomi
  alias KoreanSentenceAnalyser.DataTypes.Josa
  alias KoreanSentenceAnalyser.Helpers.Dict
  alias KoreanSentenceAnalyser.Helpers.Formatter
  @data_type "Adjective"

  def adjective(word) do
    new_word = Josa.remove(word)

    case new_word === word do
      true ->
        Eomi.remove_recursively(word, "data/adjective/adjective.txt", @data_type)
        |> Formatter.add_ending("다")
        |> Formatter.print_result(@data_type)

      false ->
        result =
          case Dict.find_in_file(new_word, "data/adjective/adjective.txt") do
            nil ->
              case Dict.find_in_file(new_word <> "하", "data/adjective/adjective.txt") do
                nil ->
                  Eomi.remove_recursively(word, "data/adjective/adjective.txt", @data_type)

                match ->
                  match
              end

            match ->
              match
          end

        result
        |> Formatter.add_ending("다")
        |> Formatter.print_result(@data_type)
    end
  end
end
