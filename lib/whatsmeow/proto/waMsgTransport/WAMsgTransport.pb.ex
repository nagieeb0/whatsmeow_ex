defmodule WAMsgTransport.MessageTransport.Protocol.Ancillary.BackupDirective.ActionType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAMsgTransport.MessageTransport.Protocol.Ancillary.BackupDirective.ActionType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ActionType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NOOP",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UPSERT",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DELETE",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UPSERT_AND_DELETE",
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

  field(:NOOP, 0)
  field(:UPSERT, 1)
  field(:DELETE, 2)
  field(:UPSERT_AND_DELETE, 3)
end

defmodule WAMsgTransport.MessageTransport.Payload do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgTransport.MessageTransport.Payload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Payload",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "applicationPayload",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "applicationPayload",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "futureProof",
          extendee: nil,
          number: 3,
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

  field(:applicationPayload, 1, optional: true, type: WACommon.SubProtocol)
  field(:futureProof, 3, optional: true, type: WACommon.FutureProofBehavior, enum: true)
end

defmodule WAMsgTransport.MessageTransport.Protocol.Ancillary.BackupDirective do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgTransport.MessageTransport.Protocol.Ancillary.BackupDirective",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BackupDirective",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "actionType",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAMsgTransport.MessageTransport.Protocol.Ancillary.BackupDirective.ActionType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "actionType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "supplementalKey",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "supplementalKey",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "ActionType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NOOP",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UPSERT",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DELETE",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UPSERT_AND_DELETE",
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

  field(:messageID, 1, optional: true, type: :string)

  field(:actionType, 2,
    optional: true,
    type: WAMsgTransport.MessageTransport.Protocol.Ancillary.BackupDirective.ActionType,
    enum: true
  )

  field(:supplementalKey, 3, optional: true, type: :string)
end

defmodule WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices.ICDCIdentityListDescription do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices.ICDCIdentityListDescription",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ICDCIdentityListDescription",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "seq",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "seq",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "signingDevice",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "signingDevice",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "unknownDevices",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "unknownDevices",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "unknownDeviceIDs",
          extendee: nil,
          number: 4,
          label: :LABEL_REPEATED,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "unknownDeviceIDs",
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

  field(:seq, 1, optional: true, type: :int32)
  field(:signingDevice, 2, optional: true, type: :bytes)
  field(:unknownDevices, 3, repeated: true, type: :bytes)
  field(:unknownDeviceIDs, 4, repeated: true, type: :int32)
end

defmodule WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ICDCParticipantDevices",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "senderIdentity",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices.ICDCIdentityListDescription",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "senderIdentity",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "recipientIdentities",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices.ICDCIdentityListDescription",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "recipientIdentities",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "recipientUserJIDs",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "recipientUserJIDs",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "ICDCIdentityListDescription",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "seq",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "seq",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "signingDevice",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "signingDevice",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "unknownDevices",
              extendee: nil,
              number: 3,
              label: :LABEL_REPEATED,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "unknownDevices",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "unknownDeviceIDs",
              extendee: nil,
              number: 4,
              label: :LABEL_REPEATED,
              type: :TYPE_INT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "unknownDeviceIDs",
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

  field(:senderIdentity, 1,
    optional: true,
    type:
      WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices.ICDCIdentityListDescription
  )

  field(:recipientIdentities, 2,
    repeated: true,
    type:
      WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices.ICDCIdentityListDescription
  )

  field(:recipientUserJIDs, 3, repeated: true, type: :string)
end

defmodule WAMsgTransport.MessageTransport.Protocol.Ancillary.SenderKeyDistributionMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgTransport.MessageTransport.Protocol.Ancillary.SenderKeyDistributionMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SenderKeyDistributionMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupID",
          extendee: nil,
          number: 1,
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
          name: "axolotlSenderKeyDistributionMessage",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "axolotlSenderKeyDistributionMessage",
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

  field(:groupID, 1, optional: true, type: :string)
  field(:axolotlSenderKeyDistributionMessage, 2, optional: true, type: :bytes)
end

