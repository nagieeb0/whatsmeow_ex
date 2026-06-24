defmodule WAWebProtobufSyncAction.CollectionName do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.CollectionName",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "CollectionName",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COLLECTION_NAME_UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REGULAR",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REGULAR_LOW",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REGULAR_HIGH",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CRITICAL_BLOCK",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CRITICAL_UNBLOCK_LOW",
          number: 5,
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

  field(:COLLECTION_NAME_UNKNOWN, 0)
  field(:REGULAR, 1)
  field(:REGULAR_LOW, 2)
  field(:REGULAR_HIGH, 3)
  field(:CRITICAL_BLOCK, 4)
  field(:CRITICAL_UNBLOCK_LOW, 5)
end

defmodule WAWebProtobufSyncAction.MutationProps do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.MutationProps",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "MutationProps",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "STAR_ACTION",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CONTACT_ACTION",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MUTE_ACTION",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PIN_ACTION",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SECURITY_NOTIFICATION_SETTING",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PUSH_NAME_SETTING",
          number: 7,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "QUICK_REPLY_ACTION",
          number: 8,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RECENT_EMOJI_WEIGHTS_ACTION",
          number: 11,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LABEL_MESSAGE_ACTION",
          number: 13,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LABEL_EDIT_ACTION",
          number: 14,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LABEL_ASSOCIATION_ACTION",
          number: 15,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LOCALE_SETTING",
          number: 16,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ARCHIVE_CHAT_ACTION",
          number: 17,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DELETE_MESSAGE_FOR_ME_ACTION",
          number: 18,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "KEY_EXPIRATION",
          number: 19,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MARK_CHAT_AS_READ_ACTION",
          number: 20,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CLEAR_CHAT_ACTION",
          number: 21,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DELETE_CHAT_ACTION",
          number: 22,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNARCHIVE_CHATS_SETTING",
          number: 23,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PRIMARY_FEATURE",
          number: 24,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ANDROID_UNSUPPORTED_ACTIONS",
          number: 26,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AGENT_ACTION",
          number: 27,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SUBSCRIPTION_ACTION",
          number: 28,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "USER_STATUS_MUTE_ACTION",
          number: 29,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TIME_FORMAT_ACTION",
          number: 30,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NUX_ACTION",
          number: 31,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PRIMARY_VERSION_ACTION",
          number: 32,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "STICKER_ACTION",
          number: 33,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REMOVE_RECENT_STICKER_ACTION",
          number: 34,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CHAT_ASSIGNMENT",
          number: 35,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CHAT_ASSIGNMENT_OPENED_STATUS",
          number: 36,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PN_FOR_LID_CHAT_ACTION",
          number: 37,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MARKETING_MESSAGE_ACTION",
          number: 38,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MARKETING_MESSAGE_BROADCAST_ACTION",
          number: 39,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "EXTERNAL_WEB_BETA_ACTION",
          number: 40,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PRIVACY_SETTING_RELAY_ALL_CALLS",
          number: 41,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CALL_LOG_ACTION",
          number: 42,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UGC_BOT",
          number: 43,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "STATUS_PRIVACY",
          number: 44,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_WELCOME_REQUEST_ACTION",
          number: 45,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DELETE_INDIVIDUAL_CALL_LOG",
          number: 46,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LABEL_REORDERING_ACTION",
          number: 47,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_INFO_ACTION",
          number: 48,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CUSTOM_PAYMENT_METHODS_ACTION",
          number: 49,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LOCK_CHAT_ACTION",
          number: 50,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CHAT_LOCK_SETTINGS",
          number: 51,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WAMO_USER_IDENTIFIER_ACTION",
          number: 52,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PRIVACY_SETTING_DISABLE_LINK_PREVIEWS_ACTION",
          number: 53,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DEVICE_CAPABILITIES",
          number: 54,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NOTE_EDIT_ACTION",
          number: 55,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FAVORITES_ACTION",
          number: 56,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MERCHANT_PAYMENT_PARTNER_ACTION",
          number: 57,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WAFFLE_ACCOUNT_LINK_STATE_ACTION",
          number: 58,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "USERNAME_CHAT_START_MODE",
          number: 59,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NOTIFICATION_ACTIVITY_SETTING_ACTION",
          number: 60,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LID_CONTACT_ACTION",
          number: 61,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CTWA_PER_CUSTOMER_DATA_SHARING_ACTION",
          number: 62,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_TOS_ACTION",
          number: 63,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PRIVACY_SETTING_CHANNELS_PERSONALISED_RECOMMENDATION_ACTION",
          number: 64,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BUSINESS_BROADCAST_ASSOCIATION_ACTION",
          number: 65,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DETECTED_OUTCOMES_STATUS_ACTION",
          number: 66,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MAIBA_AI_FEATURES_CONTROL_ACTION",
          number: 68,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BUSINESS_BROADCAST_LIST_ACTION",
          number: 69,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MUSIC_USER_ID_ACTION",
          number: 70,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "STATUS_POST_OPT_IN_NOTIFICATION_PREFERENCES_ACTION",
          number: 71,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AVATAR_UPDATED_ACTION",
          number: 72,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GALAXY_FLOW_ACTION",
          number: 73,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PRIVATE_PROCESSING_SETTING_ACTION",
          number: 74,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NEWSLETTER_SAVED_INTERESTS_ACTION",
          number: 75,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_THREAD_RENAME_ACTION",
          number: 76,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INTERACTIVE_MESSAGE_ACTION",
          number: 77,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SETTINGS_SYNC_ACTION",
          number: 78,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "OUT_CONTACT_ACTION",
          number: 79,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NCT_SALT_SYNC_ACTION",
          number: 80,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BUSINESS_BROADCAST_CAMPAIGN_ACTION",
          number: 81,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BUSINESS_BROADCAST_INSIGHTS_ACTION",
          number: 82,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CUSTOMER_DATA_ACTION",
          number: 83,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SUBSCRIPTIONS_SYNC_V2_ACTION",
          number: 84,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "THREAD_PIN_ACTION",
          number: 85,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AUTO_ORGANIZE_BUSINESS_CHAT_SETTING",
          number: 86,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_AI_SETTINGS_NUDGE_ACTION",
          number: 87,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SHARE_OWN_PN",
          number: 10001,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BUSINESS_BROADCAST_ACTION",
          number: 10002,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_THREAD_DELETE_ACTION",
          number: 10003,
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

  field(:STAR_ACTION, 2)
  field(:CONTACT_ACTION, 3)
  field(:MUTE_ACTION, 4)
  field(:PIN_ACTION, 5)
  field(:SECURITY_NOTIFICATION_SETTING, 6)
  field(:PUSH_NAME_SETTING, 7)
  field(:QUICK_REPLY_ACTION, 8)
  field(:RECENT_EMOJI_WEIGHTS_ACTION, 11)
  field(:LABEL_MESSAGE_ACTION, 13)
  field(:LABEL_EDIT_ACTION, 14)
  field(:LABEL_ASSOCIATION_ACTION, 15)
  field(:LOCALE_SETTING, 16)
  field(:ARCHIVE_CHAT_ACTION, 17)
  field(:DELETE_MESSAGE_FOR_ME_ACTION, 18)
  field(:KEY_EXPIRATION, 19)
  field(:MARK_CHAT_AS_READ_ACTION, 20)
  field(:CLEAR_CHAT_ACTION, 21)
  field(:DELETE_CHAT_ACTION, 22)
  field(:UNARCHIVE_CHATS_SETTING, 23)
  field(:PRIMARY_FEATURE, 24)
  field(:ANDROID_UNSUPPORTED_ACTIONS, 26)
  field(:AGENT_ACTION, 27)
  field(:SUBSCRIPTION_ACTION, 28)
  field(:USER_STATUS_MUTE_ACTION, 29)
  field(:TIME_FORMAT_ACTION, 30)
  field(:NUX_ACTION, 31)
  field(:PRIMARY_VERSION_ACTION, 32)
  field(:STICKER_ACTION, 33)
  field(:REMOVE_RECENT_STICKER_ACTION, 34)
  field(:CHAT_ASSIGNMENT, 35)
  field(:CHAT_ASSIGNMENT_OPENED_STATUS, 36)
  field(:PN_FOR_LID_CHAT_ACTION, 37)
  field(:MARKETING_MESSAGE_ACTION, 38)
  field(:MARKETING_MESSAGE_BROADCAST_ACTION, 39)
  field(:EXTERNAL_WEB_BETA_ACTION, 40)
  field(:PRIVACY_SETTING_RELAY_ALL_CALLS, 41)
  field(:CALL_LOG_ACTION, 42)
  field(:UGC_BOT, 43)
  field(:STATUS_PRIVACY, 44)
  field(:BOT_WELCOME_REQUEST_ACTION, 45)
  field(:DELETE_INDIVIDUAL_CALL_LOG, 46)
  field(:LABEL_REORDERING_ACTION, 47)
  field(:PAYMENT_INFO_ACTION, 48)
  field(:CUSTOM_PAYMENT_METHODS_ACTION, 49)
  field(:LOCK_CHAT_ACTION, 50)
  field(:CHAT_LOCK_SETTINGS, 51)
  field(:WAMO_USER_IDENTIFIER_ACTION, 52)
  field(:PRIVACY_SETTING_DISABLE_LINK_PREVIEWS_ACTION, 53)
  field(:DEVICE_CAPABILITIES, 54)
  field(:NOTE_EDIT_ACTION, 55)
  field(:FAVORITES_ACTION, 56)
  field(:MERCHANT_PAYMENT_PARTNER_ACTION, 57)
  field(:WAFFLE_ACCOUNT_LINK_STATE_ACTION, 58)
  field(:USERNAME_CHAT_START_MODE, 59)
  field(:NOTIFICATION_ACTIVITY_SETTING_ACTION, 60)
  field(:LID_CONTACT_ACTION, 61)
  field(:CTWA_PER_CUSTOMER_DATA_SHARING_ACTION, 62)
  field(:PAYMENT_TOS_ACTION, 63)
  field(:PRIVACY_SETTING_CHANNELS_PERSONALISED_RECOMMENDATION_ACTION, 64)
  field(:BUSINESS_BROADCAST_ASSOCIATION_ACTION, 65)
  field(:DETECTED_OUTCOMES_STATUS_ACTION, 66)
  field(:MAIBA_AI_FEATURES_CONTROL_ACTION, 68)
  field(:BUSINESS_BROADCAST_LIST_ACTION, 69)
  field(:MUSIC_USER_ID_ACTION, 70)
  field(:STATUS_POST_OPT_IN_NOTIFICATION_PREFERENCES_ACTION, 71)
  field(:AVATAR_UPDATED_ACTION, 72)
  field(:GALAXY_FLOW_ACTION, 73)
  field(:PRIVATE_PROCESSING_SETTING_ACTION, 74)
  field(:NEWSLETTER_SAVED_INTERESTS_ACTION, 75)
  field(:AI_THREAD_RENAME_ACTION, 76)
  field(:INTERACTIVE_MESSAGE_ACTION, 77)
  field(:SETTINGS_SYNC_ACTION, 78)
  field(:OUT_CONTACT_ACTION, 79)
  field(:NCT_SALT_SYNC_ACTION, 80)
  field(:BUSINESS_BROADCAST_CAMPAIGN_ACTION, 81)
  field(:BUSINESS_BROADCAST_INSIGHTS_ACTION, 82)
  field(:CUSTOMER_DATA_ACTION, 83)
  field(:SUBSCRIPTIONS_SYNC_V2_ACTION, 84)
  field(:THREAD_PIN_ACTION, 85)
  field(:AUTO_ORGANIZE_BUSINESS_CHAT_SETTING, 86)
  field(:BIZ_AI_SETTINGS_NUDGE_ACTION, 87)
  field(:SHARE_OWN_PN, 10001)
  field(:BUSINESS_BROADCAST_ACTION, 10002)
  field(:AI_THREAD_DELETE_ACTION, 10003)
end

