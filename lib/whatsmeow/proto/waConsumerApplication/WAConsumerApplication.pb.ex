defmodule WAConsumerApplication.ConsumerApplication.Metadata.SpecialTextSize do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAConsumerApplication.ConsumerApplication.Metadata.SpecialTextSize",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "SpecialTextSize",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SMALL",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MEDIUM",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LARGE",
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

  field(:SMALL, 1)
  field(:MEDIUM, 2)
  field(:LARGE, 3)
end

defmodule WAConsumerApplication.ConsumerApplication.StatusTextMesage.FontType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAConsumerApplication.ConsumerApplication.StatusTextMesage.FontType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "FontType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SANS_SERIF",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SERIF",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NORICAN_REGULAR",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BRYNDAN_WRITE",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BEBASNEUE_REGULAR",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "OSWALD_HEAVY",
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

  field(:SANS_SERIF, 0)
  field(:SERIF, 1)
  field(:NORICAN_REGULAR, 2)
  field(:BRYNDAN_WRITE, 3)
  field(:BEBASNEUE_REGULAR, 4)
  field(:OSWALD_HEAVY, 5)
end

defmodule WAConsumerApplication.ConsumerApplication.ExtendedTextMessage.PreviewType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAConsumerApplication.ConsumerApplication.ExtendedTextMessage.PreviewType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "PreviewType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NONE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VIDEO",
          number: 1,
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

  field(:NONE, 0)
  field(:VIDEO, 1)
end

defmodule WAConsumerApplication.ConsumerApplication.Payload do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.Payload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Payload",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "content",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.Content",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "content",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "applicationData",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.ApplicationData",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "applicationData",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "signal",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.Signal",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "signal",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "subProtocol",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.SubProtocolPayload",
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
          name: "payload",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:payload, 0)

  field(:content, 1,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.Content,
    oneof: 0
  )

  field(:applicationData, 2,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.ApplicationData,
    oneof: 0
  )

  field(:signal, 3,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.Signal,
    oneof: 0
  )

  field(:subProtocol, 4,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.SubProtocolPayload,
    oneof: 0
  )
end

defmodule WAConsumerApplication.ConsumerApplication.SubProtocolPayload do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.SubProtocolPayload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SubProtocolPayload",
      field: [
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
      oneof_decl: [],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  field(:futureProof, 1, optional: true, type: WACommon.FutureProofBehavior, enum: true)
end

defmodule WAConsumerApplication.ConsumerApplication.Metadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.Metadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Metadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "specialTextSize",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAConsumerApplication.ConsumerApplication.Metadata.SpecialTextSize",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "specialTextSize",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "SpecialTextSize",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SMALL",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MEDIUM",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "LARGE",
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

  field(:specialTextSize, 1,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.Metadata.SpecialTextSize,
    enum: true
  )
end

defmodule WAConsumerApplication.ConsumerApplication.Signal do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.Signal",
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

defmodule WAConsumerApplication.ConsumerApplication.ApplicationData do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.ApplicationData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ApplicationData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "revoke",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.RevokeMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "revoke",
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
          name: "applicationContent",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:applicationContent, 0)

  field(:revoke, 1,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.RevokeMessage,
    oneof: 0
  )
end

