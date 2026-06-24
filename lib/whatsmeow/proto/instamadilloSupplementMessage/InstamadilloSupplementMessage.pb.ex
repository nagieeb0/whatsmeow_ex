defmodule InstamadilloSupplementMessage.SupplementMessagePayload do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloSupplementMessage.SupplementMessagePayload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SupplementMessagePayload",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "targetMessageOtid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "targetMessageOtid",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "uniquingKeyForSupplementalData",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "uniquingKeyForSupplementalData",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "content",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloSupplementMessage.SupplementMessageContent",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "content",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "targetMessageWaServerTimeSec",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "targetMessageWaServerTimeSec",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "targetWaThreadID",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "targetWaThreadID",
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

  field(:targetMessageOtid, 1, optional: true, type: :string)
  field(:uniquingKeyForSupplementalData, 2, optional: true, type: :string)
  field(:content, 3, optional: true, type: InstamadilloSupplementMessage.SupplementMessageContent)
  field(:targetMessageWaServerTimeSec, 4, optional: true, type: :string)
  field(:targetWaThreadID, 5, optional: true, type: :string)
end

defmodule InstamadilloSupplementMessage.SupplementMessageContent do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloSupplementMessage.SupplementMessageContent",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SupplementMessageContent",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "reaction",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloSupplementMessage.Reaction",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "reaction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "contentView",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloSupplementMessage.ContentView",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "contentView",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "editText",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloSupplementMessage.EditText",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "editText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaReaction",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloSupplementMessage.MediaReaction",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "mediaReaction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "originalTransportPayload",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloSupplementMessage.OriginalTransportPayload",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "originalTransportPayload",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaInterventions",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloSupplementMessage.MediaInterventions",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "mediaInterventions",
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
          name: "supplementMessageContent",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:supplementMessageContent, 0)

  field(:reaction, 1, optional: true, type: InstamadilloSupplementMessage.Reaction, oneof: 0)
  field(:contentView, 2, optional: true, type: InstamadilloSupplementMessage.ContentView, oneof: 0)
  field(:editText, 3, optional: true, type: InstamadilloSupplementMessage.EditText, oneof: 0)

  field(:mediaReaction, 4,
    optional: true,
    type: InstamadilloSupplementMessage.MediaReaction,
    oneof: 0
  )

  field(:originalTransportPayload, 5,
    optional: true,
    type: InstamadilloSupplementMessage.OriginalTransportPayload,
    oneof: 0
  )

  field(:mediaInterventions, 6,
    optional: true,
    type: InstamadilloSupplementMessage.MediaInterventions,
    oneof: 0
  )
end

defmodule InstamadilloSupplementMessage.MediaReaction do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloSupplementMessage.MediaReaction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MediaReaction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "reaction",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloSupplementMessage.Reaction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "reaction",
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

  field(:mediaID, 1, optional: true, type: :string)
  field(:reaction, 2, optional: true, type: InstamadilloSupplementMessage.Reaction)
end

defmodule InstamadilloSupplementMessage.Reaction do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloSupplementMessage.Reaction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Reaction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "reactionType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "reactionType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "reactionStatus",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "reactionStatus",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "emoji",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "emoji",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "superReactType",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "superReactType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "actionLogOtid",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "actionLogOtid",
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

  field(:reactionType, 1, optional: true, type: :string)
  field(:reactionStatus, 2, optional: true, type: :string)
  field(:emoji, 3, optional: true, type: :string)
  field(:superReactType, 4, optional: true, type: :string)
  field(:actionLogOtid, 5, optional: true, type: :string)
end

defmodule InstamadilloSupplementMessage.ContentView do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloSupplementMessage.ContentView",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ContentView",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "seen",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "seen",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "screenshotted",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "screenshotted",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "replayed",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "replayed",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mimetype",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mimetype",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "objectID",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "objectID",
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

  field(:seen, 1, optional: true, type: :bool)
  field(:screenshotted, 2, optional: true, type: :bool)
  field(:replayed, 3, optional: true, type: :bool)
  field(:mimetype, 4, optional: true, type: :string)
  field(:objectID, 5, optional: true, type: :string)
end

defmodule InstamadilloSupplementMessage.EditText do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloSupplementMessage.EditText",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "EditText",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "newContent",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "newContent",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "editCount",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "editCount",
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

  field(:newContent, 1, optional: true, type: :string)
  field(:editCount, 2, optional: true, type: :int32)
end

defmodule InstamadilloSupplementMessage.OriginalTransportPayload do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloSupplementMessage.OriginalTransportPayload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "OriginalTransportPayload",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "originalTransportPayload",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "originalTransportPayload",
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

  field(:originalTransportPayload, 1, optional: true, type: :bytes)
end

defmodule InstamadilloSupplementMessage.MediaInterventions do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloSupplementMessage.MediaInterventions",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MediaInterventions",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "interventionType",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".InstamadilloCoreTypeMedia.Media.InterventionType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "interventionType",
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

  field(:mediaID, 1, optional: true, type: :string)

  field(:interventionType, 2,
    optional: true,
    type: InstamadilloCoreTypeMedia.Media.InterventionType,
    enum: true
  )
end
