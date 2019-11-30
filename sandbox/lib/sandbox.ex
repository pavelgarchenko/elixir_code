defmodule Sandbox do
  @moduledoc """
  Documentation for Sandbox.
  """

  @doc """
  Examples of updating maps
  """
  def updating_maps do
    colors = %{primary: "green"}

    # Will Update existing key value or add new
    colors1 = Map.put(colors, :primary, "blue")

    # Works only for the keys that exist in the map
    colors2 = %{ colors | primary: "orange" }
  end

  @doc """
  Keyword list is useful when working with Ecto library to work with databases
  """
  def keywords do
    colors = [{:primary, "red"}, {:secondary, "green"}]
    # [primary: "red", secondary: "green"]
    colors = [primary: "blue", primary: "orange"]
    # [primary: "blue", primary: "orange"]
    colors[:primary]
    # [primary: "blue"]
    #
    # User.find_where([where: user.age > 10, where: user.subscribed == true])
    #  or if the keyword list is the last argument [] can be ommited
    # User.find_where(where: user.age > 10, where: user.subscribed == true)
    # or
    # User.find_where where: user.age > 10, where: user.subscribed == true
  end
end
