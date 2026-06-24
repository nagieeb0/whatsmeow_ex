defmodule WAWebProtobufLidMigrationSyncPayload.LIDMigrationMapping do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufLidMigrationSyncPayload.LIDMigrationMapping",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "LIDMigrationMapping",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "pn",
          extendee: nil,
          number: 1,
          label: :LABEL_REQUIRED,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pn",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "assignedLid",
          extendee: nil,
          number: 2,
          label: :LABEL_REQUIRED,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "assignedLid",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "latestLid",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "latestLid",
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

  field(:pn, 1, required: true, type: :uint64)
  field(:assignedLid, 2, required: true, type: :uint64)
  field(:latestLid, 3, optional: true, type: :uint64)
end

defmodule WAWebProtobufLidMigrationSyncPayload.LIDMigrationMappingSyncPayload do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufLidMigrationSyncPayload.LIDMigrationMappingSyncPayload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "LIDMigrationMappingSyncPayload",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "pnToLidMappings",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufLidMigrationSyncPayload.LIDMigrationMapping",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pnToLidMappings",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatDbMigrationTimestamp",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "chatDbMigrationTimestamp",
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

  field(:pnToLidMappings, 1,
    repeated: true,
    type: WAWebProtobufLidMigrationSyncPayload.LIDMigrationMapping
  )

  field(:chatDbMigrationTimestamp, 2, optional: true, type: :uint64)
end