defmodule WAConsumerApplication.ConsumerApplication.Content do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.Content",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Content",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageText",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageText",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "messageText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "imageMessage",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.ImageMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "imageMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "contactMessage",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.ContactMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "contactMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "locationMessage",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.LocationMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "locationMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "extendedTextMessage",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.ExtendedTextMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "extendedTextMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "statusTextMessage",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.StatusTextMesage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "statusTextMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "documentMessage",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.DocumentMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "documentMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "audioMessage",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.AudioMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "audioMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "videoMessage",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.VideoMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "videoMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "contactsArrayMessage",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.ContactsArrayMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "contactsArrayMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "liveLocationMessage",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.LiveLocationMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "liveLocationMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "stickerMessage",
          extendee: nil,
          number: 12,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.StickerMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "stickerMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupInviteMessage",
          extendee: nil,
          number: 13,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.GroupInviteMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "groupInviteMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "viewOnceMessage",
          extendee: nil,
          number: 14,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.ViewOnceMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "viewOnceMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "reactionMessage",
          extendee: nil,
          number: 16,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.ReactionMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "reactionMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pollCreationMessage",
          extendee: nil,
          number: 17,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.PollCreationMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "pollCreationMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pollUpdateMessage",
          extendee: nil,
          number: 18,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.PollUpdateMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "pollUpdateMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "editMessage",
          extendee: nil,
          number: 19,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.EditMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "editMessage",
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

  field(:messageText, 1, optional: true, type: WACommon.MessageText, oneof: 0)

  field(:imageMessage, 2,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.ImageMessage,
    oneof: 0
  )

  field(:contactMessage, 3,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.ContactMessage,
    oneof: 0
  )

  field(:locationMessage, 4,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.LocationMessage,
    oneof: 0
  )

  field(:extendedTextMessage, 5,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.ExtendedTextMessage,
    oneof: 0
  )

  field(:statusTextMessage, 6,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.StatusTextMesage,
    oneof: 0
  )

  field(:documentMessage, 7,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.DocumentMessage,
    oneof: 0
  )

  field(:audioMessage, 8,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.AudioMessage,
    oneof: 0
  )

  field(:videoMessage, 9,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.VideoMessage,
    oneof: 0
  )

  field(:contactsArrayMessage, 10,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.ContactsArrayMessage,
    oneof: 0
  )

  field(:liveLocationMessage, 11,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.LiveLocationMessage,
    oneof: 0
  )

  field(:stickerMessage, 12,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.StickerMessage,
    oneof: 0
  )

  field(:groupInviteMessage, 13,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.GroupInviteMessage,
    oneof: 0
  )

  field(:viewOnceMessage, 14,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.ViewOnceMessage,
    oneof: 0
  )

  field(:reactionMessage, 16,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.ReactionMessage,
    oneof: 0
  )

  field(:pollCreationMessage, 17,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.PollCreationMessage,
    oneof: 0
  )

  field(:pollUpdateMessage, 18,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.PollUpdateMessage,
    oneof: 0
  )

  field(:editMessage, 19,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.EditMessage,
    oneof: 0
  )
end

defmodule WAConsumerApplication.ConsumerApplication.EditMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.EditMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "EditMessage",
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
          name: "message",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageText",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "message",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "timestampMS",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "timestampMS",
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
  field(:message, 2, optional: true, type: WACommon.MessageText)
  field(:timestampMS, 3, optional: true, type: :int64)
end

defmodule WAConsumerApplication.ConsumerApplication.PollAddOptionMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.PollAddOptionMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PollAddOptionMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "pollOption",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.Option",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pollOption",
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

  field(:pollOption, 1, repeated: true, type: WAConsumerApplication.ConsumerApplication.Option)
end

defmodule WAConsumerApplication.ConsumerApplication.PollVoteMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.PollVoteMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PollVoteMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "selectedOptions",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "selectedOptions",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "senderTimestampMS",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "senderTimestampMS",
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

  field(:selectedOptions, 1, repeated: true, type: :bytes)
  field(:senderTimestampMS, 2, optional: true, type: :int64)
end

defmodule WAConsumerApplication.ConsumerApplication.PollEncValue do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.PollEncValue",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PollEncValue",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "encPayload",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "encPayload",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "encIV",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "encIV",
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

  field(:encPayload, 1, optional: true, type: :bytes)
  field(:encIV, 2, optional: true, type: :bytes)
end

defmodule WAConsumerApplication.ConsumerApplication.PollUpdateMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.PollUpdateMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PollUpdateMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "pollCreationMessageKey",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pollCreationMessageKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "vote",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.PollEncValue",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "vote",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "addOption",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.PollEncValue",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "addOption",
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

  field(:pollCreationMessageKey, 1, optional: true, type: WACommon.MessageKey)
  field(:vote, 2, optional: true, type: WAConsumerApplication.ConsumerApplication.PollEncValue)

  field(:addOption, 3,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.PollEncValue
  )
end

