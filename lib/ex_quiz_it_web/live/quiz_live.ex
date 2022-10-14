defmodule ExQuizItWeb.QuizLive do
  @moduledoc """
  Main LiveView for the quiz
  """
  use Phoenix.LiveView, layout: {ExQuizItWeb.LayoutView, "live.html"}
  alias ExQuizIt.Questions.Enums

  @questions Enums.q_and_a()

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    q_and_a = Enum.random(@questions)

    {:ok,
     assign(socket,
       message: "Make a guess:",
       question: Map.fetch!(q_and_a, "question"),
       answer: Map.fetch!(q_and_a, "answer"),
       display_answer: false
     )}
  end

  @impl Phoenix.LiveView
  def handle_event("guess", _value, socket) do
    {:noreply, assign(socket, display_answer: true)}
  end

  def handle_event("next", _value, socket) do
    q_and_a = Enum.random(@questions)

    {:noreply,
     assign(socket,
       message: "Make a guess:",
       question: Map.fetch!(q_and_a, "question"),
       answer: Map.fetch!(q_and_a, "answer"),
       display_answer: false
     )}
  end
end
