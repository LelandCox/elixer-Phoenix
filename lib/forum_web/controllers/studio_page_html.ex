defmodule ForumWeb.StudioPageHTML do
  use ForumWeb, :html

  embed_templates "studio_page_html/*"

  @doc """
  Renders a studio form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :executives, :list, default: []
  attr :producers, :list, default: []

  def studio_form(assigns)
end
