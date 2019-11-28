defmodule Cards do
  @moduledoc """
  Documentation for Cards.
  """

  @doc """
  Create deck.

  ## Examples

      $ iex -S mix
      iex> Cards.create_deck()
      ["Ace", "Two", "Three"]

      recompile
      'arity' - is a term for number of args
      arity of one - one arg
      or arity one
  """

  def create_deck do
    # in functional programming the value is
    # return w/o assigning it to an isnstance variable
    ranks = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Diamonds", "Hearts"]

    for suit <- suits, rank <- ranks do
      "#{rank} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    # Patern Matching is Elixir's replacement
    # for variable assignment
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File '#{filename}' does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
