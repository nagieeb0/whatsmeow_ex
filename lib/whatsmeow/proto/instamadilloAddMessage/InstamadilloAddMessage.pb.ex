defmodule InstamadilloAddMessage.Placeholder.Type do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "InstamadilloAddMessage.Placeholder.Type",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Type",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PLACEHOLDER_TYPE_NONE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PLACEHOLDER_TYPE_DECRYPTION_FAILURE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PLACEHOLDER_TYPE_NOT_SUPPORTED_NEED_UPDATE",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PLACEHOLDER_TYPE_DEVICE_UNAVAILABLE",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PLACEHOLDER_TYPE_NOT_SUPPORTED_NOT_RECOVERABLE",
          number: 4,
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

  field(:PLACEHOLDER_TYPE_NONE, 0)
  field(:PLACEHOLDER_TYPE_DECRYPTION_FAILURE, 1)
  field(:PLACEHOLDER_TYPE_NOT_SUPPORTED_NEED_UPDATE, 2)
  field(:PLACEHOLDER_TYPE_DEVICE_UNAVAILABLE, 3)
  field(:PLACEHOLDER_TYPE_NOT_SUPPORTED_NOT_RECOVERABLE, 4)
end

defmodule InstamadilloAddMessage.AddMessagePayload do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloAddMessage.AddMessagePayload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AddMessagePayload",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "content",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloAddMessage.AddMessageContent",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "content",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "metadata",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloAddMessage.AddMessageMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "metadata",
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

  field(:content, 1, optional: true, type: InstamadilloAddMessage.AddMessageContent)
  field(:metadata, 2, optional: true, type: InstamadilloAddMessage.AddMessageMetadata)
end

defmodule InstamadilloAddMessage.AddMessageContent do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloAddMessage.AddMessageContent",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AddMessageContent",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "text",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeText.Text",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "text",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "like",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloAddMessage.Like",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "like",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "link",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeLink.Link",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "link",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "receiverFetchXma",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloAddMessage.ReceiverFetchXma",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "receiverFetchXma",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "media",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.Media",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "media",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "placeholder",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloAddMessage.Placeholder",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "placeholder",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "collection",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeCollection.Collection",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "collection",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "adminMessage",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeAdminMessage.AdminMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "adminMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "actionLog",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeActionLog.ActionLog",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "actionLog",
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
          name: "addMessageContent",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:addMessageContent, 0)

  field(:text, 1, optional: true, type: InstamadilloCoreTypeText.Text, oneof: 0)
  field(:like, 2, optional: true, type: InstamadilloAddMessage.Like, oneof: 0)
  field(:link, 3, optional: true, type: InstamadilloCoreTypeLink.Link, oneof: 0)

  field(:receiverFetchXma, 4,
    optional: true,
    type: InstamadilloAddMessage.ReceiverFetchXma,
    oneof: 0
  )

  field(:media, 5, optional: true, type: InstamadilloCoreTypeMedia.Media, oneof: 0)
  field(:placeholder, 6, optional: true, type: InstamadilloAddMessage.Placeholder, oneof: 0)
  field(:collection, 7, optional: true, type: InstamadilloCoreTypeCollection.Collection, oneof: 0)

  field(:adminMessage, 8,
    optional: true,
    type: InstamadilloCoreTypeAdminMessage.AdminMessage,
    oneof: 0
  )

  field(:actionLog, 9, optional: true, type: InstamadilloCoreTypeActionLog.ActionLog, oneof: 0)
end

defmodule InstamadilloAddMessage.AddMessageMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloAddMessage.AddMessageMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AddMessageMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "sendSilently",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sendSilently",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "privateReplyInfo",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloAddMessage.PrivateReplyInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "privateReplyInfo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "repliedToMessage",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloAddMessage.RepliedToMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "repliedToMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "forwardingParams",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloAddMessage.ForwardingParams",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "forwardingParams",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralityParams",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloAddMessage.EphemeralityParams",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeralityParams",
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

  field(:sendSilently, 1, optional: true, type: :bool)
  field(:privateReplyInfo, 2, optional: true, type: InstamadilloAddMessage.PrivateReplyInfo)
  field(:repliedToMessage, 3, optional: true, type: InstamadilloAddMessage.RepliedToMessage)
  field(:forwardingParams, 4, optional: true, type: InstamadilloAddMessage.ForwardingParams)
  field(:ephemeralityParams, 5, optional: true, type: InstamadilloAddMessage.EphemeralityParams)
