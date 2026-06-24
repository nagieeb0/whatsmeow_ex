%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/", "test/", "config/"],
        excluded: [~r"/_build/", ~r"/deps/", ~r"/lib/whatsmeow/proto/"]
      },
      strict: true,
      color: true,
      checks: [
        # Disabled / relaxed for protocol-port code
        {Credo.Check.Readability.AliasAs, false},
        {Credo.Check.Readability.ModuleDoc, false},
        {Credo.Check.Refactor.CyclomaticComplexity, max_complexity: 12},
        {Credo.Check.Refactor.FunctionArity, max_arity: 10},

        # Iron Law: atoms from network input
        {Credo.Check.Warning.UnsafeToAtom, []},

        # Iron Law: never silently swallow errors
        {Credo.Check.Warning.IExPry, []},

        # Style
        {Credo.Check.Readability.LargeNumbers, []},
        {Credo.Check.Readability.MaxLineLength, max_length: 100},
        {Credo.Check.Readability.ParenthesesOnZeroArityDefs, []},
        {Credo.Check.Readability.PredicateFunctionNames, []},
        {Credo.Check.Readability.PreferImplicitTry, []},
        {Credo.Check.Readability.RedundantBlankLines, []},
        {Credo.Check.Readability.Semicolons, []},
        {Credo.Check.Readability.SpaceAfterCommas, []},
        {Credo.Check.Readability.StringSigils, []},
        {Credo.Check.Readability.TrailingBlankLine, []},
        {Credo.Check.Readability.TrailingWhiteSpace, []}
      ]
    }
  ]
}
