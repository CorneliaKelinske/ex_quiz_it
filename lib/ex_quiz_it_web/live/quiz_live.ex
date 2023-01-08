defmodule ExQuizItWeb.QuizLive do
  @moduledoc """
  Main LiveView for the quiz
  """
  use Phoenix.LiveView, layout: {ExQuizItWeb.LayoutView, "live.html"}
  import ExQuizItWeb.Button, only: [button: 1]
  alias ExQuizIt.QuizBuilder

  @modules [Enum, String, List]

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    questions = QuizBuilder.q_and_a(Enum)
    q_and_a = Enum.random(questions)
    modules = List.delete(@modules, Enum)

    {:ok,
     assign(socket,
       message: "What does this function do? Make a guess!",
       question: Map.fetch!(q_and_a, "question"),
       answer: Map.fetch!(q_and_a, "answer"),
       display_answer: false,
       modules: modules,
       questions: questions,
       module: Enum,
       score: 0
     )}
  end

  @impl Phoenix.LiveView
  def handle_event("guess", _value, socket) do
    {:noreply, assign(socket, display_answer: true)}
  end

  def handle_event(
        "next",
        %{"value" => value},
        %{assigns: %{questions: questions, module: module, score: score}} = socket
      ) do
    q_and_a = Enum.random(questions)
    modules = List.delete(@modules, maybe_convert_module(module))
    score = maybe_update_score(value, score)

    {:noreply,
     assign(socket,
       question: Map.fetch!(q_and_a, "question"),
       answer: Map.fetch!(q_and_a, "answer"),
       display_answer: false,
       modules: modules,
       score: score
     )}
  end

  def handle_event("select", %{"module" => module}, socket) do
    questions = QuizBuilder.q_and_a(String.to_existing_atom(module))
    q_and_a = Enum.random(questions)
    modules = List.delete(@modules, module)

    {:noreply,
     assign(socket,
       question: Map.fetch!(q_and_a, "question"),
       answer: Map.fetch!(q_and_a, "answer"),
       display_answer: false,
       modules: modules,
       questions: questions,
       module: module
     )}
  end

  defp maybe_convert_module(module) when is_binary(module) do
    String.to_atom(module)
  end

  defp maybe_convert_module(module), do: module

  defp maybe_update_score("yes", score), do: score + 1
  defp maybe_update_score(_, score), do: score
end
