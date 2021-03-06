defmodule Rumbl.Multimedia.Video do
  use Ecto.Schema

  import Ecto.Query
  import Ecto.Changeset

  alias Rumbl.Repo
  alias Rumbl.{Accounts, Multimedia}

  @primary_key {:id, Multimedia.Permalink, autogenerate: true}
  schema "videos" do
    field :url, :string
    field :slug, :string
    field :title, :string
    field :description, :string

    belongs_to :user, Accounts.User
    belongs_to :category, Multimedia.Category

    has_many :annotations, Multimedia.Annotation

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:url, :title, :description, :category_id])
    |> validate_required([:url, :title, :description])
    |> assoc_constraint(:category)
    |> slugify_title()
  end

  defp slugify_title(changeset) do
    case fetch_change(changeset, :title) do
      {:ok, new_title} -> put_change(changeset, :slug, slugify(new_title))
      :error -> changeset
    end
  end

  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end
end
