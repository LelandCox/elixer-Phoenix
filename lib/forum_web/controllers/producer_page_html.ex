defmodule ForumWeb.ProducerPageHTML do
  use ForumWeb, :html

  embed_templates "producer_page_html/*"

  @doc """
  Renders a producer form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :studios, :list, required: true
  attr :production_companies, :list, required: true

  def producer_form(assigns)
end
