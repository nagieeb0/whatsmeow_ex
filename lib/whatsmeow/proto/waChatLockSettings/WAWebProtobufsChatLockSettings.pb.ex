defmodule WAWebProtobufsChatLockSettings.ChatLockSettings do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsChatLockSettings.ChatLockSettings",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ChatLockSettings",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "hideLockedChats",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "hideLockedChats",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "secretCode",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsUserPassword.UserPassword",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "secretCode",
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

  field(:hideLockedChats, 1, optional: true, type: :bool)
  field(:secretCode, 2, optional: true, type: WAWebProtobufsUserPassword.UserPassword)
end
