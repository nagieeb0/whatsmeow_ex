defmodule WAMsgApplication.MessageApplication.Metadata.ThreadType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAMsgApplication.MessageApplication.Metadata.ThreadType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ThreadType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DEFAULT",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VANISH_MODE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DISAPPEARING_MESSAGES",
          number: 2,
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

  field(:DEFAULT, 0)
  field(:VANISH_MODE, 1)
  field(:DISAPPEARING_MESSAGES, 2)
end

defmodule WAMsgApplication.MessageApplication.EphemeralSetting.EphemeralityType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAMsgApplication.MessageApplication.EphemeralSetting.EphemeralityType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "EphemeralityType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SEEN_ONCE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SEEN_BASED_WITH_TIMER",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SEND_BASED_WITH_TIMER",
          number: 3,
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

  field(:UNKNOWN, 0)
  field(:SEEN_ONCE, 1)
  field(:SEEN_BASED_WITH_TIMER, 2)
  field(:SEND_BASED_WITH_TIMER, 3)
end

defmodule WAMsgApplication.MessageApplication.Metadata.QuotedMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgApplication.MessageApplication.Metadata.QuotedMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "QuotedMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "stanzaID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "stanzaID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "remoteJID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "remoteJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "participant",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "participant",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "payload",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgApplication.MessageApplication.Payload",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "payload",
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

  field(:stanzaID, 1, optional: true, type: :string)
  field(:remoteJID, 2, optional: true, type: :string)
  field(:participant, 3, optional: true, type: :string)
  field(:payload, 4, optional: true, type: WAMsgApplication.MessageApplication.Payload)
end

defmodule WAMsgApplication.MessageApplication.Metadata.EphemeralSettingMap do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgApplication.MessageApplication.Metadata.EphemeralSettingMap",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "EphemeralSettingMap",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatJID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "chatJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralSetting",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgApplication.MessageApplication.EphemeralSetting",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeralSetting",
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

  field(:chatJID, 1, optional: true, type: :string)

  field(:ephemeralSetting, 2,
    optional: true,
    type: WAMsgApplication.MessageApplication.EphemeralSetting
  )
end

defmodule WAMsgApplication.MessageApplication.Metadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgApplication.MessageApplication.Metadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Metadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatEphemeralSetting",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgApplication.MessageApplication.EphemeralSetting",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "chatEphemeralSetting",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralSettingList",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgApplication.MessageApplication.Metadata.EphemeralSettingMap",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "ephemeralSettingList",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralSharedSecret",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "ephemeralSharedSecret",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "forwardingScore",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "forwardingScore",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isForwarded",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isForwarded",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "businessMetadata",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "businessMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "frankingKey",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "frankingKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "frankingVersion",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "frankingVersion",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "quotedMessage",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgApplication.MessageApplication.Metadata.QuotedMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "quotedMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "threadType",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAMsgApplication.MessageApplication.Metadata.ThreadType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "threadType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "readonlyMetadataDataclass",
          extendee: nil,
          number: 12,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "readonlyMetadataDataclass",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupID",
          extendee: nil,
          number: 13,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "groupID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupSize",
          extendee: nil,
          number: 14,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "groupSize",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupIndex",
          extendee: nil,
          number: 15,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "groupIndex",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botResponseID",
          extendee: nil,
          number: 16,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botResponseID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "collapsibleID",
          extendee: nil,
          number: 17,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "collapsibleID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "secondaryOtid",
          extendee: nil,
          number: 18,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "secondaryOtid",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "QuotedMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "stanzaID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "stanzaID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "remoteJID",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "remoteJID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "participant",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "participant",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "payload",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMsgApplication.MessageApplication.Payload",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "payload",
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
        },
        %Google.Protobuf.DescriptorProto{
          name: "EphemeralSettingMap",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "chatJID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "chatJID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "ephemeralSetting",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMsgApplication.MessageApplication.EphemeralSetting",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "ephemeralSetting",
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
      ],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "ThreadType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DEFAULT",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VANISH_MODE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DISAPPEARING_MESSAGES",
              number: 2,
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
      oneof_decl: [
        %Google.Protobuf.OneofDescriptorProto{
          name: "ephemeral",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:ephemeral, 0)

  field(:chatEphemeralSetting, 1,
    optional: true,
    type: WAMsgApplication.MessageApplication.EphemeralSetting,
    oneof: 0
  )

  field(:ephemeralSettingList, 2,
    optional: true,
    type: WAMsgApplication.MessageApplication.Metadata.EphemeralSettingMap,
    oneof: 0
  )

  field(:ephemeralSharedSecret, 3, optional: true, type: :bytes, oneof: 0)
  field(:forwardingScore, 5, optional: true, type: :uint32)
  field(:isForwarded, 6, optional: true, type: :bool)
  field(:businessMetadata, 7, optional: true, type: WACommon.SubProtocol)
  field(:frankingKey, 8, optional: true, type: :bytes)
  field(:frankingVersion, 9, optional: true, type: :int32)

  field(:quotedMessage, 10,
    optional: true,
    type: WAMsgApplication.MessageApplication.Metadata.QuotedMessage
  )

  field(:threadType, 11,
    optional: true,
    type: WAMsgApplication.MessageApplication.Metadata.ThreadType,
    enum: true
  )

  field(:readonlyMetadataDataclass, 12, optional: true, type: :string)
  field(:groupID, 13, optional: true, type: :string)
  field(:groupSize, 14, optional: true, type: :uint32)
  field(:groupIndex, 15, optional: true, type: :uint32)
  field(:botResponseID, 16, optional: true, type: :string)
  field(:collapsibleID, 17, optional: true, type: :string)
  field(:secondaryOtid, 18, optional: true, type: :string)
end

defmodule WAMsgApplication.MessageApplication.Payload do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgApplication.MessageApplication.Payload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Payload",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "coreContent",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgApplication.MessageApplication.Content",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "coreContent",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "signal",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgApplication.MessageApplication.Signal",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "signal",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "applicationData",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgApplication.MessageApplication.ApplicationData",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "applicationData",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "subProtocol",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgApplication.MessageApplication.SubProtocolPayload",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "subProtocol",
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
          name: "content",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:content, 0)

  field(:coreContent, 1,
    optional: true,
    type: WAMsgApplication.MessageApplication.Content,
    oneof: 0
  )

  field(:signal, 2, optional: true, type: WAMsgApplication.MessageApplication.Signal, oneof: 0)

  field(:applicationData, 3,
    optional: true,
    type: WAMsgApplication.MessageApplication.ApplicationData,
    oneof: 0
  )

  field(:subProtocol, 4,
    optional: true,
    type: WAMsgApplication.MessageApplication.SubProtocolPayload,
    oneof: 0
  )
