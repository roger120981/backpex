defmodule DemoWeb.TagLive do
  use Backpex.LiveResource,
    layout: {DemoWeb.Layouts, :admin},
    schema: Demo.Tag,
    repo: Demo.Repo,
    update_changeset: &Demo.Tag.update_changeset/3,
    create_changeset: &Demo.Tag.create_changeset/3,
    pubsub: Demo.PubSub,
    topic: "tags",
    event_prefix: "tag_"

  @impl Backpex.LiveResource
  def singular_name, do: "Tag"

  @impl Backpex.LiveResource
  def plural_name, do: "Tags"

  @impl Backpex.LiveResource
  def fields do
    [
      name: %{
        module: Backpex.Fields.Text,
        label: "Name",
        searchable: true,
        placeholder: "Tag name"
      },
      inserted_at: %{
        module: Backpex.Fields.DateTime,
        label: "Inserted At",
        only: [:show, :index]
      }
    ]
  end

  @impl Backpex.LiveResource
  def item_actions(default_actions) do
    Enum.concat(
      [
        duplicate: %{
          module: DemoWeb.ItemActions.DuplicateTag,
          only: [:row]
        }
      ],
      default_actions
    )
  end
end
