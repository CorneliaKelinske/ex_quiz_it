defmodule ExQuizItWeb.QuizLive do
  @moduledoc """
  Main LiveView for the quiz
  """
  use Phoenix.LiveView, layout: {ExQuizItWeb.LayoutView, "live.html"}
  alias ExQuizIt.Questions.Enums

  @modules [Enum, String, List]

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    questions = Enums.q_and_a(Enum)
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
       module: Enum
     )}
  end

  @impl Phoenix.LiveView
  def handle_event("guess", _value, socket) do
    {:noreply, assign(socket, display_answer: true)}
  end

  def handle_event("next", _value, %{assigns: %{questions: questions, module: module}} = socket) do
    q_and_a = Enum.random(questions)
    modules = List.delete(@modules, maybe_convert_module(module))

    {:noreply,
     assign(socket,
       question: Map.fetch!(q_and_a, "question"),
       answer: Map.fetch!(q_and_a, "answer"),
       display_answer: false,
       modules: modules
     )}
  end

  def handle_event("select", %{"module" => module}, socket) do
    questions = Enums.q_and_a(String.to_existing_atom(module))
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
end
