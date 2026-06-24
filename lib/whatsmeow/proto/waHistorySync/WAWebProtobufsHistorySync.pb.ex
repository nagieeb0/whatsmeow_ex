defmodule WAWebProtobufsHistorySync.MediaVisibility do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsHistorySync.MediaVisibility",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "MediaVisibility",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DEFAULT",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "OFF",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ON",
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

  field(:DEFAULT, 0)
  field(:OFF, 1)
  field(:ON, 2)
end

defmodule WAWebProtobufsHistorySync.PrivacySystemMessage do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsHistorySync.PrivacySystemMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "PrivacySystemMessage",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "E2EE_MSG",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NE2EE_SELF",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NE2EE_OTHER",
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

  field(:E2EE_MSG, 1)
  field(:NE2EE_SELF, 2)
  field(:NE2EE_OTHER, 3)
end

defmodule WAWebProtobufsHistorySync.HistorySync.BotAIWaitListState do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsHistorySync.HistorySync.BotAIWaitListState",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotAIWaitListState",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IN_WAITLIST",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_AVAILABLE",
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

  field(:IN_WAITLIST, 0)
  field(:AI_AVAILABLE, 1)
end

defmodule WAWebProtobufsHistorySync.HistorySync.HistorySyncType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsHistorySync.HistorySync.HistorySyncType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "HistorySyncType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INITIAL_BOOTSTRAP",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INITIAL_STATUS_V3",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FULL",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RECENT",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PUSH_NAME",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NON_BLOCKING_DATA",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ON_DEMAND",
          number: 6,
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

  field(:INITIAL_BOOTSTRAP, 0)
  field(:INITIAL_STATUS_V3, 1)
  field(:FULL, 2)
  field(:RECENT, 3)
  field(:PUSH_NAME, 4)
  field(:NON_BLOCKING_DATA, 5)
  field(:ON_DEMAND, 6)
end

defmodule WAWebProtobufsHistorySync.Conversation.GroupAppealStatus do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsHistorySync.Conversation.GroupAppealStatus",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "GroupAppealStatus",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NO_APPEAL",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "APPEAL_IN_REVIEW",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "APPEAL_APPROVED",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "APPEAL_REJECTED",
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

  field(:NO_APPEAL, 0)
  field(:APPEAL_IN_REVIEW, 1)
  field(:APPEAL_APPROVED, 2)
  field(:APPEAL_REJECTED, 3)
end

defmodule WAWebProtobufsHistorySync.Conversation.EndOfHistoryTransferType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsHistorySync.Conversation.EndOfHistoryTransferType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "EndOfHistoryTransferType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMPLETE_BUT_MORE_MESSAGES_REMAIN_ON_PRIMARY",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMPLETE_AND_NO_MORE_MESSAGE_REMAIN_ON_PRIMARY",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMPLETE_ON_DEMAND_SYNC_BUT_MORE_MSG_REMAIN_ON_PRIMARY",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMPLETE_ON_DEMAND_SYNC_WITH_MORE_MSG_ON_PRIMARY_BUT_NO_ACCESS",
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

  field(:COMPLETE_BUT_MORE_MESSAGES_REMAIN_ON_PRIMARY, 0)
  field(:COMPLETE_AND_NO_MORE_MESSAGE_REMAIN_ON_PRIMARY, 1)
  field(:COMPLETE_ON_DEMAND_SYNC_BUT_MORE_MSG_REMAIN_ON_PRIMARY, 2)
  field(:COMPLETE_ON_DEMAND_SYNC_WITH_MORE_MSG_ON_PRIMARY_BUT_NO_ACCESS, 3)
end

defmodule WAWebProtobufsHistorySync.GroupParticipant.Rank do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsHistorySync.GroupParticipant.Rank",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Rank",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REGULAR",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ADMIN",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SUPERADMIN",
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

  field(:REGULAR, 0)
  field(:ADMIN, 1)
  field(:SUPERADMIN, 2)
