defmodule WAFingerprint.HostedState do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAFingerprint.HostedState",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "HostedState",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "E2EE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "HOSTED",
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

  field(:E2EE, 0)
  field(:HOSTED, 1)
end

defmodule WAFingerprint.FingerprintData do
  @moduledoc false

  use Protobuf,
    full_name: "WAFingerprint.FingerprintData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "FingerprintData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "publicKey",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "publicKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pnIdentifier",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pnIdentifier",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lidIdentifier",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lidIdentifier",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "usernameIdentifier",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "usernameIdentifier",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "hostedState",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAFingerprint.HostedState",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "hostedState",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "hashedPublicKey",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "hashedPublicKey",
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

  field(:publicKey, 1, optional: true, type: :bytes)
  field(:pnIdentifier, 2, optional: true, type: :bytes)
  field(:lidIdentifier, 3, optional: true, type: :bytes)
  field(:usernameIdentifier, 4, optional: true, type: :bytes)
  field(:hostedState, 5, optional: true, type: WAFingerprint.HostedState, enum: true)
  field(:hashedPublicKey, 6, optional: true, type: :bytes)
end

defmodule WAFingerprint.CombinedFingerprint do
  @moduledoc false

  use Protobuf,
    full_name: "WAFingerprint.CombinedFingerprint",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "CombinedFingerprint",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "version",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "version",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "localFingerprint",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAFingerprint.FingerprintData",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "localFingerprint",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "remoteFingerprint",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAFingerprint.FingerprintData",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "remoteFingerprint",
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

  field(:version, 1, optional: true, type: :uint32)
  field(:localFingerprint, 2, optional: true, type: WAFingerprint.FingerprintData)
  field(:remoteFingerprint, 3, optional: true, type: WAFingerprint.FingerprintData)
end
