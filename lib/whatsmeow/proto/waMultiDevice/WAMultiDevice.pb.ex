defmodule WAMultiDevice.MultiDevice.Metadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAMultiDevice.MultiDevice.Metadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Metadata",
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

defmodule WAMultiDevice.MultiDevice.Payload do
  @moduledoc false

  use Protobuf,
    full_name: "WAMultiDevice.MultiDevice.Payload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Payload",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "applicationData",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMultiDevice.MultiDevice.ApplicationData",
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
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMultiDevice.MultiDevice.Signal",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "signal",
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

  field(:applicationData, 1,
    optional: true,
    type: WAMultiDevice.MultiDevice.ApplicationData,
    oneof: 0
  )

  field(:signal, 2, optional: true, type: WAMultiDevice.MultiDevice.Signal, oneof: 0)
end

defmodule WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyRequestMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyRequestMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AppStateSyncKeyRequestMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "keyIDs",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyId",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "keyIDs",
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

  field(:keyIDs, 1,
    repeated: true,
    type: WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyId
  )
end

defmodule WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyShareMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyShareMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AppStateSyncKeyShareMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "keys",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "keys",
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

  field(:keys, 1, repeated: true, type: WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey)
end

defmodule WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey.AppStateSyncKeyData.AppStateSyncKeyFingerprint do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey.AppStateSyncKeyData.AppStateSyncKeyFingerprint",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AppStateSyncKeyFingerprint",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "rawID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "rawID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "currentIndex",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "currentIndex",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deviceIndexes",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: %Google.Protobuf.FieldOptions{
            ctype: :STRING,
            packed: true,
            deprecated: false,
            lazy: false,
            jstype: :JS_NORMAL,
            weak: false,
            unverified_lazy: false,
            debug_redact: false,
            retention: nil,
            targets: [],
            edition_defaults: [],
            features: nil,
            feature_support: nil,
            uninterpreted_option: [],
            __pb_extensions__: %{},
            __unknown_fields__: []
          },
          oneof_index: nil,
          json_name: "deviceIndexes",
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

  field(:rawID, 1, optional: true, type: :uint32)
  field(:currentIndex, 2, optional: true, type: :uint32)
  field(:deviceIndexes, 3, repeated: true, type: :uint32, packed: true, deprecated: false)
end

defmodule WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey.AppStateSyncKeyData do
  @moduledoc false

  use Protobuf,
    full_name: "WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey.AppStateSyncKeyData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AppStateSyncKeyData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "keyData",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "keyData",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fingerprint",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey.AppStateSyncKeyData.AppStateSyncKeyFingerprint",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fingerprint",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "timestamp",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "timestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "AppStateSyncKeyFingerprint",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "rawID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "rawID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "currentIndex",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "currentIndex",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "deviceIndexes",
              extendee: nil,
              number: 3,
              label: :LABEL_REPEATED,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: %Google.Protobuf.FieldOptions{
                ctype: :STRING,
                packed: true,
                deprecated: false,
                lazy: false,
                jstype: :JS_NORMAL,
                weak: false,
                unverified_lazy: false,
                debug_redact: false,
                retention: nil,
                targets: [],
                edition_defaults: [],
                features: nil,
                feature_support: nil,
                uninterpreted_option: [],
                __pb_extensions__: %{},
                __unknown_fields__: []
              },
              oneof_index: nil,
              json_name: "deviceIndexes",
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

  field(:keyData, 1, optional: true, type: :bytes)

  field(:fingerprint, 2,
    optional: true,
    type:
      WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey.AppStateSyncKeyData.AppStateSyncKeyFingerprint
  )

  field(:timestamp, 3, optional: true, type: :int64)
end

