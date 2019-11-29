defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards

      $ iex -S mix

      recompile
      'arity' - is a term for number of args
      arity of one - one arg
      or arity one
  """

  @doc """
  Returns a list of strings representing a deck of cards.
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

  @doc """
  Determines whether the deck contains the card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Devides a deck into a hand and the remainder of the deck.
  The `hand_size` argument indicates how many cards should
  be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
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
