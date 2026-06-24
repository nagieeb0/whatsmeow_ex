defmodule InstamadilloDeleteMessage.DeleteMessagePayload do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloDeleteMessage.DeleteMessagePayload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "DeleteMessagePayload",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageOtid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageOtid",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [],
      extension_range: [],
      extension: [],
      options: nil,
      oneof_decl: [],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  field(:messageOtid, 1, optional: true, type: :string)
end
