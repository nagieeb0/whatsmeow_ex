defmodule Mix.Tasks.Whatsmeow.Protoc do
  @shortdoc "Generate Whatsmeow.Proto.* modules from priv/protos/*.proto"

  @moduledoc """
  Regenerates the Elixir modules under `lib/whatsmeow/proto/` from the
  vendored `.proto` schemas in `priv/protos/`.

  ## Prerequisites

  * `protoc` (Protocol Buffers compiler) on `$PATH`. Install via your OS
    package manager (`brew install protobuf`, `apt install protobuf-compiler`,
    or download from https://github.com/protocolbuffers/protobuf/releases).
  * `protoc-gen-elixir` escript on `$PATH`. Install with:

        mix escript.install hex protobuf

  ## Usage

      mix whatsmeow.protoc

  This task is **not** run automatically — generated code is checked in to
  keep `mix compile` hermetic.
  """

  use Mix.Task

  @proto_dir "priv/protos"
  @out_dir "lib/whatsmeow/proto"

  @impl Mix.Task
  def run(_args) do
    ensure_protoc!()
    ensure_plugin!()

    File.mkdir_p!(@out_dir)

    protos = Path.wildcard("#{@proto_dir}/**/*.proto")

    if protos == [] do
      Mix.raise("No .proto files found under #{@proto_dir}")
    end

    Mix.shell().info("Generating #{length(protos)} proto files → #{@out_dir}")

    args = [
      "--elixir_out=plugins=grpc,gen_descriptors=true:#{@out_dir}",
      "-I",
      @proto_dir
      | protos
    ]

    case System.cmd("protoc", args, stderr_to_stdout: true) do
      {output, 0} ->
        Mix.shell().info(output)
        Mix.shell().info("Done. #{count_generated(@out_dir)} .ex files generated.")

      {output, code} ->
        Mix.raise("protoc exited #{code}:\n#{output}")
    end
  end

  defp ensure_protoc! do
    unless System.find_executable("protoc") do
      Mix.raise("""
      `protoc` not found on PATH.

      Install Protocol Buffers compiler. See `mix help whatsmeow.protoc`.
      """)
    end
  end

  defp ensure_plugin! do
    unless System.find_executable("protoc-gen-elixir") do
      Mix.raise("""
      `protoc-gen-elixir` not found on PATH.

      Install with:

          mix escript.install hex protobuf

      And ensure the escripts directory is on your PATH. See
      `mix help whatsmeow.protoc`.
      """)
    end
  end

  defp count_generated(dir) do
    Path.wildcard("#{dir}/**/*.pb.ex") |> length()
  end
end