defmodule WAConsumerApplication.ConsumerApplication.PollCreationMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.PollCreationMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PollCreationMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "encKey",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "encKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "name",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "name",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "options",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.Option",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "options",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "selectableOptionsCount",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "selectableOptionsCount",
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

  field(:encKey, 1, optional: true, type: :bytes)
  field(:name, 2, optional: true, type: :string)
  field(:options, 3, repeated: true, type: WAConsumerApplication.ConsumerApplication.Option)
  field(:selectableOptionsCount, 4, optional: true, type: :uint32)
end

defmodule WAConsumerApplication.ConsumerApplication.Option do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.Option",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Option",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "optionName",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "optionName",
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

  field(:optionName, 1, optional: true, type: :string)
end

defmodule WAConsumerApplication.ConsumerApplication.ReactionMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.ReactionMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ReactionMessage",
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
          name: "groupingKey",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "groupingKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "senderTimestampMS",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "senderTimestampMS",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "reactionMetadataDataclassData",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "reactionMetadataDataclassData",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "style",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
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

  field(:key, 1, optional: true, type: WACommon.MessageKey)
  field(:text, 2, optional: true, type: :string)
  field(:groupingKey, 3, optional: true, type: :string)
  field(:senderTimestampMS, 4, optional: true, type: :int64)
  field(:reactionMetadataDataclassData, 5, optional: true, type: :string)
  field(:style, 6, optional: true, type: :int32)
end

defmodule WAConsumerApplication.ConsumerApplication.RevokeMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.RevokeMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "RevokeMessage",
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
end

defmodule WAConsumerApplication.ConsumerApplication.ViewOnceMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.ViewOnceMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ViewOnceMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "imageMessage",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.ImageMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "imageMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "videoMessage",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.VideoMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "videoMessage",
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
          name: "viewOnceContent",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:viewOnceContent, 0)

  field(:imageMessage, 1,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.ImageMessage,
    oneof: 0
  )

  field(:videoMessage, 2,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.VideoMessage,
    oneof: 0
  )
end

defmodule WAConsumerApplication.ConsumerApplication.GroupInviteMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.GroupInviteMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "GroupInviteMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupJID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "groupJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "inviteCode",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "inviteCode",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "inviteExpiration",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "inviteExpiration",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupName",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "groupName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "JPEGThumbnail",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "JPEGThumbnail",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "caption",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageText",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "caption",
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

  field(:groupJID, 1, optional: true, type: :string)
  field(:inviteCode, 2, optional: true, type: :string)
  field(:inviteExpiration, 3, optional: true, type: :int64)
  field(:groupName, 4, optional: true, type: :string)
  field(:JPEGThumbnail, 5, optional: true, type: :bytes)
  field(:caption, 6, optional: true, type: WACommon.MessageText)
end

defmodule WAConsumerApplication.ConsumerApplication.LiveLocationMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.LiveLocationMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "LiveLocationMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "location",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.Location",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "location",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "accuracyInMeters",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "accuracyInMeters",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "speedInMps",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_FLOAT,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "speedInMps",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "degreesClockwiseFromMagneticNorth",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "degreesClockwiseFromMagneticNorth",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "caption",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageText",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "caption",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sequenceNumber",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sequenceNumber",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "timeOffset",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "timeOffset",
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

  field(:location, 1, optional: true, type: WAConsumerApplication.ConsumerApplication.Location)
  field(:accuracyInMeters, 2, optional: true, type: :uint32)
  field(:speedInMps, 3, optional: true, type: :float)
  field(:degreesClockwiseFromMagneticNorth, 4, optional: true, type: :uint32)
  field(:caption, 5, optional: true, type: WACommon.MessageText)
  field(:sequenceNumber, 6, optional: true, type: :int64)
  field(:timeOffset, 7, optional: true, type: :uint32)
end

defmodule WAConsumerApplication.ConsumerApplication.ContactsArrayMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.ContactsArrayMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ContactsArrayMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "displayName",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "displayName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "contacts",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.ContactMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "contacts",
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

  field(:displayName, 1, optional: true, type: :string)

  field(:contacts, 2,
    repeated: true,
    type: WAConsumerApplication.ConsumerApplication.ContactMessage
  )
end

defmodule WAConsumerApplication.ConsumerApplication.ContactMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.ContactMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ContactMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "contact",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "contact",
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

  field(:contact, 1, optional: true, type: WACommon.SubProtocol)
end

