defmodule WAArmadilloBackupMessage.BackupMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloBackupMessage.BackupMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BackupMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "encryptedTransportMessage",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "encryptedTransportMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "encryptedTransportEvent",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloBackupCommon.Subprotocol",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "encryptedTransportEvent",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "encryptedTransportLocallyTransformedMessage",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloBackupCommon.Subprotocol",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "encryptedTransportLocallyTransformedMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "miTransportAdminMessage",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloBackupCommon.Subprotocol",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "miTransportAdminMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "metadata",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloBackupCommon.Metadata",
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

  field(:encryptedTransportMessage, 2, optional: true, type: :bytes, oneof: 0)

  field(:encryptedTransportEvent, 5,
    optional: true,
    type: WAArmadilloBackupCommon.Subprotocol,
    oneof: 0
  )

  field(:encryptedTransportLocallyTransformedMessage, 6,
    optional: true,
    type: WAArmadilloBackupCommon.Subprotocol,
    oneof: 0
  )

  field(:miTransportAdminMessage, 7,
    optional: true,
    type: WAArmadilloBackupCommon.Subprotocol,
    oneof: 0
  )

  field(:metadata, 1, optional: true, type: WAArmadilloBackupCommon.Metadata)
end
