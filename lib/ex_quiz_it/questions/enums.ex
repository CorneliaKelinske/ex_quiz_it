defmodule ExQuizIt.Questions.Enums do
  @moduledoc false
  def q_and_a do
    {:docs_v1, _, :elixir, _, _, _, functions} = Code.fetch_docs(Enum)

    functions
    |> Stream.map(&doc_parser/1)
    |> Stream.map(&get_answer/1)
    |> Stream.map(&q_and_a_builder/1)
    |> Enum.to_list()
    |> List.flatten()
  end

  defp doc_parser({{_, name, arity}, _, _, %{"en" => details}, _}) do
    {name, arity, details}
  end

  defp doc_parser(_) do
    []
  end

  defp get_answer({name, arity, details}) do
    answer =
      details
      |> String.split("Example")
      |> List.first()
      |> String.trim_trailing("\n\n## ")

    {name, arity, answer}
  end

  defp get_answer([]), do: []

  defp q_and_a_builder([]), do: []

  defp q_and_a_builder({function, arity, answer}) do
    %{"question" => "#{to_string(function)}/#{arity}", "answer" => answer}
  end
end