defmodule WAWebProtobufSyncAction.BusinessBroadcastCampaignStatus do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.BusinessBroadcastCampaignStatus",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BusinessBroadcastCampaignStatus",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DRAFT",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SCHEDULED",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PROCESSING",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FAILED",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SENT",
          number: 5,
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

  field(:DRAFT, 1)
  field(:SCHEDULED, 2)
  field(:PROCESSING, 3)
  field(:FAILED, 4)
  field(:SENT, 5)
end

defmodule WAWebProtobufSyncAction.CallLogRecord.CallType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.CallLogRecord.CallType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "CallType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REGULAR",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SCHEDULED_CALL",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VOICE_CHAT",
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
  field(:SCHEDULED_CALL, 1)
  field(:VOICE_CHAT, 2)
end

defmodule WAWebProtobufSyncAction.CallLogRecord.SilenceReason do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.CallLogRecord.SilenceReason",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "SilenceReason",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NONE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SCHEDULED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PRIVACY",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LIGHTWEIGHT",
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

  field(:NONE, 0)
  field(:SCHEDULED, 1)
  field(:PRIVACY, 2)
  field(:LIGHTWEIGHT, 3)
end

defmodule WAWebProtobufSyncAction.CallLogRecord.CallResult do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.CallLogRecord.CallResult",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "CallResult",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CONNECTED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REJECTED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CANCELLED",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ACCEPTEDELSEWHERE",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MISSED",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INVALID",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNAVAILABLE",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UPCOMING",
          number: 7,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FAILED",
          number: 8,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ABANDONED",
          number: 9,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ONGOING",
          number: 10,
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

  field(:CONNECTED, 0)
  field(:REJECTED, 1)
  field(:CANCELLED, 2)
  field(:ACCEPTEDELSEWHERE, 3)
  field(:MISSED, 4)
  field(:INVALID, 5)
  field(:UNAVAILABLE, 6)
  field(:UPCOMING, 7)
  field(:FAILED, 8)
  field(:ABANDONED, 9)
  field(:ONGOING, 10)
end

defmodule WAWebProtobufSyncAction.SettingsSyncAction.MediaQualitySetting do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.SettingsSyncAction.MediaQualitySetting",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "MediaQualitySetting",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MEDIA_QUALITY_UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "STANDARD",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "HD",
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

  field(:MEDIA_QUALITY_UNKNOWN, 0)
  field(:STANDARD, 1)
  field(:HD, 2)
end

defmodule WAWebProtobufSyncAction.SettingsSyncAction.DisplayMode do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.SettingsSyncAction.DisplayMode",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "DisplayMode",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DISPLAY_MODE_UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ALWAYS",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NEVER",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ONLY_WHEN_APP_IS_OPEN",
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

  field(:DISPLAY_MODE_UNKNOWN, 0)
  field(:ALWAYS, 1)
  field(:NEVER, 2)
  field(:ONLY_WHEN_APP_IS_OPEN, 3)
end

defmodule WAWebProtobufSyncAction.SettingsSyncAction.SettingKey do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.SettingsSyncAction.SettingKey",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "SettingKey",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SETTING_KEY_UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "START_AT_LOGIN",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MINIMIZE_TO_TRAY",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LANGUAGE",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REPLACE_TEXT_WITH_EMOJI",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BANNER_NOTIFICATION_DISPLAY_MODE",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNREAD_COUNTER_BADGE_DISPLAY_MODE",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IS_MESSAGES_NOTIFICATION_ENABLED",
          number: 7,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IS_CALLS_NOTIFICATION_ENABLED",
          number: 8,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IS_REACTIONS_NOTIFICATION_ENABLED",
          number: 9,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IS_STATUS_REACTIONS_NOTIFICATION_ENABLED",
          number: 10,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IS_TEXT_PREVIEW_FOR_NOTIFICATION_ENABLED",
          number: 11,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DEFAULT_NOTIFICATION_TONE_ID",
          number: 12,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_DEFAULT_NOTIFICATION_TONE_ID",
          number: 13,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "APP_THEME",
          number: 14,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WALLPAPER_ID",
          number: 15,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IS_DOODLE_WALLPAPER_ENABLED",
          number: 16,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FONT_SIZE",
          number: 17,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IS_PHOTOS_AUTODOWNLOAD_ENABLED",
          number: 18,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IS_AUDIOS_AUTODOWNLOAD_ENABLED",
          number: 19,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IS_VIDEOS_AUTODOWNLOAD_ENABLED",
          number: 20,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IS_DOCUMENTS_AUTODOWNLOAD_ENABLED",
          number: 21,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DISABLE_LINK_PREVIEWS",
          number: 22,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NOTIFICATION_TONE_ID",
          number: 23,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MEDIA_UPLOAD_QUALITY",
          number: 24,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IS_SPELL_CHECK_ENABLED",
          number: 25,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IS_ENTER_TO_SEND_ENABLED",
          number: 26,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IS_GROUP_MESSAGE_NOTIFICATION_ENABLED",
          number: 27,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IS_GROUP_REACTIONS_NOTIFICATION_ENABLED",
          number: 28,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IS_STATUS_NOTIFICATION_ENABLED",
          number: 29,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "STATUS_NOTIFICATION_TONE_ID",
          number: 30,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SHOULD_PLAY_SOUND_FOR_CALL_NOTIFICATION",
          number: 31,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CHAT_THEME_ID",
          number: 32,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COLOR_SCHEME_ID",
          number: 33,
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

  field(:SETTING_KEY_UNKNOWN, 0)
  field(:START_AT_LOGIN, 1)
  field(:MINIMIZE_TO_TRAY, 2)
  field(:LANGUAGE, 3)
  field(:REPLACE_TEXT_WITH_EMOJI, 4)
  field(:BANNER_NOTIFICATION_DISPLAY_MODE, 5)
  field(:UNREAD_COUNTER_BADGE_DISPLAY_MODE, 6)
  field(:IS_MESSAGES_NOTIFICATION_ENABLED, 7)
  field(:IS_CALLS_NOTIFICATION_ENABLED, 8)
  field(:IS_REACTIONS_NOTIFICATION_ENABLED, 9)
  field(:IS_STATUS_REACTIONS_NOTIFICATION_ENABLED, 10)
  field(:IS_TEXT_PREVIEW_FOR_NOTIFICATION_ENABLED, 11)
  field(:DEFAULT_NOTIFICATION_TONE_ID, 12)
  field(:GROUP_DEFAULT_NOTIFICATION_TONE_ID, 13)
  field(:APP_THEME, 14)
  field(:WALLPAPER_ID, 15)
  field(:IS_DOODLE_WALLPAPER_ENABLED, 16)
  field(:FONT_SIZE, 17)
  field(:IS_PHOTOS_AUTODOWNLOAD_ENABLED, 18)
  field(:IS_AUDIOS_AUTODOWNLOAD_ENABLED, 19)
  field(:IS_VIDEOS_AUTODOWNLOAD_ENABLED, 20)
  field(:IS_DOCUMENTS_AUTODOWNLOAD_ENABLED, 21)
  field(:DISABLE_LINK_PREVIEWS, 22)
  field(:NOTIFICATION_TONE_ID, 23)
  field(:MEDIA_UPLOAD_QUALITY, 24)
  field(:IS_SPELL_CHECK_ENABLED, 25)
  field(:IS_ENTER_TO_SEND_ENABLED, 26)
  field(:IS_GROUP_MESSAGE_NOTIFICATION_ENABLED, 27)
  field(:IS_GROUP_REACTIONS_NOTIFICATION_ENABLED, 28)
  field(:IS_STATUS_NOTIFICATION_ENABLED, 29)
  field(:STATUS_NOTIFICATION_TONE_ID, 30)
  field(:SHOULD_PLAY_SOUND_FOR_CALL_NOTIFICATION, 31)
  field(:CHAT_THEME_ID, 32)
  field(:COLOR_SCHEME_ID, 33)
end

defmodule WAWebProtobufSyncAction.SettingsSyncAction.SettingPlatform do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.SettingsSyncAction.SettingPlatform",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "SettingPlatform",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PLATFORM_UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WEB",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "HYBRID",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WINDOWS",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MAC",
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

  field(:PLATFORM_UNKNOWN, 0)
  field(:WEB, 1)
  field(:HYBRID, 2)
  field(:WINDOWS, 3)
  field(:MAC, 4)
end

defmodule WAWebProtobufSyncAction.InteractiveMessageAction.InteractiveMessageActionMode do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.InteractiveMessageAction.InteractiveMessageActionMode",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "InteractiveMessageActionMode",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DISABLE_CTA",
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

  field(:DISABLE_CTA, 1)
end

defmodule WAWebProtobufSyncAction.PrivateProcessingSettingAction.PrivateProcessingStatus do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.PrivateProcessingSettingAction.PrivateProcessingStatus",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "PrivateProcessingStatus",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNDEFINED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ENABLED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DISABLED",
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

  field(:UNDEFINED, 0)
  field(:ENABLED, 1)
  field(:DISABLED, 2)
end

defmodule WAWebProtobufSyncAction.AvatarUpdatedAction.AvatarEventType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.AvatarUpdatedAction.AvatarEventType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "AvatarEventType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UPDATED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CREATED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DELETED",
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

  field(:UPDATED, 0)
  field(:CREATED, 1)
  field(:DELETED, 2)
end

defmodule WAWebProtobufSyncAction.BizAISettingsNudgeAction.BizAISettingsCategory do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.BizAISettingsNudgeAction.BizAISettingsCategory",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BizAISettingsCategory",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INSTRUCTIONS",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RESPONSE_SETTINGS",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "EXAMPLE_RESPONSES",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "KNOWLEDGE",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LEAD_GEN",
          number: 5,
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

  field(:UNKNOWN, 0)
  field(:INSTRUCTIONS, 1)
  field(:RESPONSE_SETTINGS, 2)
  field(:EXAMPLE_RESPONSES, 3)
  field(:KNOWLEDGE, 4)
  field(:LEAD_GEN, 5)
end

defmodule WAWebProtobufSyncAction.MaibaAIFeaturesControlAction.MaibaAIFeatureStatus do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.MaibaAIFeaturesControlAction.MaibaAIFeatureStatus",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "MaibaAIFeatureStatus",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ENABLED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ENABLED_HAS_LEARNING",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DISABLED",
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

  field(:ENABLED, 0)
  field(:ENABLED_HAS_LEARNING, 1)
  field(:DISABLED, 2)
end

defmodule WAWebProtobufSyncAction.PaymentTosAction.PaymentNotice do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.PaymentTosAction.PaymentNotice",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "PaymentNotice",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BR_PAY_PRIVACY_POLICY",
          number: 0,
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

  field(:BR_PAY_PRIVACY_POLICY, 0)
end

defmodule WAWebProtobufSyncAction.NotificationActivitySettingAction.NotificationActivitySetting do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name:
      "WAWebProtobufSyncAction.NotificationActivitySettingAction.NotificationActivitySetting",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "NotificationActivitySetting",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DEFAULT_ALL_MESSAGES",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ALL_MESSAGES",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "HIGHLIGHTS",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DEFAULT_HIGHLIGHTS",
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

  field(:DEFAULT_ALL_MESSAGES, 0)
  field(:ALL_MESSAGES, 1)
  field(:HIGHLIGHTS, 2)
  field(:DEFAULT_HIGHLIGHTS, 3)
end

defmodule WAWebProtobufSyncAction.WaffleAccountLinkStateAction.AccountLinkState do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.WaffleAccountLinkStateAction.AccountLinkState",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "AccountLinkState",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ACTIVE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAUSED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNLINKED",
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

  field(:ACTIVE, 0)
  field(:PAUSED, 1)
  field(:UNLINKED, 2)
end

defmodule WAWebProtobufSyncAction.MerchantPaymentPartnerAction.Status do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.MerchantPaymentPartnerAction.Status",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Status",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ACTIVE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INACTIVE",
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

  field(:ACTIVE, 0)
  field(:INACTIVE, 1)
end

defmodule WAWebProtobufSyncAction.NoteEditAction.NoteType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.NoteEditAction.NoteType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "NoteType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNSTRUCTURED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "STRUCTURED",
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

  field(:UNSTRUCTURED, 1)
  field(:STRUCTURED, 2)