end

defmodule WAWebProtobufsHistorySync.PastParticipant.LeaveReason do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsHistorySync.PastParticipant.LeaveReason",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "LeaveReason",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LEFT",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REMOVED",
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

  field(:LEFT, 0)
  field(:REMOVED, 1)
end

defmodule WAWebProtobufsHistorySync.HistorySync do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsHistorySync.HistorySync",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "HistorySync",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "syncType",
          extendee: nil,
          number: 1,
          label: :LABEL_REQUIRED,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsHistorySync.HistorySync.HistorySyncType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "syncType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "conversations",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.Conversation",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "conversations",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "statusV3Messages",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.WebMessageInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "statusV3Messages",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "chunkOrder",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "chunkOrder",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "progress",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "progress",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pushnames",
          extendee: nil,
          number: 7,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.Pushname",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pushnames",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "globalSettings",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.GlobalSettings",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "globalSettings",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "threadIDUserSecret",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "threadIDUserSecret",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "threadDsTimeframeOffset",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "threadDsTimeframeOffset",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "recentStickers",
          extendee: nil,
          number: 11,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.StickerMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "recentStickers",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pastParticipants",
          extendee: nil,
          number: 12,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.PastParticipants",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pastParticipants",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "callLogRecords",
          extendee: nil,
          number: 13,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.CallLogRecord",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "callLogRecords",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "aiWaitListState",
          extendee: nil,
          number: 14,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsHistorySync.HistorySync.BotAIWaitListState",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "aiWaitListState",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "phoneNumberToLidMappings",
          extendee: nil,
          number: 15,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.PhoneNumberToLIDMapping",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "phoneNumberToLidMappings",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "companionMetaNonce",
          extendee: nil,
          number: 16,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "companionMetaNonce",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "shareableChatIdentifierEncryptionKey",
          extendee: nil,
          number: 17,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "shareableChatIdentifierEncryptionKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "accounts",
          extendee: nil,
          number: 18,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.Account",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "accounts",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "nctSalt",
          extendee: nil,
          number: 19,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "nctSalt",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "inlineContacts",
          extendee: nil,
          number: 20,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.InlineContact",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "inlineContacts",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "inlineContactsProvided",
          extendee: nil,
          number: 21,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "inlineContactsProvided",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "BotAIWaitListState",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IN_WAITLIST",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_AVAILABLE",
              number: 1,
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
          name: "HistorySyncType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INITIAL_BOOTSTRAP",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INITIAL_STATUS_V3",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FULL",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RECENT",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PUSH_NAME",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NON_BLOCKING_DATA",
              number: 5,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ON_DEMAND",
              number: 6,
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

  field(:syncType, 1,
    required: true,
    type: WAWebProtobufsHistorySync.HistorySync.HistorySyncType,
    enum: true
  )

  field(:conversations, 2, repeated: true, type: WAWebProtobufsHistorySync.Conversation)
  field(:statusV3Messages, 3, repeated: true, type: WAWebProtobufsWeb.WebMessageInfo)
  field(:chunkOrder, 5, optional: true, type: :uint32)
  field(:progress, 6, optional: true, type: :uint32)
  field(:pushnames, 7, repeated: true, type: WAWebProtobufsHistorySync.Pushname)
  field(:globalSettings, 8, optional: true, type: WAWebProtobufsHistorySync.GlobalSettings)
  field(:threadIDUserSecret, 9, optional: true, type: :bytes)
  field(:threadDsTimeframeOffset, 10, optional: true, type: :uint32)
  field(:recentStickers, 11, repeated: true, type: WAWebProtobufsHistorySync.StickerMetadata)
  field(:pastParticipants, 12, repeated: true, type: WAWebProtobufsHistorySync.PastParticipants)
  field(:callLogRecords, 13, repeated: true, type: WAWebProtobufSyncAction.CallLogRecord)

  field(:aiWaitListState, 14,
    optional: true,
    type: WAWebProtobufsHistorySync.HistorySync.BotAIWaitListState,
    enum: true
  )

  field(:phoneNumberToLidMappings, 15,
    repeated: true,
    type: WAWebProtobufsHistorySync.PhoneNumberToLIDMapping
  )

  field(:companionMetaNonce, 16, optional: true, type: :string)
  field(:shareableChatIdentifierEncryptionKey, 17, optional: true, type: :bytes)
  field(:accounts, 18, repeated: true, type: WAWebProtobufsHistorySync.Account)
  field(:nctSalt, 19, optional: true, type: :bytes)
  field(:inlineContacts, 20, repeated: true, type: WAWebProtobufsHistorySync.InlineContact)
  field(:inlineContactsProvided, 21, optional: true, type: :bool)
