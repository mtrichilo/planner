defmodule PlannerWeb.FieldView do
  use PlannerWeb, :view
  alias PlannerWeb.FieldView

  def render("index.json", %{poll_fields: poll_fields}) do
    %{data: render_many(poll_fields, FieldView, "field.json")}
  end

  def render("show.json", %{field: field}) do
    %{data: render_one(field, FieldView, "field.json")}
  end

  def render("field.json", %{field: field}) do
    %{id: field.id,
      field_name: field.field_name}
  end
end