end

defmodule WAWebProtobufSyncAction.StatusPrivacyAction.StatusDistributionMode do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.StatusPrivacyAction.StatusDistributionMode",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "StatusDistributionMode",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ALLOW_LIST",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DENY_LIST",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CONTACTS",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CLOSE_FRIENDS",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CUSTOM_LIST",
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

  field(:ALLOW_LIST, 0)
  field(:DENY_LIST, 1)
  field(:CONTACTS, 2)
  field(:CLOSE_FRIENDS, 3)
  field(:CUSTOM_LIST, 4)
end

defmodule WAWebProtobufSyncAction.MarketingMessageAction.MarketingMessagePrototypeType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.MarketingMessageAction.MarketingMessagePrototypeType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "MarketingMessagePrototypeType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PERSONALIZED",
          number: 0,
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

  field(:PERSONALIZED, 0)
end

defmodule WAWebProtobufSyncAction.UsernameChatStartModeAction.ChatStartMode do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.UsernameChatStartModeAction.ChatStartMode",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ChatStartMode",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LID",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PN",
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

  field(:LID, 1)
  field(:PN, 2)
end

defmodule WAWebProtobufSyncAction.LabelEditAction.ListType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.LabelEditAction.ListType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ListType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NONE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNREAD",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUPS",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FAVORITES",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PREDEFINED",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CUSTOM",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SERVER_ASSIGNED",
          number: 7,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DRAFTED",
          number: 8,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_HANDOFF",
          number: 9,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CHANNELS",
          number: 10,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RESPONDING",
          number: 11,
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
  field(:UNREAD, 1)
  field(:GROUPS, 2)
  field(:FAVORITES, 3)
  field(:PREDEFINED, 4)
  field(:CUSTOM, 5)
  field(:COMMUNITY, 6)
  field(:SERVER_ASSIGNED, 7)
  field(:DRAFTED, 8)
  field(:AI_HANDOFF, 9)
  field(:CHANNELS, 10)
  field(:AI_RESPONDING, 11)
end

defmodule WAWebProtobufSyncAction.PatchDebugData.Platform do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufSyncAction.PatchDebugData.Platform",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Platform",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ANDROID",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SMBA",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IPHONE",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SMBI",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WEB",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UWP",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DARWIN",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IPAD",
          number: 7,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WEAROS",
          number: 8,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WASG",
          number: 9,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WEARM",
          number: 10,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CAPI",
          number: 11,
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

  field(:ANDROID, 0)
  field(:SMBA, 1)
  field(:IPHONE, 2)
  field(:SMBI, 3)
  field(:WEB, 4)
  field(:UWP, 5)
  field(:DARWIN, 6)
  field(:IPAD, 7)
  field(:WEAROS, 8)
  field(:WASG, 9)
  field(:WEARM, 10)
  field(:CAPI, 11)
end

defmodule WAWebProtobufSyncAction.CallLogRecord.ParticipantInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.CallLogRecord.ParticipantInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ParticipantInfo",
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
          name: "callResult",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.CallLogRecord.CallResult",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "callResult",
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

  field(:userJID, 1, optional: true, type: :string)

  field(:callResult, 2,
    optional: true,
    type: WAWebProtobufSyncAction.CallLogRecord.CallResult,
    enum: true
  )
end

defmodule WAWebProtobufSyncAction.CallLogRecord do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.CallLogRecord",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "CallLogRecord",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "callResult",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.CallLogRecord.CallResult",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "callResult",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isDndMode",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isDndMode",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "silenceReason",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.CallLogRecord.SilenceReason",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "silenceReason",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "duration",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "duration",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "startTime",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "startTime",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isIncoming",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isIncoming",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isVideo",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isVideo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isCallLink",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isCallLink",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "callLinkToken",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "callLinkToken",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "scheduledCallID",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "scheduledCallID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "callID",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "callID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "callCreatorJID",
          extendee: nil,
          number: 12,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "callCreatorJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupJID",
          extendee: nil,
          number: 13,
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
          name: "participants",
          extendee: nil,
          number: 14,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.CallLogRecord.ParticipantInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "participants",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "callType",
          extendee: nil,
          number: 15,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.CallLogRecord.CallType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "callType",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "ParticipantInfo",
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
              name: "callResult",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAWebProtobufSyncAction.CallLogRecord.CallResult",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "callResult",
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
          name: "CallType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REGULAR",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SCHEDULED_CALL",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VOICE_CHAT",
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
          name: "SilenceReason",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NONE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SCHEDULED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PRIVACY",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "LIGHTWEIGHT",
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
          name: "CallResult",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CONNECTED",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REJECTED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CANCELLED",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ACCEPTEDELSEWHERE",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MISSED",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INVALID",
              number: 5,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNAVAILABLE",
              number: 6,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UPCOMING",
              number: 7,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FAILED",
              number: 8,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ABANDONED",
              number: 9,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ONGOING",
              number: 10,
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

  field(:callResult, 1,
    optional: true,
    type: WAWebProtobufSyncAction.CallLogRecord.CallResult,
    enum: true
  )

  field(:isDndMode, 2, optional: true, type: :bool)

  field(:silenceReason, 3,
    optional: true,
    type: WAWebProtobufSyncAction.CallLogRecord.SilenceReason,
    enum: true
  )

  field(:duration, 4, optional: true, type: :int64)
  field(:startTime, 5, optional: true, type: :int64)
  field(:isIncoming, 6, optional: true, type: :bool)
  field(:isVideo, 7, optional: true, type: :bool)
  field(:isCallLink, 8, optional: true, type: :bool)
  field(:callLinkToken, 9, optional: true, type: :string)
  field(:scheduledCallID, 10, optional: true, type: :string)
  field(:callID, 11, optional: true, type: :string)
  field(:callCreatorJID, 12, optional: true, type: :string)
  field(:groupJID, 13, optional: true, type: :string)

  field(:participants, 14,
    repeated: true,
    type: WAWebProtobufSyncAction.CallLogRecord.ParticipantInfo
  )

  field(:callType, 15,
    optional: true,
    type: WAWebProtobufSyncAction.CallLogRecord.CallType,
    enum: true
  )
end