end

defmodule WAMsgApplication.MessageApplication.SubProtocolPayload do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgApplication.MessageApplication.SubProtocolPayload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SubProtocolPayload",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "consumerMessage",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "consumerMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "businessMessage",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "businessMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "paymentMessage",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "paymentMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "multiDevice",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "multiDevice",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "voip",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "voip",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "armadillo",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "armadillo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "futureProof",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WACommon.FutureProofBehavior",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "futureProof",
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
          name: "subProtocol",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:subProtocol, 0)

  field(:consumerMessage, 2, optional: true, type: WACommon.SubProtocol, oneof: 0)
  field(:businessMessage, 3, optional: true, type: WACommon.SubProtocol, oneof: 0)
  field(:paymentMessage, 4, optional: true, type: WACommon.SubProtocol, oneof: 0)
  field(:multiDevice, 5, optional: true, type: WACommon.SubProtocol, oneof: 0)
  field(:voip, 6, optional: true, type: WACommon.SubProtocol, oneof: 0)
  field(:armadillo, 7, optional: true, type: WACommon.SubProtocol, oneof: 0)
  field(:futureProof, 1, optional: true, type: WACommon.FutureProofBehavior, enum: true)
end

defmodule WAMsgApplication.MessageApplication.ApplicationData do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgApplication.MessageApplication.ApplicationData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ApplicationData",
      field: [],
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
end

defmodule WAMsgApplication.MessageApplication.Signal do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgApplication.MessageApplication.Signal",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Signal",
      field: [],
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
end

defmodule WAMsgApplication.MessageApplication.Content do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgApplication.MessageApplication.Content",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Content",
      field: [],
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
end

defmodule WAMsgApplication.MessageApplication.EphemeralSetting do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgApplication.MessageApplication.EphemeralSetting",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "EphemeralSetting",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralExpiration",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeralExpiration",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralSettingTimestamp",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeralSettingTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralityType",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAMsgApplication.MessageApplication.EphemeralSetting.EphemeralityType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeralityType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isEphemeralSettingReset",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isEphemeralSettingReset",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "EphemeralityType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SEEN_ONCE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SEEN_BASED_WITH_TIMER",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SEND_BASED_WITH_TIMER",
              number: 3,
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

  field(:ephemeralExpiration, 2, optional: true, type: :uint32)
  field(:ephemeralSettingTimestamp, 3, optional: true, type: :int64)

  field(:ephemeralityType, 5,
    optional: true,
    type: WAMsgApplication.MessageApplication.EphemeralSetting.EphemeralityType,
    enum: true
  )

  field(:isEphemeralSettingReset, 4, optional: true, type: :bool)
end

