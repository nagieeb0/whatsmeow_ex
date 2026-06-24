defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LimitSharingChanged.SharingType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LimitSharingChanged.SharingType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "SharingType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNSET",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DISABLED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ENABLED",
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

  field(:UNSET, 0)
  field(:DISABLED, 1)
  field(:ENABLED, 2)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupImageChanged.Action do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupImageChanged.Action",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Action",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNSET",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CHANGED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REMOVED",
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

  field(:UNSET, 0)
  field(:CHANGED, 1)
  field(:REMOVED, 2)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.MessagePinned.Action do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.MessagePinned.Action",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Action",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNSET",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PINNED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNPINNED",
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

  field(:UNSET, 0)
  field(:PINNED, 1)
  field(:UNPINNED, 2)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupMembershipAddModeChanged.Mode do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupMembershipAddModeChanged.Mode",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Mode",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNSET",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ALL_MEMBERS",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ADMINS_ONLY",
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

  field(:UNSET, 0)
  field(:ALL_MEMBERS, 1)
  field(:ADMINS_ONLY, 2)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupAdminChanged.Action do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupAdminChanged.Action",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Action",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNSET",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ADDED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REMOVED",
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

  field(:UNSET, 0)
  field(:ADDED, 1)
  field(:REMOVED, 2)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupParticipantChanged.Action do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupParticipantChanged.Action",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Action",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNSET",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ADDED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REMOVED",
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

  field(:UNSET, 0)
  field(:ADDED, 1)
  field(:REMOVED, 2)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LimitSharingChanged do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LimitSharingChanged",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "LimitSharingChanged",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "sharingType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LimitSharingChanged.SharingType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sharingType",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "SharingType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNSET",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DISABLED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ENABLED",
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

  field(:sharingType, 1,
    optional: true,
    type:
      WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LimitSharingChanged.SharingType,
    enum: true
  )
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupImageChanged do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupImageChanged",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "GroupImageChanged",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "action",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupImageChanged.Action",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "action",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "Action",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNSET",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CHANGED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REMOVED",
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

  field(:action, 1,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupImageChanged.Action,
    enum: true
  )
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.MessagePinned do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.MessagePinned",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MessagePinned",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "action",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.MessagePinned.Action",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "action",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "Action",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNSET",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PINNED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNPINNED",
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

  field(:action, 1,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.MessagePinned.Action,
    enum: true
  )
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupMembershipAddModeChanged do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupMembershipAddModeChanged",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "GroupMembershipAddModeChanged",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "mode",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupMembershipAddModeChanged.Mode",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mode",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "Mode",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNSET",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ALL_MEMBERS",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ADMINS_ONLY",
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

  field(:mode, 1,
    optional: true,
    type:
      WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupMembershipAddModeChanged.Mode,
    enum: true
  )
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupAdminChanged do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupAdminChanged",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "GroupAdminChanged",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "targetUserID",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "targetUserID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "action",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupAdminChanged.Action",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "action",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "Action",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNSET",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ADDED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REMOVED",
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

  field(:targetUserID, 1, repeated: true, type: :string)

  field(:action, 2,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupAdminChanged.Action,
    enum: true
  )
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupParticipantChanged do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupParticipantChanged",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "GroupParticipantChanged",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "targetUserID",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "targetUserID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "action",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupParticipantChanged.Action",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "action",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "Action",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNSET",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ADDED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REMOVED",
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

  field(:targetUserID, 1, repeated: true, type: :string)

  field(:action, 2,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupParticipantChanged.Action,
    enum: true
  )
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerMessageReminderTriggered do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerMessageReminderTriggered",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatMessengerMessageReminderTriggered",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "offlineThreadingID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "offlineThreadingID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "scheduledTime",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "scheduledTime",
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

  field(:offlineThreadingID, 1, optional: true, type: :int64)
  field(:scheduledTime, 2, optional: true, type: :int64)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerMessageReminderSet do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerMessageReminderSet",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatMessengerMessageReminderSet",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "offlineThreadingID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "offlineThreadingID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "scheduledTime",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "scheduledTime",
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

  field(:offlineThreadingID, 1, optional: true, type: :int64)
  field(:scheduledTime, 2, optional: true, type: :int64)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatSetParticipantUpdateMode do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatSetParticipantUpdateMode",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatSetParticipantUpdateMode",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "participantUpdateMode",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "participantUpdateMode",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "setterID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "setterID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "transportThreadFbid",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "transportThreadFbid",
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

  field(:participantUpdateMode, 1, optional: true, type: :string)
  field(:setterID, 2, optional: true, type: :int64)
  field(:transportThreadFbid, 3, optional: true, type: :int64)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatGroupThreadCreated do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatGroupThreadCreated",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatGroupThreadCreated",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "threadSubtype",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "threadSubtype",
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

  field(:threadSubtype, 1, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatChangeThreadName do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatChangeThreadName",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatChangeThreadName",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "newThreadName",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "newThreadName",
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

  field(:newThreadName, 1, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatChangeThreadAdmins do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatChangeThreadAdmins",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatChangeThreadAdmins",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "adminEvent",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "adminEvent",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "targetID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "targetID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "threadCategory",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "threadCategory",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "adminType",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "adminType",
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

  field(:adminEvent, 1, optional: true, type: :string)
  field(:targetID, 2, optional: true, type: :int64)
  field(:threadCategory, 3, optional: true, type: :string)
  field(:adminType, 4, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatRemoveParticipant do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatRemoveParticipant",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatRemoveParticipant",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "removedParticipantFbid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "removedParticipantFbid",
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

  field(:removedParticipantFbid, 1, optional: true, type: :int64)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatAddParticipants do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatAddParticipants",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatAddParticipants",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "participantsAdded",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_INT64,
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
          json_name: "participantsAdded",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "addedThroughJoinRequests",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "addedThroughJoinRequests",
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

  field(:participantsAdded, 1, repeated: true, type: :int64, packed: true, deprecated: false)
  field(:addedThroughJoinRequests, 2, optional: true, type: :bool)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatGenAITaskAdd do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatGenAITaskAdd",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatGenAITaskAdd",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "taskID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "taskID",
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

  field(:taskID, 1, optional: true, type: :int64)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatUnpinMessageV2 do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatUnpinMessageV2",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatUnpinMessageV2",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "pinnedMessageID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pinnedMessageID",
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

  field(:pinnedMessageID, 1, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatPinMessageV2 do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatPinMessageV2",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatPinMessageV2",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "pinnedMessageID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pinnedMessageID",
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

  field(:pinnedMessageID, 1, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatUpdatePayments do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatUpdatePayments",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatUpdatePayments",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "receiverName",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "receiverName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "senderName",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "senderName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "amount",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_FLOAT,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "amount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "transactionID",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "transactionID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "transactionStatus",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "transactionStatus",
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

  field(:receiverName, 1, optional: true, type: :string)
  field(:senderName, 2, optional: true, type: :string)
  field(:amount, 3, optional: true, type: :float)
  field(:transactionID, 4, optional: true, type: :int64)
  field(:transactionStatus, 5, optional: true, type: :int32)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatThreadQuickReaction do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatThreadQuickReaction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatThreadQuickReaction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "threadQuickReactionEmoji",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "threadQuickReactionEmoji",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "threadQuickReactionInstructionKeyID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "threadQuickReactionInstructionKeyID",
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

  field(:threadQuickReactionEmoji, 1, optional: true, type: :string)
  field(:threadQuickReactionInstructionKeyID, 2, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatThreadNickname do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatThreadNickname",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatThreadNickname",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "participantID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "participantID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "nickname",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "nickname",
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

  field(:participantID, 1, optional: true, type: :int64)
  field(:nickname, 2, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatThreadIcon do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatThreadIcon",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatThreadIcon",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "threadIcon",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "threadIcon",
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

  field(:threadIcon, 1, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatThemeColor do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatThemeColor",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatThemeColor",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "themeID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "themeID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "themeColor",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "themeColor",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "gradient",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "gradient",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "shouldShowIcon",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "shouldShowIcon",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "themeType",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "themeType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "accessibilityLabel",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "accessibilityLabel",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "themeNameWithSubtitle",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "themeNameWithSubtitle",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "themeEmoji",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "themeEmoji",
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

  field(:themeID, 1, optional: true, type: :string)
  field(:themeColor, 2, optional: true, type: :string)
  field(:gradient, 3, repeated: true, type: :string)
  field(:shouldShowIcon, 4, optional: true, type: :bool)
  field(:themeType, 5, optional: true, type: :int32)
  field(:accessibilityLabel, 6, optional: true, type: :string)
  field(:themeNameWithSubtitle, 7, optional: true, type: :string)
  field(:themeEmoji, 8, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbum do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbum",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatMessengerSharedAlbum",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmaDataclass",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "xmaDataclass",
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

  field(:xmaDataclass, 1, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumRename do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumRename",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatMessengerSharedAlbumRename",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "sharedAlbumID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sharedAlbumID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "oldAlbumTitle",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "oldAlbumTitle",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "newAlbumTitle",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "newAlbumTitle",
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

  field(:sharedAlbumID, 1, optional: true, type: :int64)
  field(:oldAlbumTitle, 2, optional: true, type: :string)
  field(:newAlbumTitle, 3, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumDeletion do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumDeletion",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatMessengerSharedAlbumDeletion",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "sharedAlbumID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sharedAlbumID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "albumTitle",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "albumTitle",
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

  field(:sharedAlbumID, 1, optional: true, type: :int64)
  field(:albumTitle, 2, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumContentRemoval.RemovedContentTuple do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumContentRemoval.RemovedContentTuple",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "RemovedContentTuple",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "key",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "key",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "value",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "value",
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

  field(:key, 1, optional: true, type: :int64)
  field(:value, 2, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumContentRemoval do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumContentRemoval",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatMessengerSharedAlbumContentRemoval",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "sharedAlbumID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sharedAlbumID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "removedContentMap",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumContentRemoval.RemovedContentTuple",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "removedContentMap",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "removedContentCount",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "removedContentCount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "albumTitle",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "albumTitle",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "RemovedContentTuple",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "key",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "key",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "value",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "value",
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

  field(:sharedAlbumID, 1, optional: true, type: :int64)

  field(:removedContentMap, 2,
    repeated: true,
    type:
      WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumContentRemoval.RemovedContentTuple
  )

  field(:removedContentCount, 3, optional: true, type: :int64)
  field(:albumTitle, 4, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumAddition do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumAddition",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatMessengerSharedAlbumAddition",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "sharedAlbumID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sharedAlbumID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "albumTitle",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "albumTitle",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "numOfAttachments",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "numOfAttachments",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isAlbumCreation",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isAlbumCreation",
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

  field(:sharedAlbumID, 1, optional: true, type: :int64)
  field(:albumTitle, 2, optional: true, type: :string)
  field(:numOfAttachments, 3, optional: true, type: :int64)
  field(:isAlbumCreation, 4, optional: true, type: :bool)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerQRCodeScanned do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerQRCodeScanned",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatMessengerQRCodeScanned",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "receiverName",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "receiverName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "senderName",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "senderName",
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

  field(:receiverName, 1, optional: true, type: :string)
  field(:senderName, 2, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessagingLimitSharing do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessagingLimitSharing",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatMessagingLimitSharing",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "senderName",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "senderName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "senderID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "senderID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "limitSharingType",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "limitSharingType",
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

  field(:senderName, 1, optional: true, type: :string)
  field(:senderID, 2, optional: true, type: :string)
  field(:limitSharingType, 3, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMagicWords do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMagicWords",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatMagicWords",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "newMagicWordCount",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "newMagicWordCount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "removedMagicWordCount",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "removedMagicWordCount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "magicWord",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "magicWord",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "emojiEffect",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "emojiEffect",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isAllEdited",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isAllEdited",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "themeName",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "themeName",
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

  field(:newMagicWordCount, 1, optional: true, type: :int64)
  field(:removedMagicWordCount, 2, optional: true, type: :int64)
  field(:magicWord, 3, optional: true, type: :string)
  field(:emojiEffect, 4, optional: true, type: :string)
  field(:isAllEdited, 5, optional: true, type: :bool)
  field(:themeName, 6, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatLinkCTA do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatLinkCTA",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatLinkCTA",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "linkCtaXmatPrimaryText",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "linkCtaXmatPrimaryText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "linkCtaXmatCtaText",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "linkCtaXmatCtaText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "linkCtaXmatCtaURL",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "linkCtaXmatCtaURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "linkCtaXmatCtaIosURL",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "linkCtaXmatCtaIosURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "androidUri",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "androidUri",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "asyncURL",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "asyncURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "wwwIsAsyncURL",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "wwwIsAsyncURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "msiteEnabled",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "msiteEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "hideUriInFallback",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "hideUriInFallback",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "showConfirmationDialog",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "showConfirmationDialog",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "graphPayload",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "graphPayload",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "identifierName",
          extendee: nil,
          number: 12,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "identifierName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "threadID",
          extendee: nil,
          number: 13,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "threadID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "hideCtaInFallback",
          extendee: nil,
          number: 14,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "hideCtaInFallback",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ctxAdConversationStarterInfo",
          extendee: nil,
          number: 15,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ctxAdConversationStarterInfo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fbmUri",
          extendee: nil,
          number: 16,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fbmUri",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "initiatorUserID",
          extendee: nil,
          number: 17,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "initiatorUserID",
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

  field(:linkCtaXmatPrimaryText, 1, optional: true, type: :string)
  field(:linkCtaXmatCtaText, 2, optional: true, type: :string)
  field(:linkCtaXmatCtaURL, 3, optional: true, type: :string)
  field(:linkCtaXmatCtaIosURL, 4, optional: true, type: :string)
  field(:androidUri, 5, optional: true, type: :string)
  field(:asyncURL, 6, optional: true, type: :string)
  field(:wwwIsAsyncURL, 7, optional: true, type: :bool)
  field(:msiteEnabled, 8, optional: true, type: :bool)
  field(:hideUriInFallback, 9, optional: true, type: :bool)
  field(:showConfirmationDialog, 10, optional: true, type: :bool)
  field(:graphPayload, 11, optional: true, type: :string)
  field(:identifierName, 12, optional: true, type: :string)
  field(:threadID, 13, optional: true, type: :string)
  field(:hideCtaInFallback, 14, optional: true, type: :bool)
  field(:ctxAdConversationStarterInfo, 15, optional: true, type: :string)
  field(:fbmUri, 16, optional: true, type: :string)
  field(:initiatorUserID, 17, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatInstantGameEncryptedDynamicCustomUpdate do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatInstantGameEncryptedDynamicCustomUpdate",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatInstantGameEncryptedDynamicCustomUpdate",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "senderName",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "senderName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "muteManagementAdminTextType",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "muteManagementAdminTextType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "gameName",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "gameName",
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

  field(:senderName, 1, optional: true, type: :string)
  field(:muteManagementAdminTextType, 2, optional: true, type: :string)
  field(:gameName, 3, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatFriendRequestConfirmedEncrypted do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatFriendRequestConfirmedEncrypted",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatFriendRequestConfirmedEncrypted",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "otherUserName",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "otherUserName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isTurnOnCohort",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isTurnOnCohort",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "userWhoAcceptedFriendRequest",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "userWhoAcceptedFriendRequest",
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

  field(:otherUserName, 1, optional: true, type: :string)
  field(:isTurnOnCohort, 2, optional: true, type: :string)
  field(:userWhoAcceptedFriendRequest, 3, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatDisappearingSetting do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatDisappearingSetting",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmatDisappearingSetting",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "disappearingSettingTime",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "disappearingSettingTime",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "oldDisappearingSettingTime",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "oldDisappearingSettingTime",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "disappearingSettingActorFbid",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "disappearingSettingActorFbid",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "newEphemeralityType",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "newEphemeralityType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "oldEphemeralityType",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "oldEphemeralityType",
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

  field(:disappearingSettingTime, 1, optional: true, type: :int64)
  field(:oldDisappearingSettingTime, 2, optional: true, type: :int64)
  field(:disappearingSettingActorFbid, 3, optional: true, type: :int64)
  field(:newEphemeralityType, 4, optional: true, type: :int64)
  field(:oldEphemeralityType, 5, optional: true, type: :int64)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.DisappearingSettingChanged do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.DisappearingSettingChanged",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "DisappearingSettingChanged",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "disappearingSettingDurationSeconds",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "disappearingSettingDurationSeconds",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "oldDisappearingSettingDurationSeconds",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "oldDisappearingSettingDurationSeconds",
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

  field(:disappearingSettingDurationSeconds, 1, optional: true, type: :int32)
  field(:oldDisappearingSettingDurationSeconds, 2, optional: true, type: :int32)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.IconChanged do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.IconChanged",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "IconChanged",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "threadIcon",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "threadIcon",
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

  field(:threadIcon, 1, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LinkCta.UkOsaAdminText do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LinkCta.UkOsaAdminText",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "UkOsaAdminText",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "initiatorUserID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "initiatorUserID",
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

  field(:initiatorUserID, 2, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LinkCta do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LinkCta",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "LinkCta",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "ukOsaAdminText",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LinkCta.UkOsaAdminText",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "ukOsaAdminText",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "UkOsaAdminText",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "initiatorUserID",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "initiatorUserID",
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

  field(:ukOsaAdminText, 1,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LinkCta.UkOsaAdminText,
    oneof: 0
  )
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.QuickReactionChanged do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.QuickReactionChanged",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "QuickReactionChanged",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "emojiName",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "emojiName",
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

  field(:emojiName, 1, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupNameChanged do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupNameChanged",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "GroupNameChanged",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupName",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "groupName",
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

  field(:groupName, 1, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.NicknameChanged do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.NicknameChanged",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "NicknameChanged",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "targetUserID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "targetUserID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "nickname",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "nickname",
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

  field(:targetUserID, 1, optional: true, type: :string)
  field(:nickname, 2, optional: true, type: :string)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.ChatThemeChanged do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.ChatThemeChanged",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ChatThemeChanged",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "themeName",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "themeName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "themeEmoji",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "themeEmoji",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "themeType",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "themeType",
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

  field(:themeName, 1, optional: true, type: :string)
  field(:themeEmoji, 2, optional: true, type: :string)
  field(:themeType, 3, optional: true, type: :int32)
end

defmodule WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MiTransportAdminMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatThemeChanged",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.ChatThemeChanged",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "chatThemeChanged",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "nicknameChanged",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.NicknameChanged",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "nicknameChanged",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupParticipantChanged",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupParticipantChanged",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "groupParticipantChanged",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupAdminChanged",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupAdminChanged",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "groupAdminChanged",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupNameChanged",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupNameChanged",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "groupNameChanged",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupMembershipAddModeChanged",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupMembershipAddModeChanged",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "groupMembershipAddModeChanged",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messagePinned",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.MessagePinned",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "messagePinned",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupImageChanged",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupImageChanged",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "groupImageChanged",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "quickReactionChanged",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.QuickReactionChanged",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "quickReactionChanged",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "linkCta",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LinkCta",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "linkCta",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "iconChanged",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.IconChanged",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "iconChanged",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "disappearingSettingChanged",
          extendee: nil,
          number: 12,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.DisappearingSettingChanged",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "disappearingSettingChanged",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "limitSharingChanged",
          extendee: nil,
          number: 13,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LimitSharingChanged",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "limitSharingChanged",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatDisappearingSetting",
          extendee: nil,
          number: 14,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatDisappearingSetting",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatDisappearingSetting",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatFriendRequestConfirmedEncrypted",
          extendee: nil,
          number: 15,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatFriendRequestConfirmedEncrypted",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatFriendRequestConfirmedEncrypted",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatInstantGameEncryptedDynamicCustomUpdate",
          extendee: nil,
          number: 16,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatInstantGameEncryptedDynamicCustomUpdate",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatInstantGameEncryptedDynamicCustomUpdate",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatLinkCta",
          extendee: nil,
          number: 17,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatLinkCTA",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatLinkCta",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatMagicWords",
          extendee: nil,
          number: 18,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMagicWords",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatMagicWords",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatMessagingLimitSharing",
          extendee: nil,
          number: 19,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessagingLimitSharing",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatMessagingLimitSharing",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatMessengerQrCodeScanned",
          extendee: nil,
          number: 20,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerQRCodeScanned",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatMessengerQrCodeScanned",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatMessengerSharedAlbumAddition",
          extendee: nil,
          number: 21,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumAddition",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatMessengerSharedAlbumAddition",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatMessengerSharedAlbumContentRemoval",
          extendee: nil,
          number: 22,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumContentRemoval",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatMessengerSharedAlbumContentRemoval",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatMessengerSharedAlbumDeletion",
          extendee: nil,
          number: 23,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumDeletion",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatMessengerSharedAlbumDeletion",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatMessengerSharedAlbumRename",
          extendee: nil,
          number: 24,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumRename",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatMessengerSharedAlbumRename",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatMessengerSharedAlbum",
          extendee: nil,
          number: 25,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbum",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatMessengerSharedAlbum",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatThemeColor",
          extendee: nil,
          number: 26,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatThemeColor",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatThemeColor",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatThreadIcon",
          extendee: nil,
          number: 27,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatThreadIcon",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatThreadIcon",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatThreadNickname",
          extendee: nil,
          number: 28,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatThreadNickname",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatThreadNickname",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatThreadQuickReaction",
          extendee: nil,
          number: 29,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatThreadQuickReaction",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatThreadQuickReaction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatUpdatePayments",
          extendee: nil,
          number: 30,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatUpdatePayments",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatUpdatePayments",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatPinMessageV2",
          extendee: nil,
          number: 31,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatPinMessageV2",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatPinMessageV2",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatUnpinMessageV2",
          extendee: nil,
          number: 32,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatUnpinMessageV2",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatUnpinMessageV2",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatGenaiTaskAdd",
          extendee: nil,
          number: 33,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatGenAITaskAdd",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatGenaiTaskAdd",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatAddParticipants",
          extendee: nil,
          number: 37,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatAddParticipants",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatAddParticipants",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatRemoveParticipant",
          extendee: nil,
          number: 38,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatRemoveParticipant",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatRemoveParticipant",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatChangeThreadAdmins",
          extendee: nil,
          number: 39,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatChangeThreadAdmins",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatChangeThreadAdmins",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatChangeThreadName",
          extendee: nil,
          number: 40,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatChangeThreadName",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatChangeThreadName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatGroupThreadCreated",
          extendee: nil,
          number: 41,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatGroupThreadCreated",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatGroupThreadCreated",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatSetParticipantUpdateMode",
          extendee: nil,
          number: 42,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatSetParticipantUpdateMode",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatSetParticipantUpdateMode",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatMessengerMessageReminderSet",
          extendee: nil,
          number: 43,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerMessageReminderSet",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatMessengerMessageReminderSet",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmatMessengerMessageReminderTriggered",
          extendee: nil,
          number: 44,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerMessageReminderTriggered",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "xmatMessengerMessageReminderTriggered",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "skipBumpThread",
          extendee: nil,
          number: 34,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "skipBumpThread",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "skipSnippetUpdate",
          extendee: nil,
          number: 35,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "skipSnippetUpdate",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "readonlyMetadataDataclass",
          extendee: nil,
          number: 36,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "readonlyMetadataDataclass",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "LimitSharingChanged",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "sharingType",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LimitSharingChanged.SharingType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sharingType",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "SharingType",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UNSET",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "DISABLED",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "ENABLED",
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
          name: "GroupImageChanged",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "action",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupImageChanged.Action",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "action",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "Action",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UNSET",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "CHANGED",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "REMOVED",
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
          name: "MessagePinned",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "action",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.MessagePinned.Action",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "action",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "Action",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UNSET",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "PINNED",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UNPINNED",
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
          name: "GroupMembershipAddModeChanged",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "mode",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupMembershipAddModeChanged.Mode",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "mode",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "Mode",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UNSET",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "ALL_MEMBERS",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "ADMINS_ONLY",
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
          name: "GroupAdminChanged",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "targetUserID",
              extendee: nil,
              number: 1,
              label: :LABEL_REPEATED,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "targetUserID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "action",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupAdminChanged.Action",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "action",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "Action",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UNSET",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "ADDED",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "REMOVED",
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
          name: "GroupParticipantChanged",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "targetUserID",
              extendee: nil,
              number: 1,
              label: :LABEL_REPEATED,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "targetUserID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "action",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupParticipantChanged.Action",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "action",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "Action",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UNSET",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "ADDED",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "REMOVED",
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
          name: "XmatMessengerMessageReminderTriggered",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "offlineThreadingID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "offlineThreadingID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "scheduledTime",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "scheduledTime",
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
          name: "XmatMessengerMessageReminderSet",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "offlineThreadingID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "offlineThreadingID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "scheduledTime",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "scheduledTime",
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
          name: "XmatSetParticipantUpdateMode",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "participantUpdateMode",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "participantUpdateMode",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "setterID",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "setterID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "transportThreadFbid",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "transportThreadFbid",
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
          name: "XmatGroupThreadCreated",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "threadSubtype",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "threadSubtype",
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
          name: "XmatChangeThreadName",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "newThreadName",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "newThreadName",
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
          name: "XmatChangeThreadAdmins",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "adminEvent",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "adminEvent",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "targetID",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "targetID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "threadCategory",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "threadCategory",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "adminType",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "adminType",
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
          name: "XmatRemoveParticipant",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "removedParticipantFbid",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "removedParticipantFbid",
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
          name: "XmatAddParticipants",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "participantsAdded",
              extendee: nil,
              number: 1,
              label: :LABEL_REPEATED,
              type: :TYPE_INT64,
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
              json_name: "participantsAdded",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "addedThroughJoinRequests",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "addedThroughJoinRequests",
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
          name: "XmatGenAITaskAdd",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "taskID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "taskID",
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
          name: "XmatUnpinMessageV2",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "pinnedMessageID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "pinnedMessageID",
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
          name: "XmatPinMessageV2",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "pinnedMessageID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "pinnedMessageID",
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
          name: "XmatUpdatePayments",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "receiverName",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "receiverName",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "senderName",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "senderName",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "amount",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_FLOAT,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "amount",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "transactionID",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "transactionID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "transactionStatus",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "transactionStatus",
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
          name: "XmatThreadQuickReaction",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "threadQuickReactionEmoji",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "threadQuickReactionEmoji",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "threadQuickReactionInstructionKeyID",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "threadQuickReactionInstructionKeyID",
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
          name: "XmatThreadNickname",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "participantID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "participantID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "nickname",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "nickname",
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
          name: "XmatThreadIcon",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "threadIcon",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "threadIcon",
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
          name: "XmatThemeColor",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "themeID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "themeID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "themeColor",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "themeColor",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "gradient",
              extendee: nil,
              number: 3,
              label: :LABEL_REPEATED,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "gradient",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "shouldShowIcon",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "shouldShowIcon",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "themeType",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "themeType",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "accessibilityLabel",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "accessibilityLabel",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "themeNameWithSubtitle",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "themeNameWithSubtitle",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "themeEmoji",
              extendee: nil,
              number: 8,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "themeEmoji",
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
          name: "XmatMessengerSharedAlbum",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "xmaDataclass",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "xmaDataclass",
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
          name: "XmatMessengerSharedAlbumRename",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "sharedAlbumID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sharedAlbumID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "oldAlbumTitle",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "oldAlbumTitle",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "newAlbumTitle",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "newAlbumTitle",
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
          name: "XmatMessengerSharedAlbumDeletion",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "sharedAlbumID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sharedAlbumID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "albumTitle",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "albumTitle",
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
          name: "XmatMessengerSharedAlbumContentRemoval",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "sharedAlbumID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sharedAlbumID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "removedContentMap",
              extendee: nil,
              number: 2,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumContentRemoval.RemovedContentTuple",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "removedContentMap",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "removedContentCount",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "removedContentCount",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "albumTitle",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "albumTitle",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "RemovedContentTuple",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "key",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_INT64,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "key",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "value",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "value",
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
          name: "XmatMessengerSharedAlbumAddition",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "sharedAlbumID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sharedAlbumID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "albumTitle",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "albumTitle",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "numOfAttachments",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "numOfAttachments",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "isAlbumCreation",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "isAlbumCreation",
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
          name: "XmatMessengerQRCodeScanned",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "receiverName",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "receiverName",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "senderName",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "senderName",
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
          name: "XmatMessagingLimitSharing",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "senderName",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "senderName",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "senderID",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "senderID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "limitSharingType",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "limitSharingType",
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
          name: "XmatMagicWords",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "newMagicWordCount",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "newMagicWordCount",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "removedMagicWordCount",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "removedMagicWordCount",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "magicWord",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "magicWord",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "emojiEffect",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "emojiEffect",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "isAllEdited",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "isAllEdited",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "themeName",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "themeName",
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
          name: "XmatLinkCTA",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "linkCtaXmatPrimaryText",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "linkCtaXmatPrimaryText",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "linkCtaXmatCtaText",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "linkCtaXmatCtaText",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "linkCtaXmatCtaURL",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "linkCtaXmatCtaURL",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "linkCtaXmatCtaIosURL",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "linkCtaXmatCtaIosURL",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "androidUri",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "androidUri",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "asyncURL",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "asyncURL",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "wwwIsAsyncURL",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "wwwIsAsyncURL",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "msiteEnabled",
              extendee: nil,
              number: 8,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "msiteEnabled",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "hideUriInFallback",
              extendee: nil,
              number: 9,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "hideUriInFallback",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "showConfirmationDialog",
              extendee: nil,
              number: 10,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "showConfirmationDialog",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "graphPayload",
              extendee: nil,
              number: 11,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "graphPayload",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "identifierName",
              extendee: nil,
              number: 12,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "identifierName",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "threadID",
              extendee: nil,
              number: 13,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "threadID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "hideCtaInFallback",
              extendee: nil,
              number: 14,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "hideCtaInFallback",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "ctxAdConversationStarterInfo",
              extendee: nil,
              number: 15,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "ctxAdConversationStarterInfo",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "fbmUri",
              extendee: nil,
              number: 16,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "fbmUri",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "initiatorUserID",
              extendee: nil,
              number: 17,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "initiatorUserID",
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
          name: "XmatInstantGameEncryptedDynamicCustomUpdate",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "senderName",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "senderName",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "muteManagementAdminTextType",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "muteManagementAdminTextType",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "gameName",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "gameName",
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
          name: "XmatFriendRequestConfirmedEncrypted",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "otherUserName",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "otherUserName",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "isTurnOnCohort",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "isTurnOnCohort",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "userWhoAcceptedFriendRequest",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "userWhoAcceptedFriendRequest",
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
          name: "XmatDisappearingSetting",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "disappearingSettingTime",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "disappearingSettingTime",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "oldDisappearingSettingTime",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "oldDisappearingSettingTime",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "disappearingSettingActorFbid",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "disappearingSettingActorFbid",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "newEphemeralityType",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "newEphemeralityType",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "oldEphemeralityType",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "oldEphemeralityType",
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
          name: "DisappearingSettingChanged",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "disappearingSettingDurationSeconds",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "disappearingSettingDurationSeconds",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "oldDisappearingSettingDurationSeconds",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "oldDisappearingSettingDurationSeconds",
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
          name: "IconChanged",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "threadIcon",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "threadIcon",
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
          name: "LinkCta",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "ukOsaAdminText",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LinkCta.UkOsaAdminText",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "ukOsaAdminText",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "UkOsaAdminText",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "initiatorUserID",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "initiatorUserID",
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
          name: "QuickReactionChanged",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "emojiName",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "emojiName",
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
          name: "GroupNameChanged",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "groupName",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "groupName",
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
          name: "NicknameChanged",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "targetUserID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "targetUserID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "nickname",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "nickname",
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
          name: "ChatThemeChanged",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "themeName",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "themeName",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "themeEmoji",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "themeEmoji",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "themeType",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "themeType",
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

  field(:chatThemeChanged, 1,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.ChatThemeChanged,
    oneof: 0
  )

  field(:nicknameChanged, 2,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.NicknameChanged,
    oneof: 0
  )

  field(:groupParticipantChanged, 3,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupParticipantChanged,
    oneof: 0
  )

  field(:groupAdminChanged, 4,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupAdminChanged,
    oneof: 0
  )

  field(:groupNameChanged, 5,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupNameChanged,
    oneof: 0
  )

  field(:groupMembershipAddModeChanged, 6,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupMembershipAddModeChanged,
    oneof: 0
  )

  field(:messagePinned, 7,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.MessagePinned,
    oneof: 0
  )

  field(:groupImageChanged, 8,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.GroupImageChanged,
    oneof: 0
  )

  field(:quickReactionChanged, 9,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.QuickReactionChanged,
    oneof: 0
  )

  field(:linkCta, 10,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LinkCta,
    oneof: 0
  )

  field(:iconChanged, 11,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.IconChanged,
    oneof: 0
  )

  field(:disappearingSettingChanged, 12,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.DisappearingSettingChanged,
    oneof: 0
  )

  field(:limitSharingChanged, 13,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.LimitSharingChanged,
    oneof: 0
  )

  field(:xmatDisappearingSetting, 14,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatDisappearingSetting,
    oneof: 0
  )

  field(:xmatFriendRequestConfirmedEncrypted, 15,
    optional: true,
    type:
      WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatFriendRequestConfirmedEncrypted,
    oneof: 0
  )

  field(:xmatInstantGameEncryptedDynamicCustomUpdate, 16,
    optional: true,
    type:
      WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatInstantGameEncryptedDynamicCustomUpdate,
    oneof: 0
  )

  field(:xmatLinkCta, 17,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatLinkCTA,
    oneof: 0
  )

  field(:xmatMagicWords, 18,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMagicWords,
    oneof: 0
  )

  field(:xmatMessagingLimitSharing, 19,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessagingLimitSharing,
    oneof: 0
  )

  field(:xmatMessengerQrCodeScanned, 20,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerQRCodeScanned,
    oneof: 0
  )

  field(:xmatMessengerSharedAlbumAddition, 21,
    optional: true,
    type:
      WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumAddition,
    oneof: 0
  )

  field(:xmatMessengerSharedAlbumContentRemoval, 22,
    optional: true,
    type:
      WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumContentRemoval,
    oneof: 0
  )

  field(:xmatMessengerSharedAlbumDeletion, 23,
    optional: true,
    type:
      WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumDeletion,
    oneof: 0
  )

  field(:xmatMessengerSharedAlbumRename, 24,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbumRename,
    oneof: 0
  )

  field(:xmatMessengerSharedAlbum, 25,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerSharedAlbum,
    oneof: 0
  )

  field(:xmatThemeColor, 26,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatThemeColor,
    oneof: 0
  )

  field(:xmatThreadIcon, 27,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatThreadIcon,
    oneof: 0
  )

  field(:xmatThreadNickname, 28,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatThreadNickname,
    oneof: 0
  )

  field(:xmatThreadQuickReaction, 29,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatThreadQuickReaction,
    oneof: 0
  )

  field(:xmatUpdatePayments, 30,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatUpdatePayments,
    oneof: 0
  )

  field(:xmatPinMessageV2, 31,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatPinMessageV2,
    oneof: 0
  )

  field(:xmatUnpinMessageV2, 32,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatUnpinMessageV2,
    oneof: 0
  )

  field(:xmatGenaiTaskAdd, 33,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatGenAITaskAdd,
    oneof: 0
  )

  field(:xmatAddParticipants, 37,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatAddParticipants,
    oneof: 0
  )

  field(:xmatRemoveParticipant, 38,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatRemoveParticipant,
    oneof: 0
  )

  field(:xmatChangeThreadAdmins, 39,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatChangeThreadAdmins,
    oneof: 0
  )

  field(:xmatChangeThreadName, 40,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatChangeThreadName,
    oneof: 0
  )

  field(:xmatGroupThreadCreated, 41,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatGroupThreadCreated,
    oneof: 0
  )

  field(:xmatSetParticipantUpdateMode, 42,
    optional: true,
    type: WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatSetParticipantUpdateMode,
    oneof: 0
  )

  field(:xmatMessengerMessageReminderSet, 43,
    optional: true,
    type:
      WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerMessageReminderSet,
    oneof: 0
  )

  field(:xmatMessengerMessageReminderTriggered, 44,
    optional: true,
    type:
      WAArmadilloMiTransportAdminMessage.MiTransportAdminMessage.XmatMessengerMessageReminderTriggered,
    oneof: 0
  )

  field(:skipBumpThread, 34, optional: true, type: :bool)
  field(:skipSnippetUpdate, 35, optional: true, type: :bool)
  field(:readonlyMetadataDataclass, 36, optional: true, type: :string)
end
