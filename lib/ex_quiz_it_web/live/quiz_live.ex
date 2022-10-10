defmodule ExQuizItWeb.QuizLive do
  @moduledoc """
  Main LiveView for the quiz
  """
  use Phoenix.LiveView, layout: {ExQuizItWeb.LayoutView, "live.html"}

  @questions ["what does the fox say?", "what did the confident pickle say?", "are we there yet?"]

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    question = Enum.random(@questions)
    {:ok, assign(socket, message: "Make a guess:", question: question, answer: "")}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""

    <h2>
      <%= @message %>
    </h2>
    <h2>
    <%= @question %>
    </h2>
    <h2>
    <%= @answer %>
    </h2>
    <button phx-click="guess">Show answer</button>
    <button phx-click="next"> Next question</button>
    """
  end

  @impl Phoenix.LiveView
  def handle_event("guess", _value, socket) do
    answer = "No one knows"
    {:noreply, assign(socket, answer: answer)}
  end

  def handle_event("next", _value, socket) do
    question = Enum.random(@questions)
    {:noreply, assign(socket, question: question, answer: "")}
  end
end
