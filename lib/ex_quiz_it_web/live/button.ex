defmodule ExQuizItWeb.Button do
  use ExQuizItWeb, :component

  @moduledoc """
  Reusable button component. Can be used as follows:

  `<.button color="purple" click_action="click" size="xl">
    Label
  </.button>`
  """

  attr :size, :string, default: "xl"
  attr :color, :string, required: true, values: ["purple"]
  attr :click_action, :string, default: nil
  attr :disabled, :boolean, default: false
  attr :value, :any, default: nil

  slot(:inner_block, required: true)

  def button(assigns) do
    ~H"""
    <button class={["inline-flex items-center justify-center", color(@color), size(@size)]} phx-click={@click_action} disabled={@disabled} value={@value}>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  defp color("purple"),
    do: "bg-purple-900 bg-opacity-80 hover:bg-purple-500 text-center text-slate-900"

  defp size("xl"),
    do: "mt-12 w-2/5 md:w-1/5 h-16 text-xl rounded-xl shadow-xl font-medium items-center"
end