end

defmodule WAWebProtobufsHistorySync.Conversation do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsHistorySync.Conversation",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Conversation",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "ID",
          extendee: nil,
          number: 1,
          label: :LABEL_REQUIRED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messages",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.HistorySyncMsg",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messages",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "newJID",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "newJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "oldJID",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "oldJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lastMsgTimestamp",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lastMsgTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "unreadCount",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "unreadCount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "readOnly",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "readOnly",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "endOfHistoryTransfer",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "endOfHistoryTransfer",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralExpiration",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeralExpiration",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralSettingTimestamp",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeralSettingTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "endOfHistoryTransferType",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsHistorySync.Conversation.EndOfHistoryTransferType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "endOfHistoryTransferType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "conversationTimestamp",
          extendee: nil,
          number: 12,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "conversationTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "name",
          extendee: nil,
          number: 13,
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
          name: "pHash",
          extendee: nil,
          number: 14,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pHash",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "notSpam",
          extendee: nil,
          number: 15,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "notSpam",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "archived",
          extendee: nil,
          number: 16,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "archived",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "disappearingMode",
          extendee: nil,
          number: 17,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsE2E.DisappearingMode",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "disappearingMode",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "unreadMentionCount",
          extendee: nil,
          number: 18,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "unreadMentionCount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "markedAsUnread",
          extendee: nil,
          number: 19,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "markedAsUnread",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "participant",
          extendee: nil,
          number: 20,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.GroupParticipant",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "participant",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "tcToken",
          extendee: nil,
          number: 21,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "tcToken",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "tcTokenTimestamp",
          extendee: nil,
          number: 22,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "tcTokenTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "contactPrimaryIdentityKey",
          extendee: nil,
          number: 23,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "contactPrimaryIdentityKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pinned",
          extendee: nil,
          number: 24,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pinned",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "muteEndTime",
          extendee: nil,
          number: 25,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "muteEndTime",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "wallpaper",
          extendee: nil,
          number: 26,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.WallpaperSettings",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "wallpaper",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaVisibility",
          extendee: nil,
          number: 27,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsHistorySync.MediaVisibility",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaVisibility",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "tcTokenSenderTimestamp",
          extendee: nil,
          number: 28,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "tcTokenSenderTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "suspended",
          extendee: nil,
          number: 29,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "suspended",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "terminated",
          extendee: nil,
          number: 30,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "terminated",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "createdAt",
          extendee: nil,
          number: 31,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "createdAt",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "createdBy",
          extendee: nil,
          number: 32,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "createdBy",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "description",
          extendee: nil,
          number: 33,
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
          name: "support",
          extendee: nil,
          number: 34,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "support",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isParentGroup",
          extendee: nil,
          number: 35,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isParentGroup",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "parentGroupID",
          extendee: nil,
          number: 37,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "parentGroupID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isDefaultSubgroup",
          extendee: nil,
          number: 36,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isDefaultSubgroup",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "displayName",
          extendee: nil,
          number: 38,
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
          name: "pnJID",
          extendee: nil,
          number: 39,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pnJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "shareOwnPn",
          extendee: nil,
          number: 40,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "shareOwnPn",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pnhDuplicateLidThread",
          extendee: nil,
          number: 41,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pnhDuplicateLidThread",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lidJID",
          extendee: nil,
          number: 42,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lidJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "username",
          extendee: nil,
          number: 43,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "username",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lidOriginType",
          extendee: nil,
          number: 44,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lidOriginType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "commentsCount",
          extendee: nil,
          number: 45,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "commentsCount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "locked",
          extendee: nil,
          number: 46,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "locked",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "systemMessageToInsert",
          extendee: nil,
          number: 47,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsHistorySync.PrivacySystemMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "systemMessageToInsert",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "capiCreatedGroup",
          extendee: nil,
          number: 48,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "capiCreatedGroup",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "accountLid",
          extendee: nil,
          number: 49,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "accountLid",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "limitSharing",
          extendee: nil,
          number: 50,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "limitSharing",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "limitSharingSettingTimestamp",
          extendee: nil,
          number: 51,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "limitSharingSettingTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "limitSharingTrigger",
          extendee: nil,
          number: 52,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WACommon.LimitSharing.Trigger",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "limitSharingTrigger",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "limitSharingInitiatedByMe",
          extendee: nil,
          number: 53,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "limitSharingInitiatedByMe",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "maibaAiThreadEnabled",
          extendee: nil,
          number: 54,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "maibaAiThreadEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isMarketingMessageThread",
          extendee: nil,
          number: 55,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isMarketingMessageThread",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isSenderNewAccount",
          extendee: nil,
          number: 56,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isSenderNewAccount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "afterReadDuration",
          extendee: nil,
          number: 57,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "afterReadDuration",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isSenderSuspicious",
          extendee: nil,
          number: 58,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isSenderSuspicious",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "appealStatus",
          extendee: nil,
          number: 59,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsHistorySync.Conversation.GroupAppealStatus",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "appealStatus",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "appealUpdateTime",
          extendee: nil,
          number: 60,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "appealUpdateTime",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "authAgentParentCompanyName",
          extendee: nil,
          number: 61,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "authAgentParentCompanyName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "authAgentObaPhoneNumber",
          extendee: nil,
          number: 62,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "authAgentObaPhoneNumber",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "GroupAppealStatus",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NO_APPEAL",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "APPEAL_IN_REVIEW",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "APPEAL_APPROVED",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "APPEAL_REJECTED",
              number: 3,
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
          name: "EndOfHistoryTransferType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMPLETE_BUT_MORE_MESSAGES_REMAIN_ON_PRIMARY",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMPLETE_AND_NO_MORE_MESSAGE_REMAIN_ON_PRIMARY",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMPLETE_ON_DEMAND_SYNC_BUT_MORE_MSG_REMAIN_ON_PRIMARY",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMPLETE_ON_DEMAND_SYNC_WITH_MORE_MSG_ON_PRIMARY_BUT_NO_ACCESS",
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

  field(:ID, 1, required: true, type: :string)
  field(:messages, 2, repeated: true, type: WAWebProtobufsHistorySync.HistorySyncMsg)
  field(:newJID, 3, optional: true, type: :string)
  field(:oldJID, 4, optional: true, type: :string)
  field(:lastMsgTimestamp, 5, optional: true, type: :uint64)
  field(:unreadCount, 6, optional: true, type: :uint32)
  field(:readOnly, 7, optional: true, type: :bool)
  field(:endOfHistoryTransfer, 8, optional: true, type: :bool)
  field(:ephemeralExpiration, 9, optional: true, type: :uint32)
  field(:ephemeralSettingTimestamp, 10, optional: true, type: :int64)

  field(:endOfHistoryTransferType, 11,
    optional: true,
    type: WAWebProtobufsHistorySync.Conversation.EndOfHistoryTransferType,
    enum: true
  )

  field(:conversationTimestamp, 12, optional: true, type: :uint64)
  field(:name, 13, optional: true, type: :string)
  field(:pHash, 14, optional: true, type: :string)
  field(:notSpam, 15, optional: true, type: :bool)
  field(:archived, 16, optional: true, type: :bool)
  field(:disappearingMode, 17, optional: true, type: WAWebProtobufsE2E.DisappearingMode)
  field(:unreadMentionCount, 18, optional: true, type: :uint32)
  field(:markedAsUnread, 19, optional: true, type: :bool)
  field(:participant, 20, repeated: true, type: WAWebProtobufsHistorySync.GroupParticipant)
  field(:tcToken, 21, optional: true, type: :bytes)
  field(:tcTokenTimestamp, 22, optional: true, type: :uint64)
  field(:contactPrimaryIdentityKey, 23, optional: true, type: :bytes)
  field(:pinned, 24, optional: true, type: :uint32)
  field(:muteEndTime, 25, optional: true, type: :uint64)
  field(:wallpaper, 26, optional: true, type: WAWebProtobufsHistorySync.WallpaperSettings)

  field(:mediaVisibility, 27,
    optional: true,
    type: WAWebProtobufsHistorySync.MediaVisibility,
    enum: true
  )

  field(:tcTokenSenderTimestamp, 28, optional: true, type: :uint64)
  field(:suspended, 29, optional: true, type: :bool)
  field(:terminated, 30, optional: true, type: :bool)
  field(:createdAt, 31, optional: true, type: :uint64)
  field(:createdBy, 32, optional: true, type: :string)
  field(:description, 33, optional: true, type: :string)
  field(:support, 34, optional: true, type: :bool)
  field(:isParentGroup, 35, optional: true, type: :bool)
  field(:parentGroupID, 37, optional: true, type: :string)
  field(:isDefaultSubgroup, 36, optional: true, type: :bool)
  field(:displayName, 38, optional: true, type: :string)
  field(:pnJID, 39, optional: true, type: :string)
  field(:shareOwnPn, 40, optional: true, type: :bool)
  field(:pnhDuplicateLidThread, 41, optional: true, type: :bool)
  field(:lidJID, 42, optional: true, type: :string)
  field(:username, 43, optional: true, type: :string)
  field(:lidOriginType, 44, optional: true, type: :string)
  field(:commentsCount, 45, optional: true, type: :uint32)
  field(:locked, 46, optional: true, type: :bool)

  field(:systemMessageToInsert, 47,
    optional: true,
    type: WAWebProtobufsHistorySync.PrivacySystemMessage,
    enum: true
  )

  field(:capiCreatedGroup, 48, optional: true, type: :bool)
  field(:accountLid, 49, optional: true, type: :string)
  field(:limitSharing, 50, optional: true, type: :bool)
  field(:limitSharingSettingTimestamp, 51, optional: true, type: :int64)
  field(:limitSharingTrigger, 52, optional: true, type: WACommon.LimitSharing.Trigger, enum: true)
  field(:limitSharingInitiatedByMe, 53, optional: true, type: :bool)
  field(:maibaAiThreadEnabled, 54, optional: true, type: :bool)
  field(:isMarketingMessageThread, 55, optional: true, type: :bool)
  field(:isSenderNewAccount, 56, optional: true, type: :bool)
  field(:afterReadDuration, 57, optional: true, type: :uint32)
  field(:isSenderSuspicious, 58, optional: true, type: :bool)

  field(:appealStatus, 59,
    optional: true,
    type: WAWebProtobufsHistorySync.Conversation.GroupAppealStatus,
    enum: true
  )

  field(:appealUpdateTime, 60, optional: true, type: :uint64)
  field(:authAgentParentCompanyName, 61, optional: true, type: :string)
  field(:authAgentObaPhoneNumber, 62, optional: true, type: :string)
