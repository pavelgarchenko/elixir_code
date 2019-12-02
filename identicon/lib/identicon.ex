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
    |> Identicon.filter_odd_squares
    |> Identicon.build_pixel_map
    |> Identicon.draw_image
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250,250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    width = 50
    height = 50
    pixel_map = Enum.map grid, fn {_sq,  idx} ->
      x1 = rem(idx, 5) * width
      y1 = div(idx, 5) * height
      x2 = x1 + width
      y2 = y1 + height
      {{x1, y1}, {x2, y2}}
    end

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn {code, _idx} ->
      rem(code, 2) == 0
    end

    %Identicon.Image{image | grid: grid}
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1) #use mirror_row that uses one arg
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
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
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end
