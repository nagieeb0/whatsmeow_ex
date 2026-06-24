defmodule InstamadilloTransportPayload.PayloadCreator do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "InstamadilloTransportPayload.PayloadCreator",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "PayloadCreator",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYLOAD_CREATOR_UNSPECIFIED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYLOAD_CREATOR_IGIOS",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYLOAD_CREATOR_IG4A",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYLOAD_CREATOR_WWW",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYLOAD_CREATOR_IGLITE",
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

  field(:PAYLOAD_CREATOR_UNSPECIFIED, 0)
  field(:PAYLOAD_CREATOR_IGIOS, 1)
  field(:PAYLOAD_CREATOR_IG4A, 2)
  field(:PAYLOAD_CREATOR_WWW, 3)
  field(:PAYLOAD_CREATOR_IGLITE, 4)
end

defmodule InstamadilloTransportPayload.TransportPayload do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloTransportPayload.TransportPayload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "TransportPayload",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "add",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloAddMessage.AddMessagePayload",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "add",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "delete",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloDeleteMessage.DeleteMessagePayload",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "delete",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "supplement",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloSupplementMessage.SupplementMessagePayload",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "supplement",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "franking",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloTransportPayload.Franking",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "franking",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "openEb",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "openEb",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isE2EeAttributed",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isE2EeAttributed",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "payloadCreator",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".InstamadilloTransportPayload.PayloadCreator",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "payloadCreator",
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
          name: "transportPayload",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:transportPayload, 0)

  field(:add, 1, optional: true, type: InstamadilloAddMessage.AddMessagePayload, oneof: 0)
  field(:delete, 2, optional: true, type: InstamadilloDeleteMessage.DeleteMessagePayload, oneof: 0)

  field(:supplement, 3,
    optional: true,
    type: InstamadilloSupplementMessage.SupplementMessagePayload,
    oneof: 0
  )

  field(:franking, 4, optional: true, type: InstamadilloTransportPayload.Franking)
  field(:openEb, 5, optional: true, type: :bool)
  field(:isE2EeAttributed, 6, optional: true, type: :bool)

  field(:payloadCreator, 7,
    optional: true,
    type: InstamadilloTransportPayload.PayloadCreator,
    enum: true
  )
end

defmodule InstamadilloTransportPayload.Franking do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloTransportPayload.Franking",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Franking",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "frankingKey",
          extendee: nil,
          number: 1,
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
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "frankingVersion",
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

  field(:frankingKey, 1, optional: true, type: :bytes)
  field(:frankingVersion, 2, optional: true, type: :int32)
end