end

defmodule WAWebProtobufsHistorySync.GroupParticipant do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsHistorySync.GroupParticipant",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "GroupParticipant",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "userJID",
          extendee: nil,
          number: 1,
          label: :LABEL_REQUIRED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "userJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "rank",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsHistorySync.GroupParticipant.Rank",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "rank",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "memberLabel",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsE2E.MemberLabel",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "memberLabel",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "Rank",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REGULAR",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ADMIN",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SUPERADMIN",
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

  field(:userJID, 1, required: true, type: :string)

  field(:rank, 2,
    optional: true,
    type: WAWebProtobufsHistorySync.GroupParticipant.Rank,
    enum: true
  )

  field(:memberLabel, 3, optional: true, type: WAWebProtobufsE2E.MemberLabel)
end

defmodule WAWebProtobufsHistorySync.PastParticipant do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsHistorySync.PastParticipant",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PastParticipant",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "userJID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "userJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "leaveReason",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsHistorySync.PastParticipant.LeaveReason",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "leaveReason",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "leaveTS",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "leaveTS",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "LeaveReason",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "LEFT",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REMOVED",
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

  field(:userJID, 1, optional: true, type: :string)

  field(:leaveReason, 2,
    optional: true,
    type: WAWebProtobufsHistorySync.PastParticipant.LeaveReason,
    enum: true
  )

  field(:leaveTS, 3, optional: true, type: :uint64)
