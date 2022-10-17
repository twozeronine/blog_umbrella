defmodule BlogClientTest do
  use ExUnit.Case
  doctest BlogClient

  test "greets the world" do
    assert BlogClient.hello() == :world
  end
end