end

defmodule InstamadilloAddMessage.RepliedToMessage do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloAddMessage.RepliedToMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "RepliedToMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "repliedToMessageOtid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "repliedToMessageOtid",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "repliedToMessageWaServerTimeSec",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "repliedToMessageWaServerTimeSec",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "repliedToMessageCollectionItemID",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "repliedToMessageCollectionItemID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "omMicroSecTS",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloAddMessage.OpenMessageMicroSecondTimestamp",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "omMicroSecTS",
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

  field(:repliedToMessageOtid, 1, optional: true, type: :string)
  field(:repliedToMessageWaServerTimeSec, 2, optional: true, type: :string)
  field(:repliedToMessageCollectionItemID, 3, optional: true, type: :string)

  field(:omMicroSecTS, 4,
    optional: true,
    type: InstamadilloAddMessage.OpenMessageMicroSecondTimestamp
  )
end

defmodule InstamadilloAddMessage.OpenMessageMicroSecondTimestamp do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloAddMessage.OpenMessageMicroSecondTimestamp",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "OpenMessageMicroSecondTimestamp",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "timestampMS",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "timestampMS",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "microSecondsBits",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "microSecondsBits",
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

  field(:timestampMS, 1, optional: true, type: :int64)
  field(:microSecondsBits, 2, optional: true, type: :int32)
end

defmodule InstamadilloAddMessage.PrivateReplyInfo do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloAddMessage.PrivateReplyInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PrivateReplyInfo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "commentID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "commentID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "postLink",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "postLink",
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

  field(:commentID, 1, optional: true, type: :string)
  field(:postLink, 2, optional: true, type: :string)
end

defmodule InstamadilloAddMessage.ForwardingParams do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloAddMessage.ForwardingParams",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ForwardingParams",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "forwardedThreadID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "forwardedThreadID",
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

  field(:forwardedThreadID, 1, optional: true, type: :string)
end

defmodule InstamadilloAddMessage.EphemeralityParams do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloAddMessage.EphemeralityParams",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "EphemeralityParams",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralDurationSec",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeralDurationSec",
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

  field(:ephemeralDurationSec, 1, optional: true, type: :int64)
end

defmodule InstamadilloAddMessage.Like do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloAddMessage.Like",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Like",
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

defmodule InstamadilloAddMessage.ReceiverFetchXma do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloAddMessage.ReceiverFetchXma",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ReceiverFetchXma",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "contentRef",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "contentRef",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "text",
          extendee: nil,
          number: 2,
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
          name: "media",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.Media",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "media",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmaContentRef",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloXmaContentRef.XmaContentRef",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "xmaContentRef",
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

  field(:contentRef, 1, optional: true, type: :string)
  field(:text, 2, optional: true, type: :string)
  field(:media, 3, optional: true, type: InstamadilloCoreTypeMedia.Media)
  field(:xmaContentRef, 4, optional: true, type: InstamadilloXmaContentRef.XmaContentRef)
end

defmodule InstamadilloAddMessage.Placeholder do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloAddMessage.Placeholder",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Placeholder",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "placeholderType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".InstamadilloAddMessage.Placeholder.Type",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "placeholderType",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "Type",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PLACEHOLDER_TYPE_NONE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PLACEHOLDER_TYPE_DECRYPTION_FAILURE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PLACEHOLDER_TYPE_NOT_SUPPORTED_NEED_UPDATE",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PLACEHOLDER_TYPE_DEVICE_UNAVAILABLE",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PLACEHOLDER_TYPE_NOT_SUPPORTED_NOT_RECOVERABLE",
              number: 4,
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

  field(:placeholderType, 1,
    optional: true,
    type: InstamadilloAddMessage.Placeholder.Type,
    enum: true
  )
end
