defmodule WAWebProtobufsGroupHistory.GroupHistory do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsGroupHistory.GroupHistory",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "GroupHistory",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messages",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.WebMessageInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messages",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "uncountedAssociatedMessageLists",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsGroupHistory.UnCountedAssociatedMessageList",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "uncountedAssociatedMessageLists",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "commentMessages",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.WebMessageInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "commentMessages",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "outOfWindowPinnedMessages",
          extendee: nil,
          number: 4,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.WebMessageInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "outOfWindowPinnedMessages",
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

  field(:messages, 1, repeated: true, type: WAWebProtobufsWeb.WebMessageInfo)

  field(:uncountedAssociatedMessageLists, 2,
    repeated: true,
    type: WAWebProtobufsGroupHistory.UnCountedAssociatedMessageList
  )

  field(:commentMessages, 3, repeated: true, type: WAWebProtobufsWeb.WebMessageInfo)
  field(:outOfWindowPinnedMessages, 4, repeated: true, type: WAWebProtobufsWeb.WebMessageInfo)
end

defmodule WAWebProtobufsGroupHistory.UnCountedAssociatedMessageList do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsGroupHistory.UnCountedAssociatedMessageList",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "UnCountedAssociatedMessageList",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messages",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.WebMessageInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messages",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "parentMessage",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "parentMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "associationType",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsE2E.MessageAssociation.AssociationType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "associationType",
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

  field(:messages, 1, repeated: true, type: WAWebProtobufsWeb.WebMessageInfo)
  field(:parentMessage, 2, optional: true, type: WACommon.MessageKey)

  field(:associationType, 3,
    optional: true,
    type: WAWebProtobufsE2E.MessageAssociation.AssociationType,
    enum: true
  )
end

defmodule WAWebProtobufsGroupHistory.WebMessageInfoWithMessageBytes do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsGroupHistory.WebMessageInfoWithMessageBytes",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "WebMessageInfoWithMessageBytes",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "key",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "key",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageBytes",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageBytes",
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

  field(:key, 1, optional: true, type: WACommon.MessageKey)
  field(:messageBytes, 2, optional: true, type: :bytes)
end

defmodule WAWebProtobufsGroupHistory.UnCountedAssociatedMessageListWithMessageBytes do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsGroupHistory.UnCountedAssociatedMessageListWithMessageBytes",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "UnCountedAssociatedMessageListWithMessageBytes",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messages",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsGroupHistory.WebMessageInfoWithMessageBytes",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messages",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "parentMessage",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "parentMessage",
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

  field(:messages, 1,
    repeated: true,
    type: WAWebProtobufsGroupHistory.WebMessageInfoWithMessageBytes
  )

  field(:parentMessage, 2, optional: true, type: WACommon.MessageKey)
end

defmodule WAWebProtobufsGroupHistory.GroupHistoryWithMessageBytes do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsGroupHistory.GroupHistoryWithMessageBytes",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "GroupHistoryWithMessageBytes",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messages",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsGroupHistory.WebMessageInfoWithMessageBytes",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messages",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "uncountedAssociatedMessageLists",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsGroupHistory.UnCountedAssociatedMessageListWithMessageBytes",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "uncountedAssociatedMessageLists",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "commentMessages",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsGroupHistory.WebMessageInfoWithMessageBytes",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "commentMessages",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "outOfWindowPinnedMessages",
          extendee: nil,
          number: 4,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsGroupHistory.WebMessageInfoWithMessageBytes",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "outOfWindowPinnedMessages",
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

  field(:messages, 1,
    repeated: true,
    type: WAWebProtobufsGroupHistory.WebMessageInfoWithMessageBytes
  )

  field(:uncountedAssociatedMessageLists, 2,
    repeated: true,
    type: WAWebProtobufsGroupHistory.UnCountedAssociatedMessageListWithMessageBytes
  )

  field(:commentMessages, 3,
    repeated: true,
    type: WAWebProtobufsGroupHistory.WebMessageInfoWithMessageBytes
  )

  field(:outOfWindowPinnedMessages, 4,
    repeated: true,
    type: WAWebProtobufsGroupHistory.WebMessageInfoWithMessageBytes
  )
end