defmodule WAMsgTransport.MessageTransport.Protocol.Ancillary do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgTransport.MessageTransport.Protocol.Ancillary",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Ancillary",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "skdm",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAMsgTransport.MessageTransport.Protocol.Ancillary.SenderKeyDistributionMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "skdm",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deviceListMetadata",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgTransport.DeviceListMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deviceListMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "icdc",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "icdc",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "backupDirective",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgTransport.MessageTransport.Protocol.Ancillary.BackupDirective",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "backupDirective",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "BackupDirective",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "messageID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "messageID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "actionType",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAMsgTransport.MessageTransport.Protocol.Ancillary.BackupDirective.ActionType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "actionType",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "supplementalKey",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "supplementalKey",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "ActionType",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "NOOP",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UPSERT",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "DELETE",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UPSERT_AND_DELETE",
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
          name: "ICDCParticipantDevices",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "senderIdentity",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices.ICDCIdentityListDescription",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "senderIdentity",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "recipientIdentities",
              extendee: nil,
              number: 2,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices.ICDCIdentityListDescription",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "recipientIdentities",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "recipientUserJIDs",
              extendee: nil,
              number: 3,
              label: :LABEL_REPEATED,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "recipientUserJIDs",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "ICDCIdentityListDescription",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "seq",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_INT32,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "seq",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "signingDevice",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BYTES,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "signingDevice",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "unknownDevices",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_REPEATED,
                  type: :TYPE_BYTES,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "unknownDevices",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "unknownDeviceIDs",
                  extendee: nil,
                  number: 4,
                  label: :LABEL_REPEATED,
                  type: :TYPE_INT32,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "unknownDeviceIDs",
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
        },
        %Google.Protobuf.DescriptorProto{
          name: "SenderKeyDistributionMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "groupID",
              extendee: nil,
              number: 1,
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
              name: "axolotlSenderKeyDistributionMessage",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "axolotlSenderKeyDistributionMessage",
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

  field(:skdm, 2,
    optional: true,
    type: WAMsgTransport.MessageTransport.Protocol.Ancillary.SenderKeyDistributionMessage
  )

  field(:deviceListMetadata, 3, optional: true, type: WAMsgTransport.DeviceListMetadata)

  field(:icdc, 4,
    optional: true,
    type: WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices
  )

  field(:backupDirective, 5,
    optional: true,
    type: WAMsgTransport.MessageTransport.Protocol.Ancillary.BackupDirective
  )
end

defmodule WAMsgTransport.MessageTransport.Protocol.Integral.DeviceSentMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgTransport.MessageTransport.Protocol.Integral.DeviceSentMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "DeviceSentMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "destinationJID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "destinationJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "phash",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "phash",
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

  field(:destinationJID, 1, optional: true, type: :string)
  field(:phash, 2, optional: true, type: :string)
end

defmodule WAMsgTransport.MessageTransport.Protocol.Integral do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgTransport.MessageTransport.Protocol.Integral",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Integral",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "padding",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "padding",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "DSM",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgTransport.MessageTransport.Protocol.Integral.DeviceSentMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "DSM",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "DeviceSentMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "destinationJID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "destinationJID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "phash",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "phash",
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

  field(:padding, 1, optional: true, type: :bytes)

  field(:DSM, 2,
    optional: true,
    type: WAMsgTransport.MessageTransport.Protocol.Integral.DeviceSentMessage
  )
end

defmodule WAMsgTransport.MessageTransport.Protocol do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgTransport.MessageTransport.Protocol",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Protocol",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "integral",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgTransport.MessageTransport.Protocol.Integral",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "integral",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ancillary",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgTransport.MessageTransport.Protocol.Ancillary",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ancillary",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Ancillary",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "skdm",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAMsgTransport.MessageTransport.Protocol.Ancillary.SenderKeyDistributionMessage",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "skdm",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "deviceListMetadata",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMsgTransport.DeviceListMetadata",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "deviceListMetadata",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "icdc",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "icdc",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "backupDirective",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMsgTransport.MessageTransport.Protocol.Ancillary.BackupDirective",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "backupDirective",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "BackupDirective",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "messageID",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "messageID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "actionType",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_ENUM,
                  type_name:
                    ".WAMsgTransport.MessageTransport.Protocol.Ancillary.BackupDirective.ActionType",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "actionType",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "supplementalKey",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "supplementalKey",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [],
              enum_type: [
                %Google.Protobuf.EnumDescriptorProto{
                  name: "ActionType",
                  value: [
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "NOOP",
                      number: 0,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "UPSERT",
                      number: 1,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "DELETE",
                      number: 2,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "UPSERT_AND_DELETE",
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
              name: "ICDCParticipantDevices",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "senderIdentity",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices.ICDCIdentityListDescription",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "senderIdentity",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "recipientIdentities",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_REPEATED,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices.ICDCIdentityListDescription",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "recipientIdentities",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "recipientUserJIDs",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_REPEATED,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "recipientUserJIDs",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [
                %Google.Protobuf.DescriptorProto{
                  name: "ICDCIdentityListDescription",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "seq",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_INT32,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "seq",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "signingDevice",
                      extendee: nil,
                      number: 2,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_BYTES,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "signingDevice",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "unknownDevices",
                      extendee: nil,
                      number: 3,
                      label: :LABEL_REPEATED,
                      type: :TYPE_BYTES,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "unknownDevices",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "unknownDeviceIDs",
                      extendee: nil,
                      number: 4,
                      label: :LABEL_REPEATED,
                      type: :TYPE_INT32,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "unknownDeviceIDs",
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
            },
            %Google.Protobuf.DescriptorProto{
              name: "SenderKeyDistributionMessage",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "groupID",
                  extendee: nil,
                  number: 1,
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
                  name: "axolotlSenderKeyDistributionMessage",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BYTES,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "axolotlSenderKeyDistributionMessage",
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
        },
        %Google.Protobuf.DescriptorProto{
          name: "Integral",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "padding",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "padding",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "DSM",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMsgTransport.MessageTransport.Protocol.Integral.DeviceSentMessage",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "DSM",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "DeviceSentMessage",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "destinationJID",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "destinationJID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "phash",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "phash",
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

  field(:integral, 1, optional: true, type: WAMsgTransport.MessageTransport.Protocol.Integral)
  field(:ancillary, 2, optional: true, type: WAMsgTransport.MessageTransport.Protocol.Ancillary)
end

defmodule WAMsgTransport.MessageTransport do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgTransport.MessageTransport",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MessageTransport",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "payload",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgTransport.MessageTransport.Payload",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "payload",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "protocol",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMsgTransport.MessageTransport.Protocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "protocol",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Payload",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "applicationPayload",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "applicationPayload",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "futureProof",
              extendee: nil,
              number: 3,
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
          name: "Protocol",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "integral",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMsgTransport.MessageTransport.Protocol.Integral",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "integral",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "ancillary",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMsgTransport.MessageTransport.Protocol.Ancillary",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "ancillary",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "Ancillary",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "skdm",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAMsgTransport.MessageTransport.Protocol.Ancillary.SenderKeyDistributionMessage",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "skdm",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "deviceListMetadata",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WAMsgTransport.DeviceListMetadata",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "deviceListMetadata",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "icdc",
                  extendee: nil,
                  number: 4,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "icdc",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "backupDirective",
                  extendee: nil,
                  number: 5,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WAMsgTransport.MessageTransport.Protocol.Ancillary.BackupDirective",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "backupDirective",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [
                %Google.Protobuf.DescriptorProto{
                  name: "BackupDirective",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "messageID",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_STRING,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "messageID",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "actionType",
                      extendee: nil,
                      number: 2,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_ENUM,
                      type_name:
                        ".WAMsgTransport.MessageTransport.Protocol.Ancillary.BackupDirective.ActionType",
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "actionType",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "supplementalKey",
                      extendee: nil,
                      number: 3,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_STRING,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "supplementalKey",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    }
                  ],
                  nested_type: [],
                  enum_type: [
                    %Google.Protobuf.EnumDescriptorProto{
                      name: "ActionType",
                      value: [
                        %Google.Protobuf.EnumValueDescriptorProto{
                          name: "NOOP",
                          number: 0,
                          options: nil,
                          __unknown_fields__: []
                        },
                        %Google.Protobuf.EnumValueDescriptorProto{
                          name: "UPSERT",
                          number: 1,
                          options: nil,
                          __unknown_fields__: []
                        },
                        %Google.Protobuf.EnumValueDescriptorProto{
                          name: "DELETE",
                          number: 2,
                          options: nil,
                          __unknown_fields__: []
                        },
                        %Google.Protobuf.EnumValueDescriptorProto{
                          name: "UPSERT_AND_DELETE",
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
                  name: "ICDCParticipantDevices",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "senderIdentity",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_MESSAGE,
                      type_name:
                        ".WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices.ICDCIdentityListDescription",
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "senderIdentity",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "recipientIdentities",
                      extendee: nil,
                      number: 2,
                      label: :LABEL_REPEATED,
                      type: :TYPE_MESSAGE,
                      type_name:
                        ".WAMsgTransport.MessageTransport.Protocol.Ancillary.ICDCParticipantDevices.ICDCIdentityListDescription",
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "recipientIdentities",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "recipientUserJIDs",
                      extendee: nil,
                      number: 3,
                      label: :LABEL_REPEATED,
                      type: :TYPE_STRING,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "recipientUserJIDs",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    }
                  ],
                  nested_type: [
                    %Google.Protobuf.DescriptorProto{
                      name: "ICDCIdentityListDescription",
                      field: [
                        %Google.Protobuf.FieldDescriptorProto{
                          name: "seq",
                          extendee: nil,
                          number: 1,
                          label: :LABEL_OPTIONAL,
                          type: :TYPE_INT32,
                          type_name: nil,
                          default_value: nil,
                          options: nil,
                          oneof_index: nil,
                          json_name: "seq",
                          proto3_optional: nil,
                          __unknown_fields__: []
                        },
                        %Google.Protobuf.FieldDescriptorProto{
                          name: "signingDevice",
                          extendee: nil,
                          number: 2,
                          label: :LABEL_OPTIONAL,
                          type: :TYPE_BYTES,
                          type_name: nil,
                          default_value: nil,
                          options: nil,
                          oneof_index: nil,
                          json_name: "signingDevice",
                          proto3_optional: nil,
                          __unknown_fields__: []
                        },
                        %Google.Protobuf.FieldDescriptorProto{
                          name: "unknownDevices",
                          extendee: nil,
                          number: 3,
                          label: :LABEL_REPEATED,
                          type: :TYPE_BYTES,
                          type_name: nil,
                          default_value: nil,
                          options: nil,
                          oneof_index: nil,
                          json_name: "unknownDevices",
                          proto3_optional: nil,
                          __unknown_fields__: []
                        },
                        %Google.Protobuf.FieldDescriptorProto{
                          name: "unknownDeviceIDs",
                          extendee: nil,
                          number: 4,
                          label: :LABEL_REPEATED,
                          type: :TYPE_INT32,
                          type_name: nil,
                          default_value: nil,
                          options: nil,
                          oneof_index: nil,
                          json_name: "unknownDeviceIDs",
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
                },
                %Google.Protobuf.DescriptorProto{
                  name: "SenderKeyDistributionMessage",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "groupID",
                      extendee: nil,
                      number: 1,
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
                      name: "axolotlSenderKeyDistributionMessage",
                      extendee: nil,
                      number: 2,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_BYTES,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "axolotlSenderKeyDistributionMessage",
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
            },
            %Google.Protobuf.DescriptorProto{
              name: "Integral",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "padding",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BYTES,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "padding",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "DSM",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WAMsgTransport.MessageTransport.Protocol.Integral.DeviceSentMessage",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "DSM",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [
                %Google.Protobuf.DescriptorProto{
                  name: "DeviceSentMessage",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "destinationJID",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_STRING,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "destinationJID",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "phash",
                      extendee: nil,
                      number: 2,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_STRING,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "phash",
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

  field(:payload, 1, optional: true, type: WAMsgTransport.MessageTransport.Payload)
  field(:protocol, 2, optional: true, type: WAMsgTransport.MessageTransport.Protocol)
end

defmodule WAMsgTransport.DeviceListMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAMsgTransport.DeviceListMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "DeviceListMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "senderKeyHash",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "senderKeyHash",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "senderTimestamp",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "senderTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "recipientKeyHash",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "recipientKeyHash",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "recipientTimestamp",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "recipientTimestamp",
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

  field(:senderKeyHash, 1, optional: true, type: :bytes)
  field(:senderTimestamp, 2, optional: true, type: :uint64)
  field(:recipientKeyHash, 8, optional: true, type: :bytes)
  field(:recipientTimestamp, 9, optional: true, type: :uint64)
end