defmodule WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey do
  @moduledoc false

  use Protobuf,
    full_name: "WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AppStateSyncKey",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "keyID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyId",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "keyID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "keyData",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey.AppStateSyncKeyData",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "keyData",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "AppStateSyncKeyData",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "keyData",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "keyData",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "fingerprint",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey.AppStateSyncKeyData.AppStateSyncKeyFingerprint",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "fingerprint",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "timestamp",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "timestamp",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "AppStateSyncKeyFingerprint",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "rawID",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_UINT32,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "rawID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "currentIndex",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_UINT32,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "currentIndex",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "deviceIndexes",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_REPEATED,
                  type: :TYPE_UINT32,
                  type_name: nil,
                  default_value: nil,
                  options: %Google.Protobuf.FieldOptions{
                    ctype: :STRING,
                    packed: true,
                    deprecated: false,
                    lazy: false,
                    jstype: :JS_NORMAL,
                    weak: false,
                    unverified_lazy: false,
                    debug_redact: false,
                    retention: nil,
                    targets: [],
                    edition_defaults: [],
                    features: nil,
                    feature_support: nil,
                    uninterpreted_option: [],
                    __pb_extensions__: %{},
                    __unknown_fields__: []
                  },
                  oneof_index: nil,
                  json_name: "deviceIndexes",
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

  field(:keyID, 1,
    optional: true,
    type: WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyId
  )

  field(:keyData, 2,
    optional: true,
    type: WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey.AppStateSyncKeyData
  )
end

defmodule WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyId do
  @moduledoc false

  use Protobuf,
    full_name: "WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyId",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AppStateSyncKeyId",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "keyID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "keyID",
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

  field(:keyID, 1, optional: true, type: :bytes)
end

