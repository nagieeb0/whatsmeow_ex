defmodule InstamadilloCoreTypeText.Text.FormatStyle do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "InstamadilloCoreTypeText.Text.FormatStyle",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "FormatStyle",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TEXT_FORMAT_STYLE_UNSPECIFIED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TEXT_FORMAT_STYLE_BOLD",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TEXT_FORMAT_STYLE_ITALIC",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TEXT_FORMAT_STYLE_STRIKETHROUGH",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TEXT_FORMAT_STYLE_UNDERLINE",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TEXT_FORMAT_STYLE_INVALID",
          number: 5,
          options: nil,
          __unknown_fields__: []
        }
      ],
      options: nil,
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  field(:TEXT_FORMAT_STYLE_UNSPECIFIED, 0)
  field(:TEXT_FORMAT_STYLE_BOLD, 1)
  field(:TEXT_FORMAT_STYLE_ITALIC, 2)
  field(:TEXT_FORMAT_STYLE_STRIKETHROUGH, 3)
  field(:TEXT_FORMAT_STYLE_UNDERLINE, 4)
  field(:TEXT_FORMAT_STYLE_INVALID, 5)
end

defmodule InstamadilloCoreTypeText.Text do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeText.Text",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Text",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "text",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "text",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isSuggestedReply",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isSuggestedReply",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "postbackPayload",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "postbackPayload",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "powerUpData",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeText.PowerUpsData",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "powerUpData",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "commands",
          extendee: nil,
          number: 5,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeText.CommandRangeData",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "commands",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "animatedEmojiCharacterRanges",
          extendee: nil,
          number: 6,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeText.AnimatedEmojiCharacterRange",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "animatedEmojiCharacterRanges",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "FormatStyle",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TEXT_FORMAT_STYLE_UNSPECIFIED",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TEXT_FORMAT_STYLE_BOLD",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TEXT_FORMAT_STYLE_ITALIC",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TEXT_FORMAT_STYLE_STRIKETHROUGH",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TEXT_FORMAT_STYLE_UNDERLINE",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TEXT_FORMAT_STYLE_INVALID",
              number: 5,
              options: nil,
              __unknown_fields__: []
            }
          ],
          options: nil,
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        }
      ],
      extension_range: [],
      extension: [],
      options: nil,
      oneof_decl: [],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  field(:text, 1, optional: true, type: :string)
  field(:isSuggestedReply, 2, optional: true, type: :bool)
  field(:postbackPayload, 3, optional: true, type: :string)
  field(:powerUpData, 4, optional: true, type: InstamadilloCoreTypeText.PowerUpsData)
  field(:commands, 5, repeated: true, type: InstamadilloCoreTypeText.CommandRangeData)

  field(:animatedEmojiCharacterRanges, 6,
    repeated: true,
    type: InstamadilloCoreTypeText.AnimatedEmojiCharacterRange
  )
end

defmodule InstamadilloCoreTypeText.PowerUpsData do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeText.PowerUpsData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PowerUpsData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "style",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "style",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaAttachment",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.CommonMediaTransport",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaAttachment",
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

  field(:style, 1, optional: true, type: :int32)
  field(:mediaAttachment, 2, optional: true, type: InstamadilloCoreTypeMedia.CommonMediaTransport)
end

defmodule InstamadilloCoreTypeText.CommandRangeData do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeText.CommandRangeData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "CommandRangeData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "offset",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "offset",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "length",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "length",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "type",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "type",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "FBID",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "FBID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "userOrThreadFbid",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "userOrThreadFbid",
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

  field(:offset, 1, optional: true, type: :int32)
  field(:length, 2, optional: true, type: :int32)
  field(:type, 3, optional: true, type: :int32)
  field(:FBID, 4, optional: true, type: :string)
  field(:userOrThreadFbid, 5, optional: true, type: :string)
end

defmodule InstamadilloCoreTypeText.FormattedText do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeText.FormattedText",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "FormattedText",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "offset",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "offset",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "length",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "length",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "style",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".InstamadilloCoreTypeText.Text.FormatStyle",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "style",
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

  field(:offset, 1, optional: true, type: :int32)
  field(:length, 2, optional: true, type: :int32)
  field(:style, 3, optional: true, type: InstamadilloCoreTypeText.Text.FormatStyle, enum: true)
end

defmodule InstamadilloCoreTypeText.AnimatedEmojiCharacterRange do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeText.AnimatedEmojiCharacterRange",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AnimatedEmojiCharacterRange",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "offset",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "offset",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "length",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "length",
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

  field(:offset, 1, optional: true, type: :int32)
  field(:length, 2, optional: true, type: :int32)
end