end

defmodule WAWebProtobufsHistorySync.PhoneNumberToLIDMapping do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsHistorySync.PhoneNumberToLIDMapping",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PhoneNumberToLIDMapping",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "pnJID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pnJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lidJID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lidJID",
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

  field(:pnJID, 1, optional: true, type: :string)
  field(:lidJID, 2, optional: true, type: :string)
end

defmodule WAWebProtobufsHistorySync.InlineContact do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsHistorySync.InlineContact",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "InlineContact",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "pnJID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pnJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lidJID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lidJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fullName",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fullName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "firstName",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "firstName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "username",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "username",
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

  field(:pnJID, 1, optional: true, type: :string)
  field(:lidJID, 2, optional: true, type: :string)
  field(:fullName, 3, optional: true, type: :string)
  field(:firstName, 4, optional: true, type: :string)
  field(:username, 5, optional: true, type: :string)
end

defmodule WAWebProtobufsHistorySync.Account do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsHistorySync.Account",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Account",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "lid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lid",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "username",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "username",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "countryCode",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "countryCode",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isUsernameDeleted",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isUsernameDeleted",
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

  field(:lid, 1, optional: true, type: :string)
  field(:username, 2, optional: true, type: :string)
  field(:countryCode, 3, optional: true, type: :string)
  field(:isUsernameDeleted, 4, optional: true, type: :bool)
