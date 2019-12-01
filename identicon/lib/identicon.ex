defmodule Identicon do
  @moduledoc """
  Identicon generator.
  Create an image of 5x5 grid of 50x50px squares with uniq pattern
  """

  def main(input) do
    input
    |> Identicon.hash_input
    |> Identicon.pick_color
  end

  def pick_color(image) do
    %Identicon.Image{hex: [r, g, b | _tail]} = image
    [r, g, b]
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
