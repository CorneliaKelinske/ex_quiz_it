env = %{"MIX_ENV" => "test"}

[
  fix: true,
  retry: false,
  tools: [
    {:compiler, command: "mix compile", env: env},
    {:credo, command: "mix credo --strict", env: env},
    {:formatter, command: "mix format", env: env},
    {:dialyzer, command: "mix dialyzer", env: env}
  ]
]