end

defmodule WAWebProtobufsHistorySync.HistorySyncMsg do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsHistorySync.HistorySyncMsg",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "HistorySyncMsg",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "message",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.WebMessageInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "message",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "msgOrderID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "msgOrderID",
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

  field(:message, 1, optional: true, type: WAWebProtobufsWeb.WebMessageInfo)
  field(:msgOrderID, 2, optional: true, type: :uint64)
end

defmodule WAWebProtobufsHistorySync.Pushname do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsHistorySync.Pushname",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Pushname",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "ID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pushname",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pushname",
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

  field(:ID, 1, optional: true, type: :string)
  field(:pushname, 2, optional: true, type: :string)
end

defmodule WAWebProtobufsHistorySync.WallpaperSettings do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsHistorySync.WallpaperSettings",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "WallpaperSettings",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "filename",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "filename",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "opacity",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "opacity",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isGenAi",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isGenAi",
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

  field(:filename, 1, optional: true, type: :string)
  field(:opacity, 2, optional: true, type: :uint32)
  field(:isGenAi, 3, optional: true, type: :bool)
end

defmodule WAWebProtobufsHistorySync.GlobalSettings do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsHistorySync.GlobalSettings",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "GlobalSettings",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "lightThemeWallpaper",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.WallpaperSettings",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lightThemeWallpaper",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaVisibility",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsHistorySync.MediaVisibility",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaVisibility",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "darkThemeWallpaper",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.WallpaperSettings",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "darkThemeWallpaper",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "autoDownloadWiFi",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.AutoDownloadSettings",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "autoDownloadWiFi",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "autoDownloadCellular",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.AutoDownloadSettings",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "autoDownloadCellular",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "autoDownloadRoaming",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.AutoDownloadSettings",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "autoDownloadRoaming",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "showIndividualNotificationsPreview",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "showIndividualNotificationsPreview",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "showGroupNotificationsPreview",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "showGroupNotificationsPreview",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "disappearingModeDuration",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "disappearingModeDuration",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "disappearingModeTimestamp",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "disappearingModeTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "avatarUserSettings",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.AvatarUserSettings",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "avatarUserSettings",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fontSize",
          extendee: nil,
          number: 12,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fontSize",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "securityNotifications",
          extendee: nil,
          number: 13,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "securityNotifications",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "autoUnarchiveChats",
          extendee: nil,
          number: 14,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "autoUnarchiveChats",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "videoQualityMode",
          extendee: nil,
          number: 15,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "videoQualityMode",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "photoQualityMode",
          extendee: nil,
          number: 16,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "photoQualityMode",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "individualNotificationSettings",
          extendee: nil,
          number: 17,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.NotificationSettings",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "individualNotificationSettings",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupNotificationSettings",
          extendee: nil,
          number: 18,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.NotificationSettings",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "groupNotificationSettings",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatLockSettings",
          extendee: nil,
          number: 19,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsChatLockSettings.ChatLockSettings",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "chatLockSettings",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatDbLidMigrationTimestamp",
          extendee: nil,
          number: 20,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "chatDbLidMigrationTimestamp",
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

  field(:lightThemeWallpaper, 1, optional: true, type: WAWebProtobufsHistorySync.WallpaperSettings)

  field(:mediaVisibility, 2,
    optional: true,
    type: WAWebProtobufsHistorySync.MediaVisibility,
    enum: true
  )

  field(:darkThemeWallpaper, 3, optional: true, type: WAWebProtobufsHistorySync.WallpaperSettings)
  field(:autoDownloadWiFi, 4, optional: true, type: WAWebProtobufsHistorySync.AutoDownloadSettings)

  field(:autoDownloadCellular, 5,
    optional: true,
    type: WAWebProtobufsHistorySync.AutoDownloadSettings
  )

  field(:autoDownloadRoaming, 6,
    optional: true,
    type: WAWebProtobufsHistorySync.AutoDownloadSettings
  )

  field(:showIndividualNotificationsPreview, 7, optional: true, type: :bool)
  field(:showGroupNotificationsPreview, 8, optional: true, type: :bool)
  field(:disappearingModeDuration, 9, optional: true, type: :int32)
  field(:disappearingModeTimestamp, 10, optional: true, type: :int64)

  field(:avatarUserSettings, 11,
    optional: true,
    type: WAWebProtobufsHistorySync.AvatarUserSettings
  )

  field(:fontSize, 12, optional: true, type: :int32)
  field(:securityNotifications, 13, optional: true, type: :bool)
  field(:autoUnarchiveChats, 14, optional: true, type: :bool)
  field(:videoQualityMode, 15, optional: true, type: :int32)
  field(:photoQualityMode, 16, optional: true, type: :int32)

  field(:individualNotificationSettings, 17,
    optional: true,
    type: WAWebProtobufsHistorySync.NotificationSettings
  )

  field(:groupNotificationSettings, 18,
    optional: true,
    type: WAWebProtobufsHistorySync.NotificationSettings
  )

  field(:chatLockSettings, 19,
    optional: true,
    type: WAWebProtobufsChatLockSettings.ChatLockSettings
  )

  field(:chatDbLidMigrationTimestamp, 20, optional: true, type: :int64)