defmodule WAMsgApplication.MessageApplication do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgApplication.MessageApplication",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MessageApplication",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "payload",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgApplication.MessageApplication.Payload",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "payload",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "metadata",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgApplication.MessageApplication.Metadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "metadata",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Metadata",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "chatEphemeralSetting",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMsgApplication.MessageApplication.EphemeralSetting",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "chatEphemeralSetting",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "ephemeralSettingList",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMsgApplication.MessageApplication.Metadata.EphemeralSettingMap",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "ephemeralSettingList",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "ephemeralSharedSecret",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "ephemeralSharedSecret",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "forwardingScore",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "forwardingScore",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "isForwarded",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "isForwarded",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "businessMetadata",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "businessMetadata",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "frankingKey",
              extendee: nil,
              number: 8,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "frankingKey",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "frankingVersion",
              extendee: nil,
              number: 9,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "frankingVersion",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "quotedMessage",
              extendee: nil,
              number: 10,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMsgApplication.MessageApplication.Metadata.QuotedMessage",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "quotedMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "threadType",
              extendee: nil,
              number: 11,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAMsgApplication.MessageApplication.Metadata.ThreadType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "threadType",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "readonlyMetadataDataclass",
              extendee: nil,
              number: 12,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "readonlyMetadataDataclass",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "groupID",
              extendee: nil,
              number: 13,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "groupID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "groupSize",
              extendee: nil,
              number: 14,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "groupSize",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "groupIndex",
              extendee: nil,
              number: 15,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "groupIndex",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "botResponseID",
              extendee: nil,
              number: 16,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "botResponseID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "collapsibleID",
              extendee: nil,
              number: 17,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "collapsibleID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "secondaryOtid",
              extendee: nil,
              number: 18,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "secondaryOtid",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "QuotedMessage",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "stanzaID",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "stanzaID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "remoteJID",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "remoteJID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "participant",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "participant",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "payload",
                  extendee: nil,
                  number: 4,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WAMsgApplication.MessageApplication.Payload",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "payload",
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
            },
            %Google.Protobuf.DescriptorProto{
              name: "EphemeralSettingMap",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "chatJID",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "chatJID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "ephemeralSetting",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WAMsgApplication.MessageApplication.EphemeralSetting",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "ephemeralSetting",
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
          ],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "ThreadType",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "DEFAULT",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "VANISH_MODE",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "DISAPPEARING_MESSAGES",
                  number: 2,
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
          oneof_decl: [
            %Google.Protobuf.OneofDescriptorProto{
              name: "ephemeral",
              options: nil,
              __unknown_fields__: []
            }
          ],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "Payload",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "coreContent",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMsgApplication.MessageApplication.Content",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "coreContent",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "signal",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMsgApplication.MessageApplication.Signal",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "signal",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "applicationData",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMsgApplication.MessageApplication.ApplicationData",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "applicationData",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "subProtocol",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMsgApplication.MessageApplication.SubProtocolPayload",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "subProtocol",
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
              name: "content",
              options: nil,
              __unknown_fields__: []
            }
          ],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "SubProtocolPayload",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "consumerMessage",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "consumerMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "businessMessage",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "businessMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "paymentMessage",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "paymentMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "multiDevice",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "multiDevice",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "voip",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "voip",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "armadillo",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "armadillo",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "futureProof",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WACommon.FutureProofBehavior",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "futureProof",
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
              name: "subProtocol",
              options: nil,
              __unknown_fields__: []
            }
          ],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "ApplicationData",
          field: [],
          nested_type: [],
          enum_type: [],
          extension_range: [],
          extension: [],
          options: nil,
          oneof_decl: [],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "Signal",
          field: [],
          nested_type: [],
          enum_type: [],
          extension_range: [],
          extension: [],
          options: nil,
          oneof_decl: [],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "Content",
          field: [],
          nested_type: [],
          enum_type: [],
          extension_range: [],
          extension: [],
          options: nil,
          oneof_decl: [],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "EphemeralSetting",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "ephemeralExpiration",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "ephemeralExpiration",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "ephemeralSettingTimestamp",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "ephemeralSettingTimestamp",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "ephemeralityType",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAMsgApplication.MessageApplication.EphemeralSetting.EphemeralityType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "ephemeralityType",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "isEphemeralSettingReset",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "isEphemeralSettingReset",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "EphemeralityType",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UNKNOWN",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "SEEN_ONCE",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "SEEN_BASED_WITH_TIMER",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "SEND_BASED_WITH_TIMER",
                  number: 3,
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
      ],
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

  field(:payload, 1, optional: true, type: WAMsgApplication.MessageApplication.Payload)
  field(:metadata, 2, optional: true, type: WAMsgApplication.MessageApplication.Metadata)
end
