defmodule ExQuizItWeb.ButtonTest do
  use ExUnit.Case, async: true
  import Phoenix.LiveViewTest, only: [rendered_to_string: 1]
  use Phoenix.Component

  alias ExQuizItWeb.Button

  describe "@button/1" do
    test "receives inner block slot and attributes" do
      assigns = %{color: "purple", size: "xl"}

      button =
        rendered_to_string(~H"""
        <Button.button color={@color} size={@size} click_action="next" value="yes">
          Yes
        </Button.button>
        """)

      assert button =~ "bg-purple-900"
      assert button =~ "Yes"
      assert button =~ "text-xl"
    end
  end
end
