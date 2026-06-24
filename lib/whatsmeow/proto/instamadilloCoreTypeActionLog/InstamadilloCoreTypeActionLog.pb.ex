defmodule InstamadilloCoreTypeActionLog.ActionLog do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeActionLog.ActionLog",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ActionLog",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "actionLogReaction",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeActionLog.ActionLogReaction",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "actionLogReaction",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [],
      extension_range: [],
      extension: [],
      options: nil,
      oneof_decl: [
        %Google.Protobuf.OneofDescriptorProto{
          name: "actionLogSubtype",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:actionLogSubtype, 0)

  field(:actionLogReaction, 1,
    optional: true,
    type: InstamadilloCoreTypeActionLog.ActionLogReaction,
    oneof: 0
  )
end

defmodule InstamadilloCoreTypeActionLog.ActionLogReaction do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeActionLog.ActionLogReaction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ActionLogReaction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "emojiUnicode",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "emojiUnicode",
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

  field(:emojiUnicode, 1, optional: true, type: :string)
end