end

defmodule WAWebProtobufsHistorySync.AutoDownloadSettings do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsHistorySync.AutoDownloadSettings",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AutoDownloadSettings",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "downloadImages",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "downloadImages",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "downloadAudio",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "downloadAudio",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "downloadVideo",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "downloadVideo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "downloadDocuments",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "downloadDocuments",
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

  field(:downloadImages, 1, optional: true, type: :bool)
  field(:downloadAudio, 2, optional: true, type: :bool)
  field(:downloadVideo, 3, optional: true, type: :bool)
  field(:downloadDocuments, 4, optional: true, type: :bool)
end

defmodule WAWebProtobufsHistorySync.StickerMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsHistorySync.StickerMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "StickerMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "URL",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "URL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fileSHA256",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fileSHA256",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fileEncSHA256",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fileEncSHA256",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaKey",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mimetype",
          extendee: nil,
          number: 5,
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
          name: "height",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "height",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "width",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "width",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "directPath",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "directPath",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fileLength",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fileLength",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "weight",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_FLOAT,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "weight",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lastStickerSentTS",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lastStickerSentTS",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isLottie",
          extendee: nil,
          number: 12,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isLottie",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "imageHash",
          extendee: nil,
          number: 13,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imageHash",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isAvatarSticker",
          extendee: nil,
          number: 14,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isAvatarSticker",
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

  field(:URL, 1, optional: true, type: :string)
  field(:fileSHA256, 2, optional: true, type: :bytes)
  field(:fileEncSHA256, 3, optional: true, type: :bytes)
  field(:mediaKey, 4, optional: true, type: :bytes)
  field(:mimetype, 5, optional: true, type: :string)
  field(:height, 6, optional: true, type: :uint32)
  field(:width, 7, optional: true, type: :uint32)
  field(:directPath, 8, optional: true, type: :string)
  field(:fileLength, 9, optional: true, type: :uint64)
  field(:weight, 10, optional: true, type: :float)
  field(:lastStickerSentTS, 11, optional: true, type: :int64)
  field(:isLottie, 12, optional: true, type: :bool)
  field(:imageHash, 13, optional: true, type: :string)
  field(:isAvatarSticker, 14, optional: true, type: :bool)
