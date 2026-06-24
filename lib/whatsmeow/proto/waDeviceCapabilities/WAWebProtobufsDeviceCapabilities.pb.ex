defmodule WAWebProtobufsDeviceCapabilities.DeviceCapabilities.MemberNameTagPrimarySupport do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsDeviceCapabilities.DeviceCapabilities.MemberNameTagPrimarySupport",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "MemberNameTagPrimarySupport",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DISABLED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RECEIVER_ENABLED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SENDER_ENABLED",
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

  field(:DISABLED, 0)
  field(:RECEIVER_ENABLED, 1)
  field(:SENDER_ENABLED, 2)
end

defmodule WAWebProtobufsDeviceCapabilities.DeviceCapabilities.ChatLockSupportLevel do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsDeviceCapabilities.DeviceCapabilities.ChatLockSupportLevel",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ChatLockSupportLevel",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NONE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MINIMAL",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FULL",
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

  field(:NONE, 0)
  field(:MINIMAL, 1)
  field(:FULL, 2)
end

defmodule WAWebProtobufsDeviceCapabilities.DeviceCapabilities.AiThread.SupportLevel do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsDeviceCapabilities.DeviceCapabilities.AiThread.SupportLevel",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "SupportLevel",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NONE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INFRA",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FULL",
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

  field(:NONE, 0)
  field(:INFRA, 1)
  field(:FULL, 2)
end

defmodule WAWebProtobufsDeviceCapabilities.DeviceCapabilities.AiThread do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsDeviceCapabilities.DeviceCapabilities.AiThread",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AiThread",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "supportLevel",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsDeviceCapabilities.DeviceCapabilities.AiThread.SupportLevel",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "supportLevel",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "SupportLevel",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NONE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INFRA",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FULL",
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
      oneof_decl: [],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  field(:supportLevel, 1,
    optional: true,
    type: WAWebProtobufsDeviceCapabilities.DeviceCapabilities.AiThread.SupportLevel,
    enum: true
  )
end

defmodule WAWebProtobufsDeviceCapabilities.DeviceCapabilities.UserHasAvatar do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsDeviceCapabilities.DeviceCapabilities.UserHasAvatar",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "UserHasAvatar",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "userHasAvatar",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "userHasAvatar",
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

  field(:userHasAvatar, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufsDeviceCapabilities.DeviceCapabilities.BusinessBroadcast do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsDeviceCapabilities.DeviceCapabilities.BusinessBroadcast",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BusinessBroadcast",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "importListEnabled",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "importListEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "companionSupportEnabled",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "companionSupportEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "campaignSyncEnabled",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "campaignSyncEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "insightsSyncEnabled",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "insightsSyncEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "recipientLimit",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "recipientLimit",
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

  field(:importListEnabled, 1, optional: true, type: :bool)
  field(:companionSupportEnabled, 2, optional: true, type: :bool)
  field(:campaignSyncEnabled, 3, optional: true, type: :bool)
  field(:insightsSyncEnabled, 4, optional: true, type: :bool)
  field(:recipientLimit, 5, optional: true, type: :int32)
end

defmodule WAWebProtobufsDeviceCapabilities.DeviceCapabilities.LIDMigration do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsDeviceCapabilities.DeviceCapabilities.LIDMigration",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "LIDMigration",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatDbMigrationTimestamp",
          extendee: nil,
          number: 1,
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

  field(:chatDbMigrationTimestamp, 1, optional: true, type: :uint64)
end

defmodule WAWebProtobufsDeviceCapabilities.DeviceCapabilities do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsDeviceCapabilities.DeviceCapabilities",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "DeviceCapabilities",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatLockSupportLevel",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsDeviceCapabilities.DeviceCapabilities.ChatLockSupportLevel",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "chatLockSupportLevel",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lidMigration",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsDeviceCapabilities.DeviceCapabilities.LIDMigration",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lidMigration",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "businessBroadcast",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsDeviceCapabilities.DeviceCapabilities.BusinessBroadcast",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "businessBroadcast",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "userHasAvatar",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsDeviceCapabilities.DeviceCapabilities.UserHasAvatar",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "userHasAvatar",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "memberNameTagPrimarySupport",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAWebProtobufsDeviceCapabilities.DeviceCapabilities.MemberNameTagPrimarySupport",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "memberNameTagPrimarySupport",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "aiThread",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsDeviceCapabilities.DeviceCapabilities.AiThread",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "aiThread",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "AiThread",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "supportLevel",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAWebProtobufsDeviceCapabilities.DeviceCapabilities.AiThread.SupportLevel",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "supportLevel",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "SupportLevel",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "NONE",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "INFRA",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "FULL",
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
          oneof_decl: [],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "UserHasAvatar",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "userHasAvatar",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "userHasAvatar",
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
          name: "BusinessBroadcast",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "importListEnabled",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "importListEnabled",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "companionSupportEnabled",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "companionSupportEnabled",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "campaignSyncEnabled",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "campaignSyncEnabled",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "insightsSyncEnabled",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "insightsSyncEnabled",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "recipientLimit",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "recipientLimit",
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
          name: "LIDMigration",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "chatDbMigrationTimestamp",
              extendee: nil,
              number: 1,
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
      ],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "MemberNameTagPrimarySupport",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DISABLED",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RECEIVER_ENABLED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SENDER_ENABLED",
              number: 2,
              options: nil,
              __unknown_fields__: []
            }
          ],
          options: nil,
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumDescriptorProto{
          name: "ChatLockSupportLevel",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NONE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MINIMAL",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FULL",
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
      oneof_decl: [],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  field(:chatLockSupportLevel, 1,
    optional: true,
    type: WAWebProtobufsDeviceCapabilities.DeviceCapabilities.ChatLockSupportLevel,
    enum: true
  )

  field(:lidMigration, 2,
    optional: true,
    type: WAWebProtobufsDeviceCapabilities.DeviceCapabilities.LIDMigration
  )

  field(:businessBroadcast, 3,
    optional: true,
    type: WAWebProtobufsDeviceCapabilities.DeviceCapabilities.BusinessBroadcast
  )

  field(:userHasAvatar, 4,
    optional: true,
    type: WAWebProtobufsDeviceCapabilities.DeviceCapabilities.UserHasAvatar
  )

  field(:memberNameTagPrimarySupport, 5,
    optional: true,
    type: WAWebProtobufsDeviceCapabilities.DeviceCapabilities.MemberNameTagPrimarySupport,
    enum: true
  )

  field(:aiThread, 6,
    optional: true,
    type: WAWebProtobufsDeviceCapabilities.DeviceCapabilities.AiThread
  )
end