defmodule WAConsumerApplication.ConsumerApplication.StatusTextMesage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.StatusTextMesage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "StatusTextMesage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "text",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.ExtendedTextMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "text",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "textArgb",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_FIXED32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "textArgb",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "backgroundArgb",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_FIXED32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "backgroundArgb",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "font",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAConsumerApplication.ConsumerApplication.StatusTextMesage.FontType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "font",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "FontType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SANS_SERIF",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SERIF",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NORICAN_REGULAR",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BRYNDAN_WRITE",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BEBASNEUE_REGULAR",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "OSWALD_HEAVY",
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

  field(:text, 1,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.ExtendedTextMessage
  )

  field(:textArgb, 6, optional: true, type: :fixed32)
  field(:backgroundArgb, 7, optional: true, type: :fixed32)

  field(:font, 8,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.StatusTextMesage.FontType,
    enum: true
  )
end

defmodule WAConsumerApplication.ConsumerApplication.ExtendedTextMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.ExtendedTextMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ExtendedTextMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "text",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageText",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "text",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "matchedText",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "matchedText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "canonicalURL",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "canonicalURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "description",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "description",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "title",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "title",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "thumbnail",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "thumbnail",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "previewType",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAConsumerApplication.ConsumerApplication.ExtendedTextMessage.PreviewType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "previewType",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "PreviewType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NONE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VIDEO",
              number: 1,
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

  field(:text, 1, optional: true, type: WACommon.MessageText)
  field(:matchedText, 2, optional: true, type: :string)
  field(:canonicalURL, 3, optional: true, type: :string)
  field(:description, 4, optional: true, type: :string)
  field(:title, 5, optional: true, type: :string)
  field(:thumbnail, 6, optional: true, type: WACommon.SubProtocol)

  field(:previewType, 7,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.ExtendedTextMessage.PreviewType,
    enum: true
  )
end

defmodule WAConsumerApplication.ConsumerApplication.LocationMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.LocationMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "LocationMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "location",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.Location",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "location",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "address",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "address",
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

  field(:location, 1, optional: true, type: WAConsumerApplication.ConsumerApplication.Location)
  field(:address, 2, optional: true, type: :string)
end

defmodule WAConsumerApplication.ConsumerApplication.StickerMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.StickerMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "StickerMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "sticker",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sticker",
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

  field(:sticker, 1, optional: true, type: WACommon.SubProtocol)
end

defmodule WAConsumerApplication.ConsumerApplication.DocumentMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.DocumentMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "DocumentMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "document",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "document",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fileName",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fileName",
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

  field(:document, 1, optional: true, type: WACommon.SubProtocol)
  field(:fileName, 2, optional: true, type: :string)
end

defmodule WAConsumerApplication.ConsumerApplication.VideoMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.VideoMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "VideoMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "video",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "video",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "caption",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageText",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "caption",
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

  field(:video, 1, optional: true, type: WACommon.SubProtocol)
  field(:caption, 2, optional: true, type: WACommon.MessageText)
end

defmodule WAConsumerApplication.ConsumerApplication.AudioMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.AudioMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AudioMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "audio",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "audio",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "PTT",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "PTT",
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

  field(:audio, 1, optional: true, type: WACommon.SubProtocol)
  field(:PTT, 2, optional: true, type: :bool)
end

defmodule WAConsumerApplication.ConsumerApplication.ImageMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.ImageMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ImageMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "image",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "image",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "caption",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageText",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "caption",
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

  field(:image, 1, optional: true, type: WACommon.SubProtocol)
  field(:caption, 2, optional: true, type: WACommon.MessageText)
end

defmodule WAConsumerApplication.ConsumerApplication.InteractiveAnnotation do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.InteractiveAnnotation",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "InteractiveAnnotation",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "location",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.Location",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "location",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "polygonVertices",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.Point",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "polygonVertices",
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
          name: "action",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:action, 0)

  field(:location, 2,
    optional: true,
    type: WAConsumerApplication.ConsumerApplication.Location,
    oneof: 0
  )

  field(:polygonVertices, 1, repeated: true, type: WAConsumerApplication.ConsumerApplication.Point)
end