defmodule WAMultiDevice.MultiDevice.ApplicationData do
  @moduledoc false

  use Protobuf,
    full_name: "WAMultiDevice.MultiDevice.ApplicationData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ApplicationData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "appStateSyncKeyShare",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyShareMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "appStateSyncKeyShare",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "appStateSyncKeyRequest",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyRequestMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "appStateSyncKeyRequest",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "AppStateSyncKeyRequestMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "keyIDs",
              extendee: nil,
              number: 1,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name: ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyId",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "keyIDs",
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
          name: "AppStateSyncKeyShareMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "keys",
              extendee: nil,
              number: 1,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name: ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "keys",
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
          name: "AppStateSyncKey",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "keyID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyId",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "keyID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "keyData",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey.AppStateSyncKeyData",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "keyData",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "AppStateSyncKeyData",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "keyData",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BYTES,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "keyData",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "fingerprint",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey.AppStateSyncKeyData.AppStateSyncKeyFingerprint",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "fingerprint",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "timestamp",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_INT64,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "timestamp",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [
                %Google.Protobuf.DescriptorProto{
                  name: "AppStateSyncKeyFingerprint",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "rawID",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_UINT32,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "rawID",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "currentIndex",
                      extendee: nil,
                      number: 2,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_UINT32,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "currentIndex",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "deviceIndexes",
                      extendee: nil,
                      number: 3,
                      label: :LABEL_REPEATED,
                      type: :TYPE_UINT32,
                      type_name: nil,
                      default_value: nil,
                      options: %Google.Protobuf.FieldOptions{
                        ctype: :STRING,
                        packed: true,
                        deprecated: false,
                        lazy: false,
                        jstype: :JS_NORMAL,
                        weak: false,
                        unverified_lazy: false,
                        debug_redact: false,
                        retention: nil,
                        targets: [],
                        edition_defaults: [],
                        features: nil,
                        feature_support: nil,
                        uninterpreted_option: [],
                        __pb_extensions__: %{},
                        __unknown_fields__: []
                      },
                      oneof_index: nil,
                      json_name: "deviceIndexes",
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
        },
        %Google.Protobuf.DescriptorProto{
          name: "AppStateSyncKeyId",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "keyID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "keyID",
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
      oneof_decl: [
        %Google.Protobuf.OneofDescriptorProto{
          name: "applicationData",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:applicationData, 0)

  field(:appStateSyncKeyShare, 1,
    optional: true,
    type: WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyShareMessage,
    oneof: 0
  )

  field(:appStateSyncKeyRequest, 2,
    optional: true,
    type: WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyRequestMessage,
    oneof: 0
  )
end

defmodule WAMultiDevice.MultiDevice.Signal do
  @moduledoc false

  use Protobuf,
    full_name: "WAMultiDevice.MultiDevice.Signal",
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

defmodule WAMultiDevice.MultiDevice do
  @moduledoc false

  use Protobuf,
    full_name: "WAMultiDevice.MultiDevice",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MultiDevice",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "payload",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMultiDevice.MultiDevice.Payload",
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
          type_name: ".WAMultiDevice.MultiDevice.Metadata",
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
          name: "Payload",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "applicationData",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMultiDevice.MultiDevice.ApplicationData",
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
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMultiDevice.MultiDevice.Signal",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "signal",
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
          name: "ApplicationData",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "appStateSyncKeyShare",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyShareMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "appStateSyncKeyShare",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "appStateSyncKeyRequest",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyRequestMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "appStateSyncKeyRequest",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "AppStateSyncKeyRequestMessage",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "keyIDs",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_REPEATED,
                  type: :TYPE_MESSAGE,
                  type_name: ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyId",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "keyIDs",
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
              name: "AppStateSyncKeyShareMessage",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "keys",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_REPEATED,
                  type: :TYPE_MESSAGE,
                  type_name: ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "keys",
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
              name: "AppStateSyncKey",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "keyID",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKeyId",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "keyID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "keyData",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey.AppStateSyncKeyData",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "keyData",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [
                %Google.Protobuf.DescriptorProto{
                  name: "AppStateSyncKeyData",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "keyData",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_BYTES,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "keyData",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "fingerprint",
                      extendee: nil,
                      number: 2,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_MESSAGE,
                      type_name:
                        ".WAMultiDevice.MultiDevice.ApplicationData.AppStateSyncKey.AppStateSyncKeyData.AppStateSyncKeyFingerprint",
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "fingerprint",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "timestamp",
                      extendee: nil,
                      number: 3,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_INT64,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "timestamp",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    }
                  ],
                  nested_type: [
                    %Google.Protobuf.DescriptorProto{
                      name: "AppStateSyncKeyFingerprint",
                      field: [
                        %Google.Protobuf.FieldDescriptorProto{
                          name: "rawID",
                          extendee: nil,
                          number: 1,
                          label: :LABEL_OPTIONAL,
                          type: :TYPE_UINT32,
                          type_name: nil,
                          default_value: nil,
                          options: nil,
                          oneof_index: nil,
                          json_name: "rawID",
                          proto3_optional: nil,
                          __unknown_fields__: []
                        },
                        %Google.Protobuf.FieldDescriptorProto{
                          name: "currentIndex",
                          extendee: nil,
                          number: 2,
                          label: :LABEL_OPTIONAL,
                          type: :TYPE_UINT32,
                          type_name: nil,
                          default_value: nil,
                          options: nil,
                          oneof_index: nil,
                          json_name: "currentIndex",
                          proto3_optional: nil,
                          __unknown_fields__: []
                        },
                        %Google.Protobuf.FieldDescriptorProto{
                          name: "deviceIndexes",
                          extendee: nil,
                          number: 3,
                          label: :LABEL_REPEATED,
                          type: :TYPE_UINT32,
                          type_name: nil,
                          default_value: nil,
                          options: %Google.Protobuf.FieldOptions{
                            ctype: :STRING,
                            packed: true,
                            deprecated: false,
                            lazy: false,
                            jstype: :JS_NORMAL,
                            weak: false,
                            unverified_lazy: false,
                            debug_redact: false,
                            retention: nil,
                            targets: [],
                            edition_defaults: [],
                            features: nil,
                            feature_support: nil,
                            uninterpreted_option: [],
                            __pb_extensions__: %{},
                            __unknown_fields__: []
                          },
                          oneof_index: nil,
                          json_name: "deviceIndexes",
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
            },
            %Google.Protobuf.DescriptorProto{
              name: "AppStateSyncKeyId",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "keyID",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BYTES,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "keyID",
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
          oneof_decl: [
            %Google.Protobuf.OneofDescriptorProto{
              name: "applicationData",
              options: nil,
              __unknown_fields__: []
            }
          ],
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

  field(:payload, 1, optional: true, type: WAMultiDevice.MultiDevice.Payload)
  field(:metadata, 2, optional: true, type: WAMultiDevice.MultiDevice.Metadata)
end
