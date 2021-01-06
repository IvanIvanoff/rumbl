defmodule Rumbl.Multimedia.Annotation do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rumbl.{Accounts, Multimedia}

  schema "annotations" do
    field :at, :integer
    field :body, :string
    belongs_to :user, Accounts.User
    belongs_to :video, Multimedia.Video

    timestamps()
  end

  @doc false
  def changeset(annotation, attrs) do
    annotation
    |> cast(attrs, [:body, :at])
    |> validate_required([:body, :at])
  end
end