defmodule WAConsumerApplication.ConsumerApplication.Point do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.Point",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Point",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "x",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "x",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "y",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "y",
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

  field(:x, 1, optional: true, type: :double)
  field(:y, 2, optional: true, type: :double)
end

defmodule WAConsumerApplication.ConsumerApplication.Location do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.Location",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Location",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "degreesLatitude",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "degreesLatitude",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "degreesLongitude",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "degreesLongitude",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "name",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "name",
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

  field(:degreesLatitude, 1, optional: true, type: :double)
  field(:degreesLongitude, 2, optional: true, type: :double)
  field(:name, 3, optional: true, type: :string)
end

defmodule WAConsumerApplication.ConsumerApplication.MediaPayload do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication.MediaPayload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MediaPayload",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "protocol",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "protocol",
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

  field(:protocol, 1, optional: true, type: WACommon.SubProtocol)
end

defmodule WAConsumerApplication.ConsumerApplication do
  @moduledoc false

  use Protobuf,
    full_name: "WAConsumerApplication.ConsumerApplication",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ConsumerApplication",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "payload",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAConsumerApplication.ConsumerApplication.Payload",
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
          type_name: ".WAConsumerApplication.ConsumerApplication.Metadata",
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
          name: "Payload",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "content",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.Content",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "content",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "applicationData",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.ApplicationData",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "applicationData",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "signal",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.Signal",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "signal",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "subProtocol",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.SubProtocolPayload",
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
              name: "payload",
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
          oneof_decl: [],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "Metadata",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "specialTextSize",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAConsumerApplication.ConsumerApplication.Metadata.SpecialTextSize",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "specialTextSize",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "SpecialTextSize",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "SMALL",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "MEDIUM",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "LARGE",
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
          name: "ApplicationData",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "revoke",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.RevokeMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "revoke",
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
              name: "applicationContent",
              options: nil,
              __unknown_fields__: []
            }
          ],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "Content",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "messageText",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.MessageText",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "messageText",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "imageMessage",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.ImageMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "imageMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "contactMessage",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.ContactMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "contactMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "locationMessage",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.LocationMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "locationMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "extendedTextMessage",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.ExtendedTextMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "extendedTextMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "statusTextMessage",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.StatusTextMesage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "statusTextMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "documentMessage",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.DocumentMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "documentMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "audioMessage",
              extendee: nil,
              number: 8,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.AudioMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "audioMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "videoMessage",
              extendee: nil,
              number: 9,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.VideoMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "videoMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "contactsArrayMessage",
              extendee: nil,
              number: 10,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.ContactsArrayMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "contactsArrayMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "liveLocationMessage",
              extendee: nil,
              number: 11,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.LiveLocationMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "liveLocationMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "stickerMessage",
              extendee: nil,
              number: 12,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.StickerMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "stickerMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "groupInviteMessage",
              extendee: nil,
              number: 13,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.GroupInviteMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "groupInviteMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "viewOnceMessage",
              extendee: nil,
              number: 14,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.ViewOnceMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "viewOnceMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "reactionMessage",
              extendee: nil,
              number: 16,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.ReactionMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "reactionMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "pollCreationMessage",
              extendee: nil,
              number: 17,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.PollCreationMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "pollCreationMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "pollUpdateMessage",
              extendee: nil,
              number: 18,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.PollUpdateMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "pollUpdateMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "editMessage",
              extendee: nil,
              number: 19,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.EditMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "editMessage",
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
          name: "EditMessage",
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
              name: "message",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.MessageText",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "message",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "timestampMS",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "timestampMS",
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
          name: "PollAddOptionMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "pollOption",
              extendee: nil,
              number: 1,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.Option",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "pollOption",
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
          name: "PollVoteMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "selectedOptions",
              extendee: nil,
              number: 1,
              label: :LABEL_REPEATED,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "selectedOptions",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "senderTimestampMS",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "senderTimestampMS",
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
          name: "PollEncValue",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "encPayload",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "encPayload",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "encIV",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "encIV",
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
          name: "PollUpdateMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "pollCreationMessageKey",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.MessageKey",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "pollCreationMessageKey",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "vote",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.PollEncValue",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "vote",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "addOption",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.PollEncValue",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "addOption",
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
          name: "PollCreationMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "encKey",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "encKey",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "name",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "name",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "options",
              extendee: nil,
              number: 3,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.Option",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "options",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "selectableOptionsCount",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "selectableOptionsCount",
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
          name: "Option",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "optionName",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "optionName",
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
          name: "ReactionMessage",
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
              name: "groupingKey",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "groupingKey",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "senderTimestampMS",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "senderTimestampMS",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "reactionMetadataDataclassData",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "reactionMetadataDataclassData",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "style",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT32,
              type_name: nil,
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
        },
        %Google.Protobuf.DescriptorProto{
          name: "RevokeMessage",
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
          name: "ViewOnceMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "imageMessage",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.ImageMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "imageMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "videoMessage",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.VideoMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "videoMessage",
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
              name: "viewOnceContent",
              options: nil,
              __unknown_fields__: []
            }
          ],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "GroupInviteMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "groupJID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "groupJID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "inviteCode",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "inviteCode",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "inviteExpiration",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "inviteExpiration",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "groupName",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "groupName",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "JPEGThumbnail",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "JPEGThumbnail",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "caption",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.MessageText",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "caption",
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
          name: "LiveLocationMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "location",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.Location",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "location",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "accuracyInMeters",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "accuracyInMeters",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "speedInMps",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_FLOAT,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "speedInMps",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "degreesClockwiseFromMagneticNorth",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "degreesClockwiseFromMagneticNorth",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "caption",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.MessageText",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "caption",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "sequenceNumber",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sequenceNumber",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "timeOffset",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "timeOffset",
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
          name: "ContactsArrayMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "displayName",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "displayName",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "contacts",
              extendee: nil,
              number: 2,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.ContactMessage",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "contacts",
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
          name: "ContactMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "contact",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "contact",
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
          name: "StatusTextMesage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "text",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.ExtendedTextMessage",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "text",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "textArgb",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_FIXED32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "textArgb",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "backgroundArgb",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_FIXED32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "backgroundArgb",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "font",
              extendee: nil,
              number: 8,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAConsumerApplication.ConsumerApplication.StatusTextMesage.FontType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "font",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "FontType",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "SANS_SERIF",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "SERIF",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "NORICAN_REGULAR",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "BRYNDAN_WRITE",
                  number: 3,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "BEBASNEUE_REGULAR",
                  number: 4,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "OSWALD_HEAVY",
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
        },
        %Google.Protobuf.DescriptorProto{
          name: "ExtendedTextMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "text",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.MessageText",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "text",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "matchedText",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "matchedText",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "canonicalURL",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "canonicalURL",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "description",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "description",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "title",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "title",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "thumbnail",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "thumbnail",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "previewType",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAConsumerApplication.ConsumerApplication.ExtendedTextMessage.PreviewType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "previewType",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "PreviewType",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "NONE",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "VIDEO",
                  number: 1,
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
        },
        %Google.Protobuf.DescriptorProto{
          name: "LocationMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "location",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.Location",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "location",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "address",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "address",
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
          name: "StickerMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "sticker",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sticker",
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
          name: "DocumentMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "document",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "document",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "fileName",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "fileName",
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
          name: "VideoMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "video",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "video",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "caption",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.MessageText",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "caption",
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
          name: "AudioMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "audio",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "audio",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "PTT",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "PTT",
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
          name: "ImageMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "image",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "image",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "caption",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.MessageText",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "caption",
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
          name: "InteractiveAnnotation",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "location",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.Location",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "location",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "polygonVertices",
              extendee: nil,
              number: 1,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name: ".WAConsumerApplication.ConsumerApplication.Point",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "polygonVertices",
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
              name: "action",
              options: nil,
              __unknown_fields__: []
            }
          ],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "Point",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "x",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_DOUBLE,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "x",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "y",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_DOUBLE,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "y",
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
          name: "Location",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "degreesLatitude",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_DOUBLE,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "degreesLatitude",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "degreesLongitude",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_DOUBLE,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "degreesLongitude",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "name",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "name",
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
          name: "MediaPayload",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "protocol",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "protocol",
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

  field(:payload, 1, optional: true, type: WAConsumerApplication.ConsumerApplication.Payload)
  field(:metadata, 2, optional: true, type: WAConsumerApplication.ConsumerApplication.Metadata)
end
