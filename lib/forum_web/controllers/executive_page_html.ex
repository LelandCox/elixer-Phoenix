defmodule ForumWeb.ExecutivePageHTML do
  use ForumWeb, :html

  embed_templates "executive_page_html/*"

  @doc """
  Renders a executive form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :studios, :list, required: true
  attr :production_companies, :list, required: true

  def executive_form(assigns)
end