end

defmodule WAWebProtobufsHistorySync.PastParticipants do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsHistorySync.PastParticipants",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PastParticipants",
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
          name: "pastParticipants",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsHistorySync.PastParticipant",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pastParticipants",
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
  field(:pastParticipants, 2, repeated: true, type: WAWebProtobufsHistorySync.PastParticipant)
end

defmodule WAWebProtobufsHistorySync.AvatarUserSettings do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsHistorySync.AvatarUserSettings",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AvatarUserSettings",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "FBID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "FBID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "password",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "password",
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

  field(:FBID, 1, optional: true, type: :string)
  field(:password, 2, optional: true, type: :string)
end

defmodule WAWebProtobufsHistorySync.NotificationSettings do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsHistorySync.NotificationSettings",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "NotificationSettings",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageVibrate",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageVibrate",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messagePopup",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messagePopup",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageLight",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageLight",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lowPriorityNotifications",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lowPriorityNotifications",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "reactionsMuted",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "reactionsMuted",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "callVibrate",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "callVibrate",
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

  field(:messageVibrate, 1, optional: true, type: :string)
  field(:messagePopup, 2, optional: true, type: :string)
  field(:messageLight, 3, optional: true, type: :string)
  field(:lowPriorityNotifications, 4, optional: true, type: :bool)
  field(:reactionsMuted, 5, optional: true, type: :bool)
  field(:callVibrate, 6, optional: true, type: :string)
end
