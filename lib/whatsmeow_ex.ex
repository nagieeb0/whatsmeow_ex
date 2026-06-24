defmodule WhatsmeowEx do
  @moduledoc """
  Compatibility alias for the package atom `:whatsmeow_ex`. The real public
  API lives in `Whatsmeow`.
  """

  defdelegate version(), to: Whatsmeow
end
