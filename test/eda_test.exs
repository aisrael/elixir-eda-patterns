defmodule EDATest do
  use ExUnit.Case
  doctest EDA

  test "greets the world" do
    assert EDA.hello() == :world
  end
end
