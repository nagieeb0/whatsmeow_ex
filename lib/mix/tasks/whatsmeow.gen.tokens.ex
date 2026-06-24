defmodule Mix.Tasks.Whatsmeow.Gen.Tokens do
  @shortdoc "Extract WhatsApp binary-XML token tables from the Go source"

  @moduledoc """
  Reads `whatsmeow-main/binary/token/token.go`, parses the `SingleByteTokens`
  and `DoubleByteTokens` literals, and writes `priv/binary/tokens.json` with
  the canonical token tables.

  Run once after the upstream Go source has been updated:

      mix whatsmeow.gen.tokens

  Then `Whatsmeow.Binary.Token` will pick up the new tables at compile time.
  """

  use Mix.Task

  @go_source "whatsmeow-main/binary/token/token.go"
  @out_path "priv/binary/tokens.json"

  @impl Mix.Task
  def run(_args) do
    src = File.read!(@go_source)
    {single, src_after_single} = extract_single_tokens(src)
    double = extract_double_tokens(src_after_single)
    version = extract_dict_version(src)

    json = Jason.encode!(%{single: single, double: double, dict_version: version}, pretty: true)
    File.mkdir_p!(Path.dirname(@out_path))
    File.write!(@out_path, json)

    Mix.shell().info(
      "Wrote #{@out_path}: #{length(single)} single, " <>
        "#{Enum.map(double, &length/1) |> Enum.sum()} double across #{length(double)} dicts, " <>
        "dict_version=#{version}"
    )
  end

  defp extract_single_tokens(src) do
    [_, after_decl] = String.split(src, "SingleByteTokens = [...]string{", parts: 2)
    {strs, rest} = read_string_array(after_decl)
    {strs, rest}
  end

  defp extract_double_tokens(src) do
    [_, after_decl] = String.split(src, "DoubleByteTokens = [...][]string{", parts: 2)
    read_dict_array(after_decl, [])
  end

  defp read_dict_array(src, acc) do
    src = String.trim_leading(src)

    case src do
      "{" <> rest ->
        {strs, rest2} = read_string_array(rest)
        # The outer array continues with `,` or terminates at `}` then `)`.
        rest3 = String.trim_leading(rest2)
        rest3 = String.trim_leading(rest3, ",")
        read_dict_array(rest3, [strs | acc])

      "}" <> _ ->
        Enum.reverse(acc)
    end
  end

  # Reads the contents of `{ "a", "b", "c" }` and returns {[strings], rest_after_brace}.
  defp read_string_array(src), do: read_string_array(src, [])

  defp read_string_array(src, acc) do
    case skip_ws(src) do
      "}" <> rest ->
        {Enum.reverse(acc), rest}

      "\"" <> rest ->
        {str, after_str} = read_string(rest, <<>>)
        rest_after = after_str |> skip_ws() |> skip_comma() |> skip_ws()
        read_string_array(rest_after, [str | acc])

      "," <> rest ->
        read_string_array(skip_ws(rest), acc)

      <<>> ->
        raise "unexpected EOF reading string array"
    end
  end

  defp read_string("\"" <> rest, acc), do: {acc, rest}

  defp read_string(<<"\\", c, rest::binary>>, acc) do
    decoded =
      case c do
        ?n -> "\n"
        ?t -> "\t"
        ?r -> "\r"
        ?\\ -> "\\"
        ?\" -> "\""
        ?x -> "\\x"
        _ -> <<c>>
      end

    read_string(rest, acc <> decoded)
  end

  defp read_string(<<c, rest::binary>>, acc), do: read_string(rest, acc <> <<c>>)

  defp skip_ws(<<c, rest::binary>>) when c in [?\s, ?\t, ?\n, ?\r], do: skip_ws(rest)
  defp skip_ws(other), do: other

  defp skip_comma("," <> rest), do: rest
  defp skip_comma(other), do: other

  defp extract_dict_version(src) do
    case Regex.run(~r/DictVersion\s*=\s*(\d+)/, src) do
      [_, v] -> String.to_integer(v)
      _ -> raise "DictVersion not found in #{@go_source}"
    end
  end
end
