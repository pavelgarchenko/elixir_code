defmodule Identicon do
  @moduledoc """
  Identicon generator.
  Create an image of 5x5 grid of 50x50px squares with uniq pattern
  """

  def main(input) do
    input
    |> Identicon.hash_input
    |> Identicon.pick_color
    |> Identicon.build_grid
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    hex
    |> Enum.chunk(3)
    |> Enum.map(&mirror_row/1) #use mirror_row that uses one arg
  end

  def mirror_row([first, second | _tail] = row) do
    row ++ [second, first]
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
  Generate MD5 hash from string
  ## Examples

      iex> Identicon.hash_input("Pavel")
      %Identicon.Image{hex: [152, 48, 128, 95, 215, 148, 211, 184, 203, 238, 34, 254, 137, 143, 239, 183]}
  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end
