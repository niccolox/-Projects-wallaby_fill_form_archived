defmodule WallabyFillForm do
  @moduledoc """
  WallabyFillForm allows you to specify a keyword list of attributes to be input
  rather than procedurally calling Wallaby's DSL methods.
  """

  use Wallaby.DSL

  alias Wallaby.Query
  alias Phoenix.HTML.Form

  @doc """
  `fill_form/2` provides an interface for completely filling out a form. It
  takes a Wallaby session and a keyword list of attributes to be filled. It
  returns a Wallaby session to continue chaining.

  `fill_form/2` will call `Phoenix.HTML.Form.humanize/1` on each atom key to
  find the field's label. This is the default label if you are using
  Phoenix.HTML form functions. If you pass a string, `fill_form/2` will match on
  the string directly.

  `fill_form/2` uses the type of each attribute's value to determine what kind
  of HTML element it should look for. For example, a boolean value will look for
  a checkbox and a string will look for a text input.

  ## Example

      session
      |> visit("/sign_up")
      |> WallabyFillForm.fill_form(%{
        :email => "email@example.com",
        :password => "password",
        "First Name" => "Name",
        :subscribe => true,
      })

      # It also works with keyword lists

      session
      |> visit("/sign_up")
      |> WallabyFillForm.fill_form([email: "foo@bar.com"])
  """

  @spec fill_form(Wallaby.Session.t, keyword) :: Wallaby.Session.t
  def fill_form(session, params) do
    Enum.each(params, fn {key, value} ->
      field = field_for(session, key, value)
      fill(session, field, value)
    end)

    session
  end

  defp field_for(session, key, value) do
    label = label_for(key)

    cond do
      is_boolean(value) ->
        Query.checkbox(label)

      is_binary(value) || is_number(value) ->
        field_for_string(session, label)

      true ->
        raise_unsupported_type_error(key, value)
    end
  end

  defp label_for(key) when is_atom(key), do: Form.humanize(key)
  defp label_for(key) when is_binary(key), do: key

  defp raise_unsupported_type_error(key, value) do
    raise(
      ArgumentError,
      "Unsupported type for value: #{inspect value} at key: #{inspect key}."
    )
  end

  defp field_for_string(session, label) do
    cond do
      Browser.visible?(session, Query.text_field(label)) ->
        Query.text_field(label)
      Browser.visible?(session, Query.select(label)) ->
        Query.select(label)
      true ->
        raise_missing_field_error(label)
    end
  end

  defp raise_missing_field_error(label) do
    raise "Couldn't find a text field or select box for label: #{label}"
  end

  defp fill(session, field, value) do
    case field do
      %{method: :checkbox} ->
        set_checkbox(session, field, value)

      %{method: :fillable_field} ->
        fill_in(session, field, with: value)

      %{method: :select} ->
        session
        |> click(field)
        |> click(Query.option(value))
    end

    session
  end

  defp set_checkbox(session, checkbox, value) do
    is_selected = session |> find(checkbox) |> Element.selected?

    if is_selected != value do
      click(session, checkbox)
    else
      session
    end
  end
end