defmodule WAWebProtobufSyncAction.SettingsSyncAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.SettingsSyncAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SettingsSyncAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "startAtLogin",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "startAtLogin",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "minimizeToTray",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "minimizeToTray",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "language",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "language",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "replaceTextWithEmoji",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "replaceTextWithEmoji",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "bannerNotificationDisplayMode",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.SettingsSyncAction.DisplayMode",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "bannerNotificationDisplayMode",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "unreadCounterBadgeDisplayMode",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.SettingsSyncAction.DisplayMode",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "unreadCounterBadgeDisplayMode",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isMessagesNotificationEnabled",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isMessagesNotificationEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isCallsNotificationEnabled",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isCallsNotificationEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isReactionsNotificationEnabled",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isReactionsNotificationEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isStatusReactionsNotificationEnabled",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isStatusReactionsNotificationEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isTextPreviewForNotificationEnabled",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isTextPreviewForNotificationEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "defaultNotificationToneID",
          extendee: nil,
          number: 12,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "defaultNotificationToneID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupDefaultNotificationToneID",
          extendee: nil,
          number: 13,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "groupDefaultNotificationToneID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "appTheme",
          extendee: nil,
          number: 14,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "appTheme",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "wallpaperID",
          extendee: nil,
          number: 15,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "wallpaperID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isDoodleWallpaperEnabled",
          extendee: nil,
          number: 16,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isDoodleWallpaperEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fontSize",
          extendee: nil,
          number: 17,
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
          name: "isPhotosAutodownloadEnabled",
          extendee: nil,
          number: 18,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isPhotosAutodownloadEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isAudiosAutodownloadEnabled",
          extendee: nil,
          number: 19,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isAudiosAutodownloadEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isVideosAutodownloadEnabled",
          extendee: nil,
          number: 20,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isVideosAutodownloadEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isDocumentsAutodownloadEnabled",
          extendee: nil,
          number: 21,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isDocumentsAutodownloadEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "disableLinkPreviews",
          extendee: nil,
          number: 22,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "disableLinkPreviews",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "notificationToneID",
          extendee: nil,
          number: 23,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "notificationToneID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaUploadQuality",
          extendee: nil,
          number: 24,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.SettingsSyncAction.MediaQualitySetting",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaUploadQuality",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isSpellCheckEnabled",
          extendee: nil,
          number: 25,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isSpellCheckEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isEnterToSendEnabled",
          extendee: nil,
          number: 26,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isEnterToSendEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isGroupMessageNotificationEnabled",
          extendee: nil,
          number: 27,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isGroupMessageNotificationEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isGroupReactionsNotificationEnabled",
          extendee: nil,
          number: 28,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isGroupReactionsNotificationEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isStatusNotificationEnabled",
          extendee: nil,
          number: 29,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isStatusNotificationEnabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "statusNotificationToneID",
          extendee: nil,
          number: 30,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "statusNotificationToneID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "shouldPlaySoundForCallNotification",
          extendee: nil,
          number: 31,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "shouldPlaySoundForCallNotification",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatThemeID",
          extendee: nil,
          number: 32,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "chatThemeID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "colorSchemeID",
          extendee: nil,
          number: 33,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "colorSchemeID",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "MediaQualitySetting",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MEDIA_QUALITY_UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "STANDARD",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "HD",
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
          name: "DisplayMode",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DISPLAY_MODE_UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ALWAYS",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NEVER",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ONLY_WHEN_APP_IS_OPEN",
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
          name: "SettingKey",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SETTING_KEY_UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "START_AT_LOGIN",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MINIMIZE_TO_TRAY",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "LANGUAGE",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REPLACE_TEXT_WITH_EMOJI",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BANNER_NOTIFICATION_DISPLAY_MODE",
              number: 5,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNREAD_COUNTER_BADGE_DISPLAY_MODE",
              number: 6,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IS_MESSAGES_NOTIFICATION_ENABLED",
              number: 7,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IS_CALLS_NOTIFICATION_ENABLED",
              number: 8,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IS_REACTIONS_NOTIFICATION_ENABLED",
              number: 9,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IS_STATUS_REACTIONS_NOTIFICATION_ENABLED",
              number: 10,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IS_TEXT_PREVIEW_FOR_NOTIFICATION_ENABLED",
              number: 11,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DEFAULT_NOTIFICATION_TONE_ID",
              number: 12,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_DEFAULT_NOTIFICATION_TONE_ID",
              number: 13,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "APP_THEME",
              number: 14,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WALLPAPER_ID",
              number: 15,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IS_DOODLE_WALLPAPER_ENABLED",
              number: 16,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FONT_SIZE",
              number: 17,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IS_PHOTOS_AUTODOWNLOAD_ENABLED",
              number: 18,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IS_AUDIOS_AUTODOWNLOAD_ENABLED",
              number: 19,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IS_VIDEOS_AUTODOWNLOAD_ENABLED",
              number: 20,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IS_DOCUMENTS_AUTODOWNLOAD_ENABLED",
              number: 21,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DISABLE_LINK_PREVIEWS",
              number: 22,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NOTIFICATION_TONE_ID",
              number: 23,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MEDIA_UPLOAD_QUALITY",
              number: 24,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IS_SPELL_CHECK_ENABLED",
              number: 25,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IS_ENTER_TO_SEND_ENABLED",
              number: 26,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IS_GROUP_MESSAGE_NOTIFICATION_ENABLED",
              number: 27,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IS_GROUP_REACTIONS_NOTIFICATION_ENABLED",
              number: 28,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IS_STATUS_NOTIFICATION_ENABLED",
              number: 29,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "STATUS_NOTIFICATION_TONE_ID",
              number: 30,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SHOULD_PLAY_SOUND_FOR_CALL_NOTIFICATION",
              number: 31,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CHAT_THEME_ID",
              number: 32,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COLOR_SCHEME_ID",
              number: 33,
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
          name: "SettingPlatform",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PLATFORM_UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WEB",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "HYBRID",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WINDOWS",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MAC",
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

  field(:startAtLogin, 1, optional: true, type: :bool)
  field(:minimizeToTray, 2, optional: true, type: :bool)
  field(:language, 3, optional: true, type: :string)
  field(:replaceTextWithEmoji, 4, optional: true, type: :bool)

  field(:bannerNotificationDisplayMode, 5,
    optional: true,
    type: WAWebProtobufSyncAction.SettingsSyncAction.DisplayMode,
    enum: true
  )

  field(:unreadCounterBadgeDisplayMode, 6,
    optional: true,
    type: WAWebProtobufSyncAction.SettingsSyncAction.DisplayMode,
    enum: true
  )

  field(:isMessagesNotificationEnabled, 7, optional: true, type: :bool)
  field(:isCallsNotificationEnabled, 8, optional: true, type: :bool)
  field(:isReactionsNotificationEnabled, 9, optional: true, type: :bool)
  field(:isStatusReactionsNotificationEnabled, 10, optional: true, type: :bool)
  field(:isTextPreviewForNotificationEnabled, 11, optional: true, type: :bool)
  field(:defaultNotificationToneID, 12, optional: true, type: :int32)
  field(:groupDefaultNotificationToneID, 13, optional: true, type: :int32)
  field(:appTheme, 14, optional: true, type: :int32)
  field(:wallpaperID, 15, optional: true, type: :int32)
  field(:isDoodleWallpaperEnabled, 16, optional: true, type: :bool)
  field(:fontSize, 17, optional: true, type: :int32)
  field(:isPhotosAutodownloadEnabled, 18, optional: true, type: :bool)
  field(:isAudiosAutodownloadEnabled, 19, optional: true, type: :bool)
  field(:isVideosAutodownloadEnabled, 20, optional: true, type: :bool)
  field(:isDocumentsAutodownloadEnabled, 21, optional: true, type: :bool)
  field(:disableLinkPreviews, 22, optional: true, type: :bool)
  field(:notificationToneID, 23, optional: true, type: :int32)

  field(:mediaUploadQuality, 24,
    optional: true,
    type: WAWebProtobufSyncAction.SettingsSyncAction.MediaQualitySetting,
    enum: true
  )

  field(:isSpellCheckEnabled, 25, optional: true, type: :bool)
  field(:isEnterToSendEnabled, 26, optional: true, type: :bool)
  field(:isGroupMessageNotificationEnabled, 27, optional: true, type: :bool)
  field(:isGroupReactionsNotificationEnabled, 28, optional: true, type: :bool)
  field(:isStatusNotificationEnabled, 29, optional: true, type: :bool)
  field(:statusNotificationToneID, 30, optional: true, type: :int32)
  field(:shouldPlaySoundForCallNotification, 31, optional: true, type: :bool)
  field(:chatThemeID, 32, optional: true, type: :string)
  field(:colorSchemeID, 33, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.InteractiveMessageAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.InteractiveMessageAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "InteractiveMessageAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "type",
          extendee: nil,
          number: 1,
          label: :LABEL_REQUIRED,
          type: :TYPE_ENUM,
          type_name:
            ".WAWebProtobufSyncAction.InteractiveMessageAction.InteractiveMessageActionMode",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "type",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "agmID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "agmID",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "InteractiveMessageActionMode",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DISABLE_CTA",
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

  field(:type, 1,
    required: true,
    type: WAWebProtobufSyncAction.InteractiveMessageAction.InteractiveMessageActionMode,
    enum: true
  )

  field(:agmID, 2, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.PrivateProcessingSettingAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.PrivateProcessingSettingAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PrivateProcessingSettingAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "privateProcessingStatus",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAWebProtobufSyncAction.PrivateProcessingSettingAction.PrivateProcessingStatus",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "privateProcessingStatus",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "PrivateProcessingStatus",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNDEFINED",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ENABLED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DISABLED",
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

  field(:privateProcessingStatus, 1,
    optional: true,
    type: WAWebProtobufSyncAction.PrivateProcessingSettingAction.PrivateProcessingStatus,
    enum: true
  )
end

defmodule WAWebProtobufSyncAction.AvatarUpdatedAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.AvatarUpdatedAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AvatarUpdatedAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "eventType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.AvatarUpdatedAction.AvatarEventType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "eventType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "recentAvatarStickers",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.StickerAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "recentAvatarStickers",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "AvatarEventType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UPDATED",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CREATED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DELETED",
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

  field(:eventType, 1,
    optional: true,
    type: WAWebProtobufSyncAction.AvatarUpdatedAction.AvatarEventType,
    enum: true
  )

  field(:recentAvatarStickers, 2, repeated: true, type: WAWebProtobufSyncAction.StickerAction)
end

defmodule WAWebProtobufSyncAction.BizAISettingsNudgeAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.BizAISettingsNudgeAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BizAISettingsNudgeAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "category",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.BizAISettingsNudgeAction.BizAISettingsCategory",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "category",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "version",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "version",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "updatedAtMS",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "updatedAtMS",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "BizAISettingsCategory",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INSTRUCTIONS",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RESPONSE_SETTINGS",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "EXAMPLE_RESPONSES",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "KNOWLEDGE",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "LEAD_GEN",
              number: 5,
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

  field(:category, 1,
    optional: true,
    type: WAWebProtobufSyncAction.BizAISettingsNudgeAction.BizAISettingsCategory,
    enum: true
  )

  field(:version, 2, optional: true, type: :int64)
  field(:updatedAtMS, 3, optional: true, type: :int64)
end

defmodule WAWebProtobufSyncAction.MaibaAIFeaturesControlAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.MaibaAIFeaturesControlAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MaibaAIFeaturesControlAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "aiFeatureStatus",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.MaibaAIFeaturesControlAction.MaibaAIFeatureStatus",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "aiFeatureStatus",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "MaibaAIFeatureStatus",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ENABLED",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ENABLED_HAS_LEARNING",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DISABLED",
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

  field(:aiFeatureStatus, 1,
    optional: true,
    type: WAWebProtobufSyncAction.MaibaAIFeaturesControlAction.MaibaAIFeatureStatus,
    enum: true
  )
end

defmodule WAWebProtobufSyncAction.PaymentTosAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.PaymentTosAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PaymentTosAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "paymentNotice",
          extendee: nil,
          number: 1,
          label: :LABEL_REQUIRED,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.PaymentTosAction.PaymentNotice",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "paymentNotice",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "accepted",
          extendee: nil,
          number: 2,
          label: :LABEL_REQUIRED,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "accepted",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "PaymentNotice",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BR_PAY_PRIVACY_POLICY",
              number: 0,
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

  field(:paymentNotice, 1,
    required: true,
    type: WAWebProtobufSyncAction.PaymentTosAction.PaymentNotice,
    enum: true
  )

  field(:accepted, 2, required: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.NotificationActivitySettingAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.NotificationActivitySettingAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "NotificationActivitySettingAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "notificationActivitySetting",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAWebProtobufSyncAction.NotificationActivitySettingAction.NotificationActivitySetting",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "notificationActivitySetting",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "NotificationActivitySetting",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DEFAULT_ALL_MESSAGES",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ALL_MESSAGES",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "HIGHLIGHTS",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DEFAULT_HIGHLIGHTS",
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

  field(:notificationActivitySetting, 1,
    optional: true,
    type: WAWebProtobufSyncAction.NotificationActivitySettingAction.NotificationActivitySetting,
    enum: true
  )
end

defmodule WAWebProtobufSyncAction.WaffleAccountLinkStateAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.WaffleAccountLinkStateAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "WaffleAccountLinkStateAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "linkState",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.WaffleAccountLinkStateAction.AccountLinkState",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "linkState",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "AccountLinkState",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ACTIVE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAUSED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNLINKED",
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

  field(:linkState, 2,
    optional: true,
    type: WAWebProtobufSyncAction.WaffleAccountLinkStateAction.AccountLinkState,
    enum: true
  )
end

defmodule WAWebProtobufSyncAction.MerchantPaymentPartnerAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.MerchantPaymentPartnerAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MerchantPaymentPartnerAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "status",
          extendee: nil,
          number: 1,
          label: :LABEL_REQUIRED,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.MerchantPaymentPartnerAction.Status",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "status",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "country",
          extendee: nil,
          number: 2,
          label: :LABEL_REQUIRED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "country",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "gatewayName",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "gatewayName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "credentialID",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "credentialID",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "Status",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ACTIVE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INACTIVE",
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

  field(:status, 1,
    required: true,
    type: WAWebProtobufSyncAction.MerchantPaymentPartnerAction.Status,
    enum: true
  )

  field(:country, 2, required: true, type: :string)
  field(:gatewayName, 3, optional: true, type: :string)
  field(:credentialID, 4, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.NoteEditAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.NoteEditAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "NoteEditAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "type",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.NoteEditAction.NoteType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "type",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatJID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "chatJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "createdAt",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "createdAt",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deleted",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deleted",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "unstructuredContent",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "unstructuredContent",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "NoteType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNSTRUCTURED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "STRUCTURED",
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

  field(:type, 1,
    optional: true,
    type: WAWebProtobufSyncAction.NoteEditAction.NoteType,
    enum: true
  )

  field(:chatJID, 2, optional: true, type: :string)
  field(:createdAt, 3, optional: true, type: :int64)
  field(:deleted, 4, optional: true, type: :bool)
  field(:unstructuredContent, 5, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.StatusPrivacyAction.CustomList do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.StatusPrivacyAction.CustomList",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "CustomList",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "listID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "listID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "name",
          extendee: nil,
          number: 2,
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
          name: "isSelected",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isSelected",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "userJID",
          extendee: nil,
          number: 5,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "userJID",
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

  field(:listID, 1, optional: true, type: :string)
  field(:name, 2, optional: true, type: :string)
  field(:emoji, 3, optional: true, type: :string)
  field(:isSelected, 4, optional: true, type: :bool)
  field(:userJID, 5, repeated: true, type: :string)
end

defmodule WAWebProtobufSyncAction.StatusPrivacyAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.StatusPrivacyAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "StatusPrivacyAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "mode",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.StatusPrivacyAction.StatusDistributionMode",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mode",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "userJID",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
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
          name: "shareToFB",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "shareToFB",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "shareToIG",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "shareToIG",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "customLists",
          extendee: nil,
          number: 5,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.StatusPrivacyAction.CustomList",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "customLists",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "modes",
          extendee: nil,
          number: 6,
          label: :LABEL_REPEATED,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.StatusPrivacyAction.StatusDistributionMode",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "modes",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "CustomList",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "listID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "listID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "name",
              extendee: nil,
              number: 2,
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
              name: "isSelected",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "isSelected",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "userJID",
              extendee: nil,
              number: 5,
              label: :LABEL_REPEATED,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "userJID",
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
          name: "StatusDistributionMode",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ALLOW_LIST",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DENY_LIST",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CONTACTS",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CLOSE_FRIENDS",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CUSTOM_LIST",
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
    type: WAWebProtobufSyncAction.StatusPrivacyAction.StatusDistributionMode,
    enum: true
  )

  field(:userJID, 2, repeated: true, type: :string)
  field(:shareToFB, 3, optional: true, type: :bool)
  field(:shareToIG, 4, optional: true, type: :bool)

  field(:customLists, 5,
    repeated: true,
    type: WAWebProtobufSyncAction.StatusPrivacyAction.CustomList
  )

  field(:modes, 6,
    repeated: true,
    type: WAWebProtobufSyncAction.StatusPrivacyAction.StatusDistributionMode,
    enum: true
  )
end

defmodule WAWebProtobufSyncAction.MarketingMessageAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.MarketingMessageAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MarketingMessageAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "name",
          extendee: nil,
          number: 1,
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
          name: "message",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "message",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "type",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAWebProtobufSyncAction.MarketingMessageAction.MarketingMessagePrototypeType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "type",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "createdAt",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "createdAt",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lastSentAt",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lastSentAt",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isDeleted",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isDeleted",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaID",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaID",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "MarketingMessagePrototypeType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PERSONALIZED",
              number: 0,
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

  field(:name, 1, optional: true, type: :string)
  field(:message, 2, optional: true, type: :string)

  field(:type, 3,
    optional: true,
    type: WAWebProtobufSyncAction.MarketingMessageAction.MarketingMessagePrototypeType,
    enum: true
  )

  field(:createdAt, 4, optional: true, type: :int64)
  field(:lastSentAt, 5, optional: true, type: :int64)
  field(:isDeleted, 6, optional: true, type: :bool)
  field(:mediaID, 7, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.UsernameChatStartModeAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.UsernameChatStartModeAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "UsernameChatStartModeAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatStartMode",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.UsernameChatStartModeAction.ChatStartMode",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "chatStartMode",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "ChatStartMode",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "LID",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PN",
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

  field(:chatStartMode, 1,
    optional: true,
    type: WAWebProtobufSyncAction.UsernameChatStartModeAction.ChatStartMode,
    enum: true
  )
end

defmodule WAWebProtobufSyncAction.LabelEditAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.LabelEditAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "LabelEditAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "name",
          extendee: nil,
          number: 1,
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
          name: "color",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "color",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "predefinedID",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "predefinedID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deleted",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deleted",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "orderIndex",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "orderIndex",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isActive",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isActive",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "type",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.LabelEditAction.ListType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "type",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isImmutable",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isImmutable",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "muteEndTimeMS",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "muteEndTimeMS",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "ListType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NONE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNREAD",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUPS",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FAVORITES",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PREDEFINED",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CUSTOM",
              number: 5,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY",
              number: 6,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SERVER_ASSIGNED",
              number: 7,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DRAFTED",
              number: 8,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_HANDOFF",
              number: 9,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CHANNELS",
              number: 10,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_RESPONDING",
              number: 11,
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

  field(:name, 1, optional: true, type: :string)
  field(:color, 2, optional: true, type: :int32)
  field(:predefinedID, 3, optional: true, type: :int32)
  field(:deleted, 4, optional: true, type: :bool)
  field(:orderIndex, 5, optional: true, type: :int32)
  field(:isActive, 6, optional: true, type: :bool)

  field(:type, 7,
    optional: true,
    type: WAWebProtobufSyncAction.LabelEditAction.ListType,
    enum: true
  )

  field(:isImmutable, 8, optional: true, type: :bool)
  field(:muteEndTimeMS, 9, optional: true, type: :int64)
end

defmodule WAWebProtobufSyncAction.PatchDebugData do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.PatchDebugData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PatchDebugData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "currentLthash",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "currentLthash",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "newLthash",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "newLthash",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "patchVersion",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "patchVersion",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "collectionName",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "collectionName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "firstFourBytesFromAHashOfSnapshotMACKey",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "firstFourBytesFromAHashOfSnapshotMACKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "newLthashSubtract",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "newLthashSubtract",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "numberAdd",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "numberAdd",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "numberRemove",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "numberRemove",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "numberOverride",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "numberOverride",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "senderPlatform",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.PatchDebugData.Platform",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "senderPlatform",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isSenderPrimary",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isSenderPrimary",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "Platform",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ANDROID",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SMBA",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IPHONE",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SMBI",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WEB",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UWP",
              number: 5,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DARWIN",
              number: 6,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IPAD",
              number: 7,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WEAROS",
              number: 8,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WASG",
              number: 9,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WEARM",
              number: 10,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CAPI",
              number: 11,
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

  field(:currentLthash, 1, optional: true, type: :bytes)
  field(:newLthash, 2, optional: true, type: :bytes)
  field(:patchVersion, 3, optional: true, type: :bytes)
  field(:collectionName, 4, optional: true, type: :bytes)
  field(:firstFourBytesFromAHashOfSnapshotMACKey, 5, optional: true, type: :bytes)
  field(:newLthashSubtract, 6, optional: true, type: :bytes)
  field(:numberAdd, 7, optional: true, type: :int32)
  field(:numberRemove, 8, optional: true, type: :int32)
  field(:numberOverride, 9, optional: true, type: :int32)

  field(:senderPlatform, 10,
    optional: true,
    type: WAWebProtobufSyncAction.PatchDebugData.Platform,
    enum: true
  )

  field(:isSenderPrimary, 11, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.RecentEmojiWeight do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.RecentEmojiWeight",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "RecentEmojiWeight",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "emoji",
          extendee: nil,
          number: 1,
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
          name: "weight",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_FLOAT,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "weight",
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

  field(:emoji, 1, optional: true, type: :string)
  field(:weight, 2, optional: true, type: :float)
end

defmodule WAWebProtobufSyncAction.SyncActionValue do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.SyncActionValue",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SyncActionValue",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "timestamp",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "timestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "starAction",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.StarAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "starAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "contactAction",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.ContactAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "contactAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "muteAction",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.MuteAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "muteAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pinAction",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.PinAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pinAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pushNameSetting",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.PushNameSetting",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pushNameSetting",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "quickReplyAction",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.QuickReplyAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "quickReplyAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "recentEmojiWeightsAction",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.RecentEmojiWeightsAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "recentEmojiWeightsAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "labelEditAction",
          extendee: nil,
          number: 14,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.LabelEditAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "labelEditAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "labelAssociationAction",
          extendee: nil,
          number: 15,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.LabelAssociationAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "labelAssociationAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "localeSetting",
          extendee: nil,
          number: 16,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.LocaleSetting",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "localeSetting",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "archiveChatAction",
          extendee: nil,
          number: 17,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.ArchiveChatAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "archiveChatAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deleteMessageForMeAction",
          extendee: nil,
          number: 18,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.DeleteMessageForMeAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deleteMessageForMeAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "keyExpiration",
          extendee: nil,
          number: 19,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.KeyExpiration",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "keyExpiration",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "markChatAsReadAction",
          extendee: nil,
          number: 20,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.MarkChatAsReadAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "markChatAsReadAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "clearChatAction",
          extendee: nil,
          number: 21,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.ClearChatAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "clearChatAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deleteChatAction",
          extendee: nil,
          number: 22,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.DeleteChatAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deleteChatAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "unarchiveChatsSetting",
          extendee: nil,
          number: 23,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.UnarchiveChatsSetting",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "unarchiveChatsSetting",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "primaryFeature",
          extendee: nil,
          number: 24,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.PrimaryFeature",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "primaryFeature",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "androidUnsupportedActions",
          extendee: nil,
          number: 26,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.AndroidUnsupportedActions",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "androidUnsupportedActions",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "agentAction",
          extendee: nil,
          number: 27,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.AgentAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "agentAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "subscriptionAction",
          extendee: nil,
          number: 28,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.SubscriptionAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "subscriptionAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "userStatusMuteAction",
          extendee: nil,
          number: 29,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.UserStatusMuteAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "userStatusMuteAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "timeFormatAction",
          extendee: nil,
          number: 30,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.TimeFormatAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "timeFormatAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "nuxAction",
          extendee: nil,
          number: 31,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.NuxAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "nuxAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "primaryVersionAction",
          extendee: nil,
          number: 32,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.PrimaryVersionAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "primaryVersionAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "stickerAction",
          extendee: nil,
          number: 33,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.StickerAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "stickerAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "removeRecentStickerAction",
          extendee: nil,
          number: 34,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.RemoveRecentStickerAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "removeRecentStickerAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatAssignment",
          extendee: nil,
          number: 35,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.ChatAssignmentAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "chatAssignment",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatAssignmentOpenedStatus",
          extendee: nil,
          number: 36,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.ChatAssignmentOpenedStatusAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "chatAssignmentOpenedStatus",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pnForLidChatAction",
          extendee: nil,
          number: 37,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.PnForLidChatAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pnForLidChatAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "marketingMessageAction",
          extendee: nil,
          number: 38,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.MarketingMessageAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "marketingMessageAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "marketingMessageBroadcastAction",
          extendee: nil,
          number: 39,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.MarketingMessageBroadcastAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "marketingMessageBroadcastAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "externalWebBetaAction",
          extendee: nil,
          number: 40,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.ExternalWebBetaAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "externalWebBetaAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "privacySettingRelayAllCalls",
          extendee: nil,
          number: 41,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.PrivacySettingRelayAllCalls",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "privacySettingRelayAllCalls",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "callLogAction",
          extendee: nil,
          number: 42,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.CallLogAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "callLogAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ugcBot",
          extendee: nil,
          number: 43,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.UGCBot",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ugcBot",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "statusPrivacy",
          extendee: nil,
          number: 44,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.StatusPrivacyAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "statusPrivacy",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botWelcomeRequestAction",
          extendee: nil,
          number: 45,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.BotWelcomeRequestAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botWelcomeRequestAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deleteIndividualCallLog",
          extendee: nil,
          number: 46,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.DeleteIndividualCallLogAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deleteIndividualCallLog",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "labelReorderingAction",
          extendee: nil,
          number: 47,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.LabelReorderingAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "labelReorderingAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "paymentInfoAction",
          extendee: nil,
          number: 48,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.PaymentInfoAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "paymentInfoAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "customPaymentMethodsAction",
          extendee: nil,
          number: 49,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.CustomPaymentMethodsAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "customPaymentMethodsAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lockChatAction",
          extendee: nil,
          number: 50,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.LockChatAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lockChatAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatLockSettings",
          extendee: nil,
          number: 51,
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
          name: "wamoUserIdentifierAction",
          extendee: nil,
          number: 52,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.WamoUserIdentifierAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "wamoUserIdentifierAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "privacySettingDisableLinkPreviewsAction",
          extendee: nil,
          number: 53,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.PrivacySettingDisableLinkPreviewsAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "privacySettingDisableLinkPreviewsAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deviceCapabilities",
          extendee: nil,
          number: 54,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsDeviceCapabilities.DeviceCapabilities",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deviceCapabilities",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "noteEditAction",
          extendee: nil,
          number: 55,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.NoteEditAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "noteEditAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "favoritesAction",
          extendee: nil,
          number: 56,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.FavoritesAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "favoritesAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "merchantPaymentPartnerAction",
          extendee: nil,
          number: 57,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.MerchantPaymentPartnerAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "merchantPaymentPartnerAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "waffleAccountLinkStateAction",
          extendee: nil,
          number: 58,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.WaffleAccountLinkStateAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "waffleAccountLinkStateAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "usernameChatStartMode",
          extendee: nil,
          number: 59,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.UsernameChatStartModeAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "usernameChatStartMode",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "notificationActivitySettingAction",
          extendee: nil,
          number: 60,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.NotificationActivitySettingAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "notificationActivitySettingAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lidContactAction",
          extendee: nil,
          number: 61,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.LidContactAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lidContactAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ctwaPerCustomerDataSharingAction",
          extendee: nil,
          number: 62,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.CtwaPerCustomerDataSharingAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ctwaPerCustomerDataSharingAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "paymentTosAction",
          extendee: nil,
          number: 63,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.PaymentTosAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "paymentTosAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "privacySettingChannelsPersonalisedRecommendationAction",
          extendee: nil,
          number: 64,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAWebProtobufSyncAction.PrivacySettingChannelsPersonalisedRecommendationAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "privacySettingChannelsPersonalisedRecommendationAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "detectedOutcomesStatusAction",
          extendee: nil,
          number: 66,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.DetectedOutcomesStatusAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "detectedOutcomesStatusAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "maibaAiFeaturesControlAction",
          extendee: nil,
          number: 68,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.MaibaAIFeaturesControlAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "maibaAiFeaturesControlAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "businessBroadcastListAction",
          extendee: nil,
          number: 69,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.BusinessBroadcastListAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "businessBroadcastListAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "musicUserIDAction",
          extendee: nil,
          number: 70,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.MusicUserIdAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "musicUserIDAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "statusPostOptInNotificationPreferencesAction",
          extendee: nil,
          number: 71,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.StatusPostOptInNotificationPreferencesAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "statusPostOptInNotificationPreferencesAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "avatarUpdatedAction",
          extendee: nil,
          number: 72,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.AvatarUpdatedAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "avatarUpdatedAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "privateProcessingSettingAction",
          extendee: nil,
          number: 74,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.PrivateProcessingSettingAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "privateProcessingSettingAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "newsletterSavedInterestsAction",
          extendee: nil,
          number: 75,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.NewsletterSavedInterestsAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "newsletterSavedInterestsAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "aiThreadRenameAction",
          extendee: nil,
          number: 76,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.AiThreadRenameAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "aiThreadRenameAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "interactiveMessageAction",
          extendee: nil,
          number: 77,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.InteractiveMessageAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "interactiveMessageAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "settingsSyncAction",
          extendee: nil,
          number: 78,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.SettingsSyncAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "settingsSyncAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "outContactAction",
          extendee: nil,
          number: 79,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.OutContactAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "outContactAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "nctSaltSyncAction",
          extendee: nil,
          number: 80,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.NctSaltSyncAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "nctSaltSyncAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "businessBroadcastCampaignAction",
          extendee: nil,
          number: 81,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.BusinessBroadcastCampaignAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "businessBroadcastCampaignAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "businessBroadcastInsightsAction",
          extendee: nil,
          number: 82,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.BusinessBroadcastInsightsAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "businessBroadcastInsightsAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "customerDataAction",
          extendee: nil,
          number: 83,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.CustomerDataAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "customerDataAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "subscriptionsSyncV2Action",
          extendee: nil,
          number: 84,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.SubscriptionsSyncV2Action",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "subscriptionsSyncV2Action",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "threadPinAction",
          extendee: nil,
          number: 85,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.ThreadPinAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "threadPinAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "autoOrganizeBusinessChatSetting",
          extendee: nil,
          number: 86,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.AutoOrganizeBusinessChatSetting",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "autoOrganizeBusinessChatSetting",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "bizAiSettingsNudgeAction",
          extendee: nil,
          number: 87,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.BizAISettingsNudgeAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "bizAiSettingsNudgeAction",
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

  field(:timestamp, 1, optional: true, type: :int64)
  field(:starAction, 2, optional: true, type: WAWebProtobufSyncAction.StarAction)
  field(:contactAction, 3, optional: true, type: WAWebProtobufSyncAction.ContactAction)
  field(:muteAction, 4, optional: true, type: WAWebProtobufSyncAction.MuteAction)
  field(:pinAction, 5, optional: true, type: WAWebProtobufSyncAction.PinAction)
  field(:pushNameSetting, 7, optional: true, type: WAWebProtobufSyncAction.PushNameSetting)
  field(:quickReplyAction, 8, optional: true, type: WAWebProtobufSyncAction.QuickReplyAction)

  field(:recentEmojiWeightsAction, 11,
    optional: true,
    type: WAWebProtobufSyncAction.RecentEmojiWeightsAction
  )

  field(:labelEditAction, 14, optional: true, type: WAWebProtobufSyncAction.LabelEditAction)

  field(:labelAssociationAction, 15,
    optional: true,
    type: WAWebProtobufSyncAction.LabelAssociationAction
  )

  field(:localeSetting, 16, optional: true, type: WAWebProtobufSyncAction.LocaleSetting)
  field(:archiveChatAction, 17, optional: true, type: WAWebProtobufSyncAction.ArchiveChatAction)

  field(:deleteMessageForMeAction, 18,
    optional: true,
    type: WAWebProtobufSyncAction.DeleteMessageForMeAction
  )

  field(:keyExpiration, 19, optional: true, type: WAWebProtobufSyncAction.KeyExpiration)

  field(:markChatAsReadAction, 20,
    optional: true,
    type: WAWebProtobufSyncAction.MarkChatAsReadAction
  )

  field(:clearChatAction, 21, optional: true, type: WAWebProtobufSyncAction.ClearChatAction)
  field(:deleteChatAction, 22, optional: true, type: WAWebProtobufSyncAction.DeleteChatAction)

  field(:unarchiveChatsSetting, 23,
    optional: true,
    type: WAWebProtobufSyncAction.UnarchiveChatsSetting
  )

  field(:primaryFeature, 24, optional: true, type: WAWebProtobufSyncAction.PrimaryFeature)

  field(:androidUnsupportedActions, 26,
    optional: true,
    type: WAWebProtobufSyncAction.AndroidUnsupportedActions
  )

  field(:agentAction, 27, optional: true, type: WAWebProtobufSyncAction.AgentAction)
  field(:subscriptionAction, 28, optional: true, type: WAWebProtobufSyncAction.SubscriptionAction)

  field(:userStatusMuteAction, 29,
    optional: true,
    type: WAWebProtobufSyncAction.UserStatusMuteAction
  )

  field(:timeFormatAction, 30, optional: true, type: WAWebProtobufSyncAction.TimeFormatAction)
  field(:nuxAction, 31, optional: true, type: WAWebProtobufSyncAction.NuxAction)

  field(:primaryVersionAction, 32,
    optional: true,
    type: WAWebProtobufSyncAction.PrimaryVersionAction
  )

  field(:stickerAction, 33, optional: true, type: WAWebProtobufSyncAction.StickerAction)

  field(:removeRecentStickerAction, 34,
    optional: true,
    type: WAWebProtobufSyncAction.RemoveRecentStickerAction
  )

  field(:chatAssignment, 35, optional: true, type: WAWebProtobufSyncAction.ChatAssignmentAction)

  field(:chatAssignmentOpenedStatus, 36,
    optional: true,
    type: WAWebProtobufSyncAction.ChatAssignmentOpenedStatusAction
  )

  field(:pnForLidChatAction, 37, optional: true, type: WAWebProtobufSyncAction.PnForLidChatAction)

  field(:marketingMessageAction, 38,
    optional: true,
    type: WAWebProtobufSyncAction.MarketingMessageAction
  )

  field(:marketingMessageBroadcastAction, 39,
    optional: true,
    type: WAWebProtobufSyncAction.MarketingMessageBroadcastAction
  )

  field(:externalWebBetaAction, 40,
    optional: true,
    type: WAWebProtobufSyncAction.ExternalWebBetaAction
  )

  field(:privacySettingRelayAllCalls, 41,
    optional: true,
    type: WAWebProtobufSyncAction.PrivacySettingRelayAllCalls
  )

  field(:callLogAction, 42, optional: true, type: WAWebProtobufSyncAction.CallLogAction)
  field(:ugcBot, 43, optional: true, type: WAWebProtobufSyncAction.UGCBot)
  field(:statusPrivacy, 44, optional: true, type: WAWebProtobufSyncAction.StatusPrivacyAction)

  field(:botWelcomeRequestAction, 45,
    optional: true,
    type: WAWebProtobufSyncAction.BotWelcomeRequestAction
  )

  field(:deleteIndividualCallLog, 46,
    optional: true,
    type: WAWebProtobufSyncAction.DeleteIndividualCallLogAction
  )

  field(:labelReorderingAction, 47,
    optional: true,
    type: WAWebProtobufSyncAction.LabelReorderingAction
  )

  field(:paymentInfoAction, 48, optional: true, type: WAWebProtobufSyncAction.PaymentInfoAction)

  field(:customPaymentMethodsAction, 49,
    optional: true,
    type: WAWebProtobufSyncAction.CustomPaymentMethodsAction
  )

  field(:lockChatAction, 50, optional: true, type: WAWebProtobufSyncAction.LockChatAction)

  field(:chatLockSettings, 51,
    optional: true,
    type: WAWebProtobufsChatLockSettings.ChatLockSettings
  )

  field(:wamoUserIdentifierAction, 52,
    optional: true,
    type: WAWebProtobufSyncAction.WamoUserIdentifierAction
  )

  field(:privacySettingDisableLinkPreviewsAction, 53,
    optional: true,
    type: WAWebProtobufSyncAction.PrivacySettingDisableLinkPreviewsAction
  )

  field(:deviceCapabilities, 54,
    optional: true,
    type: WAWebProtobufsDeviceCapabilities.DeviceCapabilities
  )

  field(:noteEditAction, 55, optional: true, type: WAWebProtobufSyncAction.NoteEditAction)
  field(:favoritesAction, 56, optional: true, type: WAWebProtobufSyncAction.FavoritesAction)

  field(:merchantPaymentPartnerAction, 57,
    optional: true,
    type: WAWebProtobufSyncAction.MerchantPaymentPartnerAction
  )

  field(:waffleAccountLinkStateAction, 58,
    optional: true,
    type: WAWebProtobufSyncAction.WaffleAccountLinkStateAction
  )

  field(:usernameChatStartMode, 59,
    optional: true,
    type: WAWebProtobufSyncAction.UsernameChatStartModeAction
  )

  field(:notificationActivitySettingAction, 60,
    optional: true,
    type: WAWebProtobufSyncAction.NotificationActivitySettingAction
  )

  field(:lidContactAction, 61, optional: true, type: WAWebProtobufSyncAction.LidContactAction)

  field(:ctwaPerCustomerDataSharingAction, 62,
    optional: true,
    type: WAWebProtobufSyncAction.CtwaPerCustomerDataSharingAction
  )

  field(:paymentTosAction, 63, optional: true, type: WAWebProtobufSyncAction.PaymentTosAction)

  field(:privacySettingChannelsPersonalisedRecommendationAction, 64,
    optional: true,
    type: WAWebProtobufSyncAction.PrivacySettingChannelsPersonalisedRecommendationAction
  )

  field(:detectedOutcomesStatusAction, 66,
    optional: true,
    type: WAWebProtobufSyncAction.DetectedOutcomesStatusAction
  )

  field(:maibaAiFeaturesControlAction, 68,
    optional: true,
    type: WAWebProtobufSyncAction.MaibaAIFeaturesControlAction
  )

  field(:businessBroadcastListAction, 69,
    optional: true,
    type: WAWebProtobufSyncAction.BusinessBroadcastListAction
  )

  field(:musicUserIDAction, 70, optional: true, type: WAWebProtobufSyncAction.MusicUserIdAction)

  field(:statusPostOptInNotificationPreferencesAction, 71,
    optional: true,
    type: WAWebProtobufSyncAction.StatusPostOptInNotificationPreferencesAction
  )

  field(:avatarUpdatedAction, 72,
    optional: true,
    type: WAWebProtobufSyncAction.AvatarUpdatedAction
  )

  field(:privateProcessingSettingAction, 74,
    optional: true,
    type: WAWebProtobufSyncAction.PrivateProcessingSettingAction
  )

  field(:newsletterSavedInterestsAction, 75,
    optional: true,
    type: WAWebProtobufSyncAction.NewsletterSavedInterestsAction
  )

  field(:aiThreadRenameAction, 76,
    optional: true,
    type: WAWebProtobufSyncAction.AiThreadRenameAction
  )

  field(:interactiveMessageAction, 77,
    optional: true,
    type: WAWebProtobufSyncAction.InteractiveMessageAction
  )

  field(:settingsSyncAction, 78, optional: true, type: WAWebProtobufSyncAction.SettingsSyncAction)
  field(:outContactAction, 79, optional: true, type: WAWebProtobufSyncAction.OutContactAction)
  field(:nctSaltSyncAction, 80, optional: true, type: WAWebProtobufSyncAction.NctSaltSyncAction)

  field(:businessBroadcastCampaignAction, 81,
    optional: true,
    type: WAWebProtobufSyncAction.BusinessBroadcastCampaignAction
  )

  field(:businessBroadcastInsightsAction, 82,
    optional: true,
    type: WAWebProtobufSyncAction.BusinessBroadcastInsightsAction
  )

  field(:customerDataAction, 83, optional: true, type: WAWebProtobufSyncAction.CustomerDataAction)

  field(:subscriptionsSyncV2Action, 84,
    optional: true,
    type: WAWebProtobufSyncAction.SubscriptionsSyncV2Action
  )

  field(:threadPinAction, 85, optional: true, type: WAWebProtobufSyncAction.ThreadPinAction)

  field(:autoOrganizeBusinessChatSetting, 86,
    optional: true,
    type: WAWebProtobufSyncAction.AutoOrganizeBusinessChatSetting
  )

  field(:bizAiSettingsNudgeAction, 87,
    optional: true,
    type: WAWebProtobufSyncAction.BizAISettingsNudgeAction
  )
end

defmodule WAWebProtobufSyncAction.SubscriptionsSyncV2Action.PaidFeature do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.SubscriptionsSyncV2Action.PaidFeature",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PaidFeature",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "name",
          extendee: nil,
          number: 1,
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
          name: "enabled",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "enabled",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "limit",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "limit",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "expirationTime",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "expirationTime",
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

  field(:name, 1, optional: true, type: :string)
  field(:enabled, 2, optional: true, type: :bool)
  field(:limit, 3, optional: true, type: :int32)
  field(:expirationTime, 4, optional: true, type: :int64)
end

defmodule WAWebProtobufSyncAction.SubscriptionsSyncV2Action.SubscriptionInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.SubscriptionsSyncV2Action.SubscriptionInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SubscriptionInfo",
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
          name: "tier",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "tier",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "status",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "status",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "startTime",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "startTime",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "endTime",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "endTime",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isPlatformChanged",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isPlatformChanged",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "source",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "source",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "creationTime",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "creationTime",
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
  field(:tier, 2, optional: true, type: :int32)
  field(:status, 3, optional: true, type: :string)
  field(:startTime, 4, optional: true, type: :int64)
  field(:endTime, 5, optional: true, type: :int64)
  field(:isPlatformChanged, 6, optional: true, type: :bool)
  field(:source, 7, optional: true, type: :string)
  field(:creationTime, 8, optional: true, type: :int64)
end

defmodule WAWebProtobufSyncAction.SubscriptionsSyncV2Action do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.SubscriptionsSyncV2Action",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SubscriptionsSyncV2Action",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "subscriptions",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.SubscriptionsSyncV2Action.SubscriptionInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "subscriptions",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "paidFeature",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.SubscriptionsSyncV2Action.PaidFeature",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "paidFeature",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "PaidFeature",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "name",
              extendee: nil,
              number: 1,
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
              name: "enabled",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "enabled",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "limit",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "limit",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "expirationTime",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "expirationTime",
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
          name: "SubscriptionInfo",
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
              name: "tier",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "tier",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "status",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "status",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "startTime",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "startTime",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "endTime",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "endTime",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "isPlatformChanged",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "isPlatformChanged",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "source",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "source",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "creationTime",
              extendee: nil,
              number: 8,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "creationTime",
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

  field(:subscriptions, 1,
    repeated: true,
    type: WAWebProtobufSyncAction.SubscriptionsSyncV2Action.SubscriptionInfo
  )

  field(:paidFeature, 2,
    repeated: true,
    type: WAWebProtobufSyncAction.SubscriptionsSyncV2Action.PaidFeature
  )
end

defmodule WAWebProtobufSyncAction.CustomerDataAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.CustomerDataAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "CustomerDataAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatJID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "chatJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "contactType",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "contactType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "email",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "email",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "altPhoneNumbers",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "altPhoneNumbers",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "birthday",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "birthday",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "address",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "address",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "acquisitionSource",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "acquisitionSource",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "leadStage",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "leadStage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lastOrder",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lastOrder",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "createdAt",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "createdAt",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "modifiedAt",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "modifiedAt",
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

  field(:chatJID, 1, optional: true, type: :string)
  field(:contactType, 2, optional: true, type: :int32)
  field(:email, 3, optional: true, type: :string)
  field(:altPhoneNumbers, 4, optional: true, type: :string)
  field(:birthday, 5, optional: true, type: :int64)
  field(:address, 6, optional: true, type: :string)
  field(:acquisitionSource, 7, optional: true, type: :int32)
  field(:leadStage, 8, optional: true, type: :int32)
  field(:lastOrder, 9, optional: true, type: :int64)
  field(:createdAt, 10, optional: true, type: :int64)
  field(:modifiedAt, 11, optional: true, type: :int64)
end

defmodule WAWebProtobufSyncAction.BusinessBroadcastInsightsAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.BusinessBroadcastInsightsAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BusinessBroadcastInsightsAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "recipientCount",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "recipientCount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deliveredCount",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deliveredCount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "readCount",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "readCount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "repliedCount",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "repliedCount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "quickReplyCount",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "quickReplyCount",
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

  field(:recipientCount, 1, optional: true, type: :int32)
  field(:deliveredCount, 2, optional: true, type: :int32)
  field(:readCount, 3, optional: true, type: :int32)
  field(:repliedCount, 4, optional: true, type: :int32)
  field(:quickReplyCount, 5, optional: true, type: :int32)
end

defmodule WAWebProtobufSyncAction.AutoOrganizeBusinessChatSetting do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.AutoOrganizeBusinessChatSetting",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AutoOrganizeBusinessChatSetting",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "autoOrganize",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "autoOrganize",
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

  field(:autoOrganize, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.NctSaltSyncAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.NctSaltSyncAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "NctSaltSyncAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "salt",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "salt",
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

  field(:salt, 1, optional: true, type: :bytes)
end

defmodule WAWebProtobufSyncAction.ThreadPinAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.ThreadPinAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ThreadPinAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "pinned",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pinned",
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

  field(:pinned, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.AiThreadRenameAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.AiThreadRenameAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AiThreadRenameAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "newTitle",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "newTitle",
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

  field(:newTitle, 1, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.StatusPostOptInNotificationPreferencesAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.StatusPostOptInNotificationPreferencesAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "StatusPostOptInNotificationPreferencesAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "enabled",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "enabled",
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

  field(:enabled, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.BroadcastListParticipant do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.BroadcastListParticipant",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BroadcastListParticipant",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "lidJID",
          extendee: nil,
          number: 1,
          label: :LABEL_REQUIRED,
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
          name: "pnJID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pnJID",
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

  field(:lidJID, 1, required: true, type: :string)
  field(:pnJID, 2, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.BusinessBroadcastCampaignAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.BusinessBroadcastCampaignAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BusinessBroadcastCampaignAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "deviceID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deviceID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "adID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "adID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "name",
          extendee: nil,
          number: 3,
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
          name: "msgID",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "msgID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "broadcastJID",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "broadcastJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "reservedQuota",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "reservedQuota",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "scheduledTimestamp",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "scheduledTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "createTimestamp",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "createTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "status",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufSyncAction.BusinessBroadcastCampaignStatus",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "status",
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

  field(:deviceID, 1, optional: true, type: :int32)
  field(:adID, 2, optional: true, type: :string)
  field(:name, 3, optional: true, type: :string)
  field(:msgID, 4, optional: true, type: :string)
  field(:broadcastJID, 5, optional: true, type: :string)
  field(:reservedQuota, 6, optional: true, type: :int32)
  field(:scheduledTimestamp, 7, optional: true, type: :int64)
  field(:createTimestamp, 8, optional: true, type: :int64)

  field(:status, 9,
    optional: true,
    type: WAWebProtobufSyncAction.BusinessBroadcastCampaignStatus,
    enum: true
  )
end

defmodule WAWebProtobufSyncAction.BusinessBroadcastListAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.BusinessBroadcastListAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BusinessBroadcastListAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "deleted",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deleted",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "participants",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.BroadcastListParticipant",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "participants",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "listName",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "listName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "labelIDs",
          extendee: nil,
          number: 4,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "labelIDs",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "audienceExpression",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "audienceExpression",
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

  field(:deleted, 1, optional: true, type: :bool)
  field(:participants, 2, repeated: true, type: WAWebProtobufSyncAction.BroadcastListParticipant)
  field(:listName, 3, optional: true, type: :string)
  field(:labelIDs, 4, repeated: true, type: :string)
  field(:audienceExpression, 5, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.BusinessBroadcastAssociationAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.BusinessBroadcastAssociationAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BusinessBroadcastAssociationAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "deleted",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deleted",
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

  field(:deleted, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.CtwaPerCustomerDataSharingAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.CtwaPerCustomerDataSharingAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "CtwaPerCustomerDataSharingAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "isCtwaPerCustomerDataSharingEnabled",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isCtwaPerCustomerDataSharingEnabled",
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

  field(:isCtwaPerCustomerDataSharingEnabled, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.OutContactAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.OutContactAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "OutContactAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "fullName",
          extendee: nil,
          number: 1,
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
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "firstName",
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

  field(:fullName, 1, optional: true, type: :string)
  field(:firstName, 2, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.LidContactAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.LidContactAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "LidContactAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "fullName",
          extendee: nil,
          number: 1,
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
          number: 2,
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
          number: 3,
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

  field(:fullName, 1, optional: true, type: :string)
  field(:firstName, 2, optional: true, type: :string)
  field(:username, 3, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.FavoritesAction.Favorite do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.FavoritesAction.Favorite",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Favorite",
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
end

defmodule WAWebProtobufSyncAction.FavoritesAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.FavoritesAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "FavoritesAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "favorites",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.FavoritesAction.Favorite",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "favorites",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Favorite",
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

  field(:favorites, 1, repeated: true, type: WAWebProtobufSyncAction.FavoritesAction.Favorite)
end

defmodule WAWebProtobufSyncAction.PrivacySettingChannelsPersonalisedRecommendationAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.PrivacySettingChannelsPersonalisedRecommendationAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PrivacySettingChannelsPersonalisedRecommendationAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "isUserOptedOut",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isUserOptedOut",
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

  field(:isUserOptedOut, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.PrivacySettingDisableLinkPreviewsAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.PrivacySettingDisableLinkPreviewsAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PrivacySettingDisableLinkPreviewsAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "isPreviewsDisabled",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isPreviewsDisabled",
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

  field(:isPreviewsDisabled, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.WamoUserIdentifierAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.WamoUserIdentifierAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "WamoUserIdentifierAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "identifier",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "identifier",
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

  field(:identifier, 1, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.LockChatAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.LockChatAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "LockChatAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "locked",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "locked",
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

  field(:locked, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.CustomPaymentMethodsAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.CustomPaymentMethodsAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "CustomPaymentMethodsAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "customPaymentMethods",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.CustomPaymentMethod",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "customPaymentMethods",
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

  field(:customPaymentMethods, 1,
    repeated: true,
    type: WAWebProtobufSyncAction.CustomPaymentMethod
  )
end

defmodule WAWebProtobufSyncAction.CustomPaymentMethod do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.CustomPaymentMethod",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "CustomPaymentMethod",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "credentialID",
          extendee: nil,
          number: 1,
          label: :LABEL_REQUIRED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "credentialID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "country",
          extendee: nil,
          number: 2,
          label: :LABEL_REQUIRED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "country",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "type",
          extendee: nil,
          number: 3,
          label: :LABEL_REQUIRED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "type",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "metadata",
          extendee: nil,
          number: 4,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.CustomPaymentMethodMetadata",
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
      oneof_decl: [],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  field(:credentialID, 1, required: true, type: :string)
  field(:country, 2, required: true, type: :string)
  field(:type, 3, required: true, type: :string)
  field(:metadata, 4, repeated: true, type: WAWebProtobufSyncAction.CustomPaymentMethodMetadata)
end

defmodule WAWebProtobufSyncAction.CustomPaymentMethodMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.CustomPaymentMethodMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "CustomPaymentMethodMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "key",
          extendee: nil,
          number: 1,
          label: :LABEL_REQUIRED,
          type: :TYPE_STRING,
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
          label: :LABEL_REQUIRED,
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

  field(:key, 1, required: true, type: :string)
  field(:value, 2, required: true, type: :string)
end

defmodule WAWebProtobufSyncAction.PaymentInfoAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.PaymentInfoAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PaymentInfoAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "cpi",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "cpi",
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

  field(:cpi, 1, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.LabelReorderingAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.LabelReorderingAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "LabelReorderingAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "sortedLabelIDs",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sortedLabelIDs",
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

  field(:sortedLabelIDs, 1, repeated: true, type: :int32)
end

defmodule WAWebProtobufSyncAction.DeleteIndividualCallLogAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.DeleteIndividualCallLogAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "DeleteIndividualCallLogAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "peerJID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "peerJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isIncoming",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isIncoming",
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

  field(:peerJID, 1, optional: true, type: :string)
  field(:isIncoming, 2, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.BotWelcomeRequestAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.BotWelcomeRequestAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotWelcomeRequestAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "isSent",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isSent",
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

  field(:isSent, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.NewsletterSavedInterestsAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.NewsletterSavedInterestsAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "NewsletterSavedInterestsAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "newsletterSavedInterests",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "newsletterSavedInterests",
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

  field(:newsletterSavedInterests, 1, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.MusicUserIdAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.MusicUserIdAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MusicUserIdAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "musicUserID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "musicUserID",
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

  field(:musicUserID, 1, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.UGCBot do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.UGCBot",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "UGCBot",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "definition",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "definition",
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

  field(:definition, 1, optional: true, type: :bytes)
end

defmodule WAWebProtobufSyncAction.CallLogAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.CallLogAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "CallLogAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "callLogRecord",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.CallLogRecord",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "callLogRecord",
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

  field(:callLogRecord, 1, optional: true, type: WAWebProtobufSyncAction.CallLogRecord)
end

defmodule WAWebProtobufSyncAction.PrivacySettingRelayAllCalls do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.PrivacySettingRelayAllCalls",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PrivacySettingRelayAllCalls",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "isEnabled",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isEnabled",
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

  field(:isEnabled, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.DetectedOutcomesStatusAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.DetectedOutcomesStatusAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "DetectedOutcomesStatusAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "isEnabled",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isEnabled",
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

  field(:isEnabled, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.ExternalWebBetaAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.ExternalWebBetaAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ExternalWebBetaAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "isOptIn",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isOptIn",
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

  field(:isOptIn, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.MarketingMessageBroadcastAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.MarketingMessageBroadcastAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MarketingMessageBroadcastAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "repliedCount",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "repliedCount",
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

  field(:repliedCount, 1, optional: true, type: :int32)
end

defmodule WAWebProtobufSyncAction.PnForLidChatAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.PnForLidChatAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PnForLidChatAction",
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
end

defmodule WAWebProtobufSyncAction.ChatAssignmentOpenedStatusAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.ChatAssignmentOpenedStatusAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ChatAssignmentOpenedStatusAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatOpened",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "chatOpened",
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

  field(:chatOpened, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.ChatAssignmentAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.ChatAssignmentAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ChatAssignmentAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "deviceAgentID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deviceAgentID",
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

  field(:deviceAgentID, 1, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.StickerAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.StickerAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "StickerAction",
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
          name: "fileEncSHA256",
          extendee: nil,
          number: 2,
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
          number: 3,
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
          name: "height",
          extendee: nil,
          number: 5,
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
          number: 6,
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
          number: 7,
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
          number: 8,
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
          name: "isFavorite",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isFavorite",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deviceIDHint",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deviceIDHint",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isLottie",
          extendee: nil,
          number: 11,
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
          number: 12,
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
          number: 13,
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
  field(:fileEncSHA256, 2, optional: true, type: :bytes)
  field(:mediaKey, 3, optional: true, type: :bytes)
  field(:mimetype, 4, optional: true, type: :string)
  field(:height, 5, optional: true, type: :uint32)
  field(:width, 6, optional: true, type: :uint32)
  field(:directPath, 7, optional: true, type: :string)
  field(:fileLength, 8, optional: true, type: :uint64)
  field(:isFavorite, 9, optional: true, type: :bool)
  field(:deviceIDHint, 10, optional: true, type: :uint32)
  field(:isLottie, 11, optional: true, type: :bool)
  field(:imageHash, 12, optional: true, type: :string)
  field(:isAvatarSticker, 13, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.RemoveRecentStickerAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.RemoveRecentStickerAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "RemoveRecentStickerAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "lastStickerSentTS",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lastStickerSentTS",
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

  field(:lastStickerSentTS, 1, optional: true, type: :int64)
end

defmodule WAWebProtobufSyncAction.PrimaryVersionAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.PrimaryVersionAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PrimaryVersionAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "version",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "version",
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

  field(:version, 1, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.NuxAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.NuxAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "NuxAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "acknowledged",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "acknowledged",
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

  field(:acknowledged, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.TimeFormatAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.TimeFormatAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "TimeFormatAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "isTwentyFourHourFormatEnabled",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isTwentyFourHourFormatEnabled",
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

  field(:isTwentyFourHourFormatEnabled, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.UserStatusMuteAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.UserStatusMuteAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "UserStatusMuteAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "muted",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "muted",
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

  field(:muted, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.SubscriptionAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.SubscriptionAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SubscriptionAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "isDeactivated",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isDeactivated",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isAutoRenewing",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isAutoRenewing",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "expirationDate",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "expirationDate",
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

  field(:isDeactivated, 1, optional: true, type: :bool)
  field(:isAutoRenewing, 2, optional: true, type: :bool)
  field(:expirationDate, 3, optional: true, type: :int64)
end

defmodule WAWebProtobufSyncAction.AgentAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.AgentAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AgentAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "name",
          extendee: nil,
          number: 1,
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
          name: "deviceID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deviceID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isDeleted",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isDeleted",
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

  field(:name, 1, optional: true, type: :string)
  field(:deviceID, 2, optional: true, type: :int32)
  field(:isDeleted, 3, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.AndroidUnsupportedActions do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.AndroidUnsupportedActions",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AndroidUnsupportedActions",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "allowed",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "allowed",
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

  field(:allowed, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.PrimaryFeature do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.PrimaryFeature",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PrimaryFeature",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "flags",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "flags",
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

  field(:flags, 1, repeated: true, type: :string)
end

defmodule WAWebProtobufSyncAction.KeyExpiration do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.KeyExpiration",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "KeyExpiration",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "expiredKeyEpoch",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "expiredKeyEpoch",
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

  field(:expiredKeyEpoch, 1, optional: true, type: :int32)
end

defmodule WAWebProtobufSyncAction.SyncActionMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.SyncActionMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SyncActionMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "key",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "key",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "timestamp",
          extendee: nil,
          number: 2,
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

  field(:key, 1, optional: true, type: WACommon.MessageKey)
  field(:timestamp, 2, optional: true, type: :int64)
end

defmodule WAWebProtobufSyncAction.SyncActionMessageRange do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.SyncActionMessageRange",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SyncActionMessageRange",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "lastMessageTimestamp",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lastMessageTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lastSystemMessageTimestamp",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lastSystemMessageTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messages",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.SyncActionMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messages",
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

  field(:lastMessageTimestamp, 1, optional: true, type: :int64)
  field(:lastSystemMessageTimestamp, 2, optional: true, type: :int64)
  field(:messages, 3, repeated: true, type: WAWebProtobufSyncAction.SyncActionMessage)
end

defmodule WAWebProtobufSyncAction.UnarchiveChatsSetting do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.UnarchiveChatsSetting",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "UnarchiveChatsSetting",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "unarchiveChats",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "unarchiveChats",
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

  field(:unarchiveChats, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.DeleteChatAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.DeleteChatAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "DeleteChatAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageRange",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.SyncActionMessageRange",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageRange",
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

  field(:messageRange, 1, optional: true, type: WAWebProtobufSyncAction.SyncActionMessageRange)
end

defmodule WAWebProtobufSyncAction.ClearChatAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.ClearChatAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ClearChatAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageRange",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.SyncActionMessageRange",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageRange",
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

  field(:messageRange, 1, optional: true, type: WAWebProtobufSyncAction.SyncActionMessageRange)
end

defmodule WAWebProtobufSyncAction.MarkChatAsReadAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.MarkChatAsReadAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MarkChatAsReadAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "read",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "read",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageRange",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.SyncActionMessageRange",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageRange",
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

  field(:read, 1, optional: true, type: :bool)
  field(:messageRange, 2, optional: true, type: WAWebProtobufSyncAction.SyncActionMessageRange)
end

defmodule WAWebProtobufSyncAction.DeleteMessageForMeAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.DeleteMessageForMeAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "DeleteMessageForMeAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "deleteMedia",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deleteMedia",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageTimestamp",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageTimestamp",
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

  field(:deleteMedia, 1, optional: true, type: :bool)
  field(:messageTimestamp, 2, optional: true, type: :int64)
end

defmodule WAWebProtobufSyncAction.ArchiveChatAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.ArchiveChatAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ArchiveChatAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "archived",
          extendee: nil,
          number: 1,
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
          name: "messageRange",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.SyncActionMessageRange",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageRange",
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

  field(:archived, 1, optional: true, type: :bool)
  field(:messageRange, 2, optional: true, type: WAWebProtobufSyncAction.SyncActionMessageRange)
end

defmodule WAWebProtobufSyncAction.RecentEmojiWeightsAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.RecentEmojiWeightsAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "RecentEmojiWeightsAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "weights",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.RecentEmojiWeight",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "weights",
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

  field(:weights, 1, repeated: true, type: WAWebProtobufSyncAction.RecentEmojiWeight)
end

defmodule WAWebProtobufSyncAction.LabelAssociationAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.LabelAssociationAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "LabelAssociationAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "labeled",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "labeled",
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

  field(:labeled, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.QuickReplyAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.QuickReplyAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "QuickReplyAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "shortcut",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "shortcut",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "message",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "message",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "keywords",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "keywords",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "count",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "count",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deleted",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deleted",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "associatedLabelIDs",
          extendee: nil,
          number: 6,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "associatedLabelIDs",
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

  field(:shortcut, 1, optional: true, type: :string)
  field(:message, 2, optional: true, type: :string)
  field(:keywords, 3, repeated: true, type: :string)
  field(:count, 4, optional: true, type: :int32)
  field(:deleted, 5, optional: true, type: :bool)
  field(:associatedLabelIDs, 6, repeated: true, type: :string)
end

defmodule WAWebProtobufSyncAction.LocaleSetting do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.LocaleSetting",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "LocaleSetting",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "locale",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "locale",
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

  field(:locale, 1, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.PushNameSetting do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.PushNameSetting",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PushNameSetting",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "name",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "name",
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

  field(:name, 1, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.PinAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.PinAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PinAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "pinned",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pinned",
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

  field(:pinned, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.MuteAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.MuteAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MuteAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "muted",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "muted",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "muteEndTimestamp",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "muteEndTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "autoMuted",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "autoMuted",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "muteEveryoneMentionEndTimestamp",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "muteEveryoneMentionEndTimestamp",
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

  field(:muted, 1, optional: true, type: :bool)
  field(:muteEndTimestamp, 2, optional: true, type: :int64)
  field(:autoMuted, 3, optional: true, type: :bool)
  field(:muteEveryoneMentionEndTimestamp, 4, optional: true, type: :int64)
end

defmodule WAWebProtobufSyncAction.ContactAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.ContactAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ContactAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "fullName",
          extendee: nil,
          number: 1,
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
          number: 2,
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
          name: "lidJID",
          extendee: nil,
          number: 3,
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
          name: "saveOnPrimaryAddressbook",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "saveOnPrimaryAddressbook",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pnJID",
          extendee: nil,
          number: 5,
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
          name: "username",
          extendee: nil,
          number: 6,
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

  field(:fullName, 1, optional: true, type: :string)
  field(:firstName, 2, optional: true, type: :string)
  field(:lidJID, 3, optional: true, type: :string)
  field(:saveOnPrimaryAddressbook, 4, optional: true, type: :bool)
  field(:pnJID, 5, optional: true, type: :string)
  field(:username, 6, optional: true, type: :string)
end

defmodule WAWebProtobufSyncAction.StarAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.StarAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "StarAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "starred",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "starred",
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

  field(:starred, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufSyncAction.SyncActionData do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufSyncAction.SyncActionData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SyncActionData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "index",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "index",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "value",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufSyncAction.SyncActionValue",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "value",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "padding",
          extendee: nil,
          number: 3,
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
          name: "version",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "version",
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

  field(:index, 1, optional: true, type: :bytes)
  field(:value, 2, optional: true, type: WAWebProtobufSyncAction.SyncActionValue)
  field(:padding, 3, optional: true, type: :bytes)
  field(:version, 4, optional: true, type: :int32)
end
