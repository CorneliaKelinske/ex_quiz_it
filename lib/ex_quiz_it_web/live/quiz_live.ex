defmodule ExQuizItWeb.QuizLive do
  use Phoenix.LiveView, layout: {ExQuizItWeb.LayoutView, "live.html"}

  @questions ["what does the fox say?", "what did the confident pickle say?", "are we there yet?"]

  def mount(_params, _session, socket) do
    {:ok, assign(socket, message: "Make a guess:", questions: @questions, answer: "")}
  end

  def render(assigns) do
    ~H"""

    <h2>
      <%= @message %>
    </h2>
    <h2>
    <%= Enum.random(@questions) %>
    </h2>
    <h2>
    <%= @answer %>
    </h2>
    <button phx-click="guess">Show answer</button>
    <button phx-click="next"> Next question</button>
    """
  end

  def handle_event("guess", _value, socket) do
    answer = "No one knows"
    {:noreply, assign(socket, answer: answer)}
  end

  def handle_event("next", _value, socket) do
    {:noreply, assign(socket, questions: @questions, answer: "")}
  end
end
