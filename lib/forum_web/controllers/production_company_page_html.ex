defmodule ForumWeb.ProductionCompanyPageHTML do
  use ForumWeb, :html

  embed_templates "production_company_page_html/*"

  @doc """
  Renders a production_company form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :studios, :list, required: true

  def production_company_form(assigns)
end
