defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.TopicController

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"topic" => topic}) do
  end
end