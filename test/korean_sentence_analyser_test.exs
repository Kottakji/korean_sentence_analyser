defmodule KoreanSentenceAnalyserTest do
  use ExUnit.Case
  doctest KoreanSentenceAnalyser

  test "greets the world" do
    assert KoreanSentenceAnalyser.hello() == :world
  end
end
