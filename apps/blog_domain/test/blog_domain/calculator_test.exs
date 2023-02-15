defmodule BlogDomain.CalculatorTest do
  use BlogDomain.DataCase
  use Mimic
  alias BlogDomain.Calculator

  test "invokes mult once and add twice" do
    Calculator
    |> stub(:add, fn x, y -> :stub end)
    |> expect(:add, fn x, y -> x + y end)
    |> expect(:mult, 2, fn x, y -> x * y end)

    assert Calculator.add(2, 3) == 5
    assert Calculator.mult(2, 3) == 6
    assert Calculator.mult(2, 3) == 6
  end
end
