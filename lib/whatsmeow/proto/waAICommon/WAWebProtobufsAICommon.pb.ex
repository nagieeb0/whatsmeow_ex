defmodule WAWebProtobufsAICommon.BotMetricsEntryPoint do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotMetricsEntryPoint",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotMetricsEntryPoint",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNDEFINED_ENTRY_POINT",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FAVICON",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CHATLIST",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AISEARCH_NULL_STATE_PAPER_PLANE",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AISEARCH_NULL_STATE_SUGGESTION",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AISEARCH_TYPE_AHEAD_SUGGESTION",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AISEARCH_TYPE_AHEAD_PAPER_PLANE",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AISEARCH_TYPE_AHEAD_RESULT_CHATLIST",
          number: 7,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AISEARCH_TYPE_AHEAD_RESULT_MESSAGES",
          number: 8,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AIVOICE_SEARCH_BAR",
          number: 9,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AIVOICE_FAVICON",
          number: 10,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AISTUDIO",
          number: 11,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DEEPLINK",
          number: 12,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NOTIFICATION",
          number: 13,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PROFILE_MESSAGE_BUTTON",
          number: 14,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FORWARD",
          number: 15,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "APP_SHORTCUT",
          number: 16,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FF_FAMILY",
          number: 17,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_TAB",
          number: 18,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_HOME",
          number: 19,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_DEEPLINK_IMMERSIVE",
          number: 20,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_DEEPLINK",
          number: 21,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "META_AI_CHAT_SHORTCUT_AI_STUDIO",
          number: 22,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UGC_CHAT_SHORTCUT_AI_STUDIO",
          number: 23,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NEW_CHAT_AI_STUDIO",
          number: 24,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AIVOICE_FAVICON_CALL_HISTORY",
          number: 25,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ASK_META_AI_CONTEXT_MENU",
          number: 26,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ASK_META_AI_CONTEXT_MENU_1ON1",
          number: 27,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ASK_META_AI_CONTEXT_MENU_GROUP",
          number: 28,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INVOKE_META_AI_1ON1",
          number: 29,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INVOKE_META_AI_GROUP",
          number: 30,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "META_AI_FORWARD",
          number: 31,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NEW_CHAT_AI_CONTACT",
          number: 32,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MESSAGE_QUICK_ACTION_1_ON_1_CHAT",
          number: 33,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MESSAGE_QUICK_ACTION_GROUP_CHAT",
          number: 34,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ATTACHMENT_TRAY_1_ON_1_CHAT",
          number: 35,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ATTACHMENT_TRAY_GROUP_CHAT",
          number: 36,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ASK_META_AI_MEDIA_VIEWER_1ON1",
          number: 37,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ASK_META_AI_MEDIA_VIEWER_GROUP",
          number: 38,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MEDIA_PICKER_1_ON_1_CHAT",
          number: 39,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MEDIA_PICKER_GROUP_CHAT",
          number: 40,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ASK_META_AI_NO_SEARCH_RESULTS",
          number: 41,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "META_AI_SETTINGS",
          number: 45,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WEB_INTRO_PANEL",
          number: 46,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WEB_NAVIGATION_BAR",
          number: 47,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_MEMBER",
          number: 54,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CHATLIST_SEARCH",
          number: 55,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NEW_CHAT_LIST",
          number: 56,
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

  field(:UNDEFINED_ENTRY_POINT, 0)
  field(:FAVICON, 1)
  field(:CHATLIST, 2)
  field(:AISEARCH_NULL_STATE_PAPER_PLANE, 3)
  field(:AISEARCH_NULL_STATE_SUGGESTION, 4)
  field(:AISEARCH_TYPE_AHEAD_SUGGESTION, 5)
  field(:AISEARCH_TYPE_AHEAD_PAPER_PLANE, 6)
  field(:AISEARCH_TYPE_AHEAD_RESULT_CHATLIST, 7)
  field(:AISEARCH_TYPE_AHEAD_RESULT_MESSAGES, 8)
  field(:AIVOICE_SEARCH_BAR, 9)
  field(:AIVOICE_FAVICON, 10)
  field(:AISTUDIO, 11)
  field(:DEEPLINK, 12)
  field(:NOTIFICATION, 13)
  field(:PROFILE_MESSAGE_BUTTON, 14)
  field(:FORWARD, 15)
  field(:APP_SHORTCUT, 16)
  field(:FF_FAMILY, 17)
  field(:AI_TAB, 18)
  field(:AI_HOME, 19)
  field(:AI_DEEPLINK_IMMERSIVE, 20)
  field(:AI_DEEPLINK, 21)
  field(:META_AI_CHAT_SHORTCUT_AI_STUDIO, 22)
  field(:UGC_CHAT_SHORTCUT_AI_STUDIO, 23)
  field(:NEW_CHAT_AI_STUDIO, 24)
  field(:AIVOICE_FAVICON_CALL_HISTORY, 25)
  field(:ASK_META_AI_CONTEXT_MENU, 26)
  field(:ASK_META_AI_CONTEXT_MENU_1ON1, 27)
  field(:ASK_META_AI_CONTEXT_MENU_GROUP, 28)
  field(:INVOKE_META_AI_1ON1, 29)
  field(:INVOKE_META_AI_GROUP, 30)
  field(:META_AI_FORWARD, 31)
  field(:NEW_CHAT_AI_CONTACT, 32)
  field(:MESSAGE_QUICK_ACTION_1_ON_1_CHAT, 33)
  field(:MESSAGE_QUICK_ACTION_GROUP_CHAT, 34)
  field(:ATTACHMENT_TRAY_1_ON_1_CHAT, 35)
  field(:ATTACHMENT_TRAY_GROUP_CHAT, 36)
  field(:ASK_META_AI_MEDIA_VIEWER_1ON1, 37)
  field(:ASK_META_AI_MEDIA_VIEWER_GROUP, 38)
  field(:MEDIA_PICKER_1_ON_1_CHAT, 39)
  field(:MEDIA_PICKER_GROUP_CHAT, 40)
  field(:ASK_META_AI_NO_SEARCH_RESULTS, 41)
  field(:META_AI_SETTINGS, 45)
  field(:WEB_INTRO_PANEL, 46)
  field(:WEB_NAVIGATION_BAR, 47)
  field(:GROUP_MEMBER, 54)
  field(:CHATLIST_SEARCH, 55)
  field(:NEW_CHAT_LIST, 56)
end

defmodule WAWebProtobufsAICommon.BotMetricsThreadEntryPoint do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotMetricsThreadEntryPoint",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotMetricsThreadEntryPoint",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_TAB_THREAD",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_HOME_THREAD",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_DEEPLINK_IMMERSIVE_THREAD",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_DEEPLINK_THREAD",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ASK_META_AI_CONTEXT_MENU_THREAD",
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

  field(:AI_TAB_THREAD, 1)
  field(:AI_HOME_THREAD, 2)
  field(:AI_DEEPLINK_IMMERSIVE_THREAD, 3)
  field(:AI_DEEPLINK_THREAD, 4)
  field(:ASK_META_AI_CONTEXT_MENU_THREAD, 5)
end

defmodule WAWebProtobufsAICommon.BotSessionSource do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotSessionSource",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotSessionSource",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NONE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NULL_STATE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TYPEAHEAD",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "USER_INPUT",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "EMU_FLASH",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "EMU_FLASH_FOLLOWUP",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VOICE",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_HOME_SESSION",
          number: 7,
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
  field(:NULL_STATE, 1)
  field(:TYPEAHEAD, 2)
  field(:USER_INPUT, 3)
  field(:EMU_FLASH, 4)
  field(:EMU_FLASH_FOLLOWUP, 5)
  field(:VOICE, 6)
  field(:AI_HOME_SESSION, 7)
end

defmodule WAWebProtobufsAICommon.AISubscriptionRequestType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.AISubscriptionRequestType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "AISubscriptionRequestType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNSPECIFIED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "THINK_HARD",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IMAGE_GEN",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VIDEO_GEN",
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

  field(:UNSPECIFIED, 0)
  field(:THINK_HARD, 1)
  field(:IMAGE_GEN, 2)
  field(:VIDEO_GEN, 3)
end

defmodule WAWebProtobufsAICommon.SessionTransparencyType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.SessionTransparencyType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "SessionTransparencyType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN_TYPE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NY_AI_SAFETY_DISCLAIMER",
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

  field(:UNKNOWN_TYPE, 0)
  field(:NY_AI_SAFETY_DISCLAIMER, 1)
end

defmodule WAWebProtobufsAICommon.BotPluginMetadata.PluginType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotPluginMetadata.PluginType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "PluginType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN_PLUGIN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REELS",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SEARCH",
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

  field(:UNKNOWN_PLUGIN, 0)
  field(:REELS, 1)
  field(:SEARCH, 2)
end

defmodule WAWebProtobufsAICommon.BotPluginMetadata.SearchProvider do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotPluginMetadata.SearchProvider",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "SearchProvider",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BING",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GOOGLE",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SUPPORT",
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

  field(:UNKNOWN, 0)
  field(:BING, 1)
  field(:GOOGLE, 2)
  field(:SUPPORT, 3)
end

defmodule WAWebProtobufsAICommon.BotLinkedAccount.BotLinkedAccountType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotLinkedAccount.BotLinkedAccountType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotLinkedAccountType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_LINKED_ACCOUNT_TYPE_1P",
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

  field(:BOT_LINKED_ACCOUNT_TYPE_1P, 0)
end

defmodule WAWebProtobufsAICommon.BotSignatureVerificationUseCaseProof.BotSignatureUseCase do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotSignatureVerificationUseCaseProof.BotSignatureUseCase",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotSignatureUseCase",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNSPECIFIED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WA_BOT_MSG",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WA_TEE_BOT_MSG",
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

  field(:UNSPECIFIED, 0)
  field(:WA_BOT_MSG, 1)
  field(:WA_TEE_BOT_MSG, 2)
end

defmodule WAWebProtobufsAICommon.BotPromotionMessageMetadata.BotPromotionType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotPromotionMessageMetadata.BotPromotionType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotPromotionType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN_TYPE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "C50",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SURVEY_PLATFORM",
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

  field(:UNKNOWN_TYPE, 0)
  field(:C50, 1)
  field(:SURVEY_PLATFORM, 2)
end

defmodule WAWebProtobufsAICommon.BotMediaMetadata.OrientationType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotMediaMetadata.OrientationType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "OrientationType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CENTER",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LEFT",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RIGHT",
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

  field(:CENTER, 1)
  field(:LEFT, 2)
  field(:RIGHT, 3)
end

defmodule WAWebProtobufsAICommon.BotReminderMetadata.ReminderFrequency do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotReminderMetadata.ReminderFrequency",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ReminderFrequency",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ONCE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DAILY",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WEEKLY",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIWEEKLY",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MONTHLY",
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

  field(:ONCE, 1)
  field(:DAILY, 2)
  field(:WEEKLY, 3)
  field(:BIWEEKLY, 4)
  field(:MONTHLY, 5)
end

defmodule WAWebProtobufsAICommon.BotReminderMetadata.ReminderAction do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotReminderMetadata.ReminderAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ReminderAction",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NOTIFY",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CREATE",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DELETE",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UPDATE",
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

  field(:NOTIFY, 1)
  field(:CREATE, 2)
  field(:DELETE, 3)
  field(:UPDATE, 4)
end

defmodule WAWebProtobufsAICommon.BotModelMetadata.PremiumModelStatus do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotModelMetadata.PremiumModelStatus",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "PremiumModelStatus",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN_STATUS",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AVAILABLE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "QUOTA_EXCEED_LIMIT",
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

  field(:UNKNOWN_STATUS, 0)
  field(:AVAILABLE, 1)
  field(:QUOTA_EXCEED_LIMIT, 2)
end

defmodule WAWebProtobufsAICommon.BotModelMetadata.ModelType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotModelMetadata.ModelType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ModelType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN_TYPE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LLAMA_PROD",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LLAMA_PROD_PREMIUM",
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

  field(:UNKNOWN_TYPE, 0)
  field(:LLAMA_PROD, 1)
  field(:LLAMA_PROD_PREMIUM, 2)
end

defmodule WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotSearchSourceProvider do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name:
      "WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotSearchSourceProvider",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotSearchSourceProvider",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN_PROVIDER",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "OTHER",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GOOGLE",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BING",
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

  field(:UNKNOWN_PROVIDER, 0)
  field(:OTHER, 1)
  field(:GOOGLE, 2)
  field(:BING, 3)
end

defmodule WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.PlanningStepStatus do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name:
      "WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.PlanningStepStatus",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "PlanningStepStatus",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PLANNED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "EXECUTING",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FINISHED",
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

  field(:UNKNOWN, 0)
  field(:PLANNED, 1)
  field(:EXECUTING, 2)
  field(:FINISHED, 3)
end

defmodule WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata.BotPlanningSearchSourceProvider do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name:
      "WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata.BotPlanningSearchSourceProvider",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotPlanningSearchSourceProvider",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "OTHER",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GOOGLE",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BING",
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

  field(:UNKNOWN, 0)
  field(:OTHER, 1)
  field(:GOOGLE, 2)
  field(:BING, 3)
end

defmodule WAWebProtobufsAICommon.BotCapabilityMetadata.BotCapabilityType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotCapabilityMetadata.BotCapabilityType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotCapabilityType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PROGRESS_INDICATOR",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_HEADING",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_NESTED_LIST",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_MEMORY",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_THREAD_SURFING",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_TABLE",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_CODE",
          number: 7,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_STRUCTURED_RESPONSE",
          number: 8,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_INLINE_IMAGE",
          number: 9,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WA_IG_1P_PLUGIN_RANKING_CONTROL",
          number: 10,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_1",
          number: 11,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_2",
          number: 12,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_3",
          number: 13,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_4",
          number: 14,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_5",
          number: 15,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_6",
          number: 16,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_7",
          number: 17,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_8",
          number: 18,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_9",
          number: 19,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_10",
          number: 20,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_SUB_HEADING",
          number: 21,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_GRID_IMAGE",
          number: 22,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_STUDIO_UGC_MEMORY",
          number: 23,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_LATEX",
          number: 24,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_MAPS",
          number: 25,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_INLINE_REELS",
          number: 26,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AGENTIC_PLANNING",
          number: 27,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ACCOUNT_LINKING",
          number: 28,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "STREAMING_DISAGGREGATION",
          number: 29,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_GRID_IMAGE_3P",
          number: 30,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_LATEX_INLINE",
          number: 31,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "QUERY_PLAN",
          number: 32,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PROACTIVE_MESSAGE",
          number: 33,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_UNIFIED_RESPONSE",
          number: 34,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PROMOTION_MESSAGE",
          number: 35,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SIMPLIFIED_PROFILE_PAGE",
          number: 36,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_SOURCES_IN_MESSAGE",
          number: 37,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_SIDE_BY_SIDE_SURVEY",
          number: 38,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_UNIFIED_TEXT_COMPONENT",
          number: 39,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_SHARED_MEMORY",
          number: 40,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_UNIFIED_SOURCES",
          number: 41,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_UNIFIED_DOMAIN_CITATIONS",
          number: 42,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_UR_INLINE_REELS_ENABLED",
          number: 43,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_UR_MEDIA_GRID_ENABLED",
          number: 44,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_UR_TIMESTAMP_PLACEHOLDER",
          number: 45,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_IN_APP_SURVEY",
          number: 46,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RESPONSE_MODEL_BRANDING",
          number: 47,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SESSION_TRANSPARENCY_SYSTEM_MESSAGE",
          number: 48,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_UR_REASONING",
          number: 49,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_UR_ZEITGEIST_CITATIONS",
          number: 50,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_UR_ZEITGEIST_CAROUSEL",
          number: 51,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_IMAGINE_LOADING_INDICATOR",
          number: 52,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_UR_IMAGINE",
          number: 53,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_IMAGINE_UR_TO_NATIVE_LOADING_INDICATOR",
          number: 54,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_UR_BLOKS_ENABLED",
          number: 55,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_INLINE_LINKS_ENABLED",
          number: 56,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RICH_RESPONSE_UR_IMAGINE_VIDEO",
          number: 57,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "JSON_PATCH_STREAMING",
          number: 58,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_TAB_FORCE_CLIPPY",
          number: 59,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNIFIED_RESPONSE_EMBEDDED_SCREENS",
          number: 60,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_SUBSCRIPTION_ENABLED",
          number: 61,
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
  field(:PROGRESS_INDICATOR, 1)
  field(:RICH_RESPONSE_HEADING, 2)
  field(:RICH_RESPONSE_NESTED_LIST, 3)
  field(:AI_MEMORY, 4)
  field(:RICH_RESPONSE_THREAD_SURFING, 5)
  field(:RICH_RESPONSE_TABLE, 6)
  field(:RICH_RESPONSE_CODE, 7)
  field(:RICH_RESPONSE_STRUCTURED_RESPONSE, 8)
  field(:RICH_RESPONSE_INLINE_IMAGE, 9)
  field(:WA_IG_1P_PLUGIN_RANKING_CONTROL, 10)
  field(:WA_IG_1P_PLUGIN_RANKING_UPDATE_1, 11)
  field(:WA_IG_1P_PLUGIN_RANKING_UPDATE_2, 12)
  field(:WA_IG_1P_PLUGIN_RANKING_UPDATE_3, 13)
  field(:WA_IG_1P_PLUGIN_RANKING_UPDATE_4, 14)
  field(:WA_IG_1P_PLUGIN_RANKING_UPDATE_5, 15)
  field(:WA_IG_1P_PLUGIN_RANKING_UPDATE_6, 16)
  field(:WA_IG_1P_PLUGIN_RANKING_UPDATE_7, 17)
  field(:WA_IG_1P_PLUGIN_RANKING_UPDATE_8, 18)
  field(:WA_IG_1P_PLUGIN_RANKING_UPDATE_9, 19)
  field(:WA_IG_1P_PLUGIN_RANKING_UPDATE_10, 20)
  field(:RICH_RESPONSE_SUB_HEADING, 21)
  field(:RICH_RESPONSE_GRID_IMAGE, 22)
  field(:AI_STUDIO_UGC_MEMORY, 23)
  field(:RICH_RESPONSE_LATEX, 24)
  field(:RICH_RESPONSE_MAPS, 25)
  field(:RICH_RESPONSE_INLINE_REELS, 26)
  field(:AGENTIC_PLANNING, 27)
  field(:ACCOUNT_LINKING, 28)
  field(:STREAMING_DISAGGREGATION, 29)
  field(:RICH_RESPONSE_GRID_IMAGE_3P, 30)
  field(:RICH_RESPONSE_LATEX_INLINE, 31)
  field(:QUERY_PLAN, 32)
  field(:PROACTIVE_MESSAGE, 33)
  field(:RICH_RESPONSE_UNIFIED_RESPONSE, 34)
  field(:PROMOTION_MESSAGE, 35)
  field(:SIMPLIFIED_PROFILE_PAGE, 36)
  field(:RICH_RESPONSE_SOURCES_IN_MESSAGE, 37)
  field(:RICH_RESPONSE_SIDE_BY_SIDE_SURVEY, 38)
  field(:RICH_RESPONSE_UNIFIED_TEXT_COMPONENT, 39)
  field(:AI_SHARED_MEMORY, 40)
  field(:RICH_RESPONSE_UNIFIED_SOURCES, 41)
  field(:RICH_RESPONSE_UNIFIED_DOMAIN_CITATIONS, 42)
  field(:RICH_RESPONSE_UR_INLINE_REELS_ENABLED, 43)
  field(:RICH_RESPONSE_UR_MEDIA_GRID_ENABLED, 44)
  field(:RICH_RESPONSE_UR_TIMESTAMP_PLACEHOLDER, 45)
  field(:RICH_RESPONSE_IN_APP_SURVEY, 46)
  field(:AI_RESPONSE_MODEL_BRANDING, 47)
  field(:SESSION_TRANSPARENCY_SYSTEM_MESSAGE, 48)
  field(:RICH_RESPONSE_UR_REASONING, 49)
  field(:RICH_RESPONSE_UR_ZEITGEIST_CITATIONS, 50)
  field(:RICH_RESPONSE_UR_ZEITGEIST_CAROUSEL, 51)
  field(:AI_IMAGINE_LOADING_INDICATOR, 52)
  field(:RICH_RESPONSE_UR_IMAGINE, 53)
  field(:AI_IMAGINE_UR_TO_NATIVE_LOADING_INDICATOR, 54)
  field(:RICH_RESPONSE_UR_BLOKS_ENABLED, 55)
  field(:RICH_RESPONSE_INLINE_LINKS_ENABLED, 56)
  field(:RICH_RESPONSE_UR_IMAGINE_VIDEO, 57)
  field(:JSON_PATCH_STREAMING, 58)
  field(:AI_TAB_FORCE_CLIPPY, 59)
  field(:UNIFIED_RESPONSE_EMBEDDED_SCREENS, 60)
  field(:AI_SUBSCRIPTION_ENABLED, 61)
end

defmodule WAWebProtobufsAICommon.BotModeSelectionMetadata.BotUserSelectionMode do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotModeSelectionMetadata.BotUserSelectionMode",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotUserSelectionMode",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DEFAULT_MODE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "THINK_HARD_MODE",
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

  field(:DEFAULT_MODE, 0)
  field(:THINK_HARD_MODE, 1)
end

defmodule WAWebProtobufsAICommon.BotQuotaMetadata.BotFeatureQuotaMetadata.BotFeatureType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotQuotaMetadata.BotFeatureQuotaMetadata.BotFeatureType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotFeatureType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN_FEATURE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REASONING_FEATURE",
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

  field(:UNKNOWN_FEATURE, 0)
  field(:REASONING_FEATURE, 1)
end

defmodule WAWebProtobufsAICommon.BotImagineMetadata.ImagineType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotImagineMetadata.ImagineType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ImagineType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IMAGINE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MEMU",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FLASH",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "EDIT",
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

  field(:UNKNOWN, 0)
  field(:IMAGINE, 1)
  field(:MEMU, 2)
  field(:FLASH, 3)
  field(:EDIT, 4)
end

defmodule WAWebProtobufsAICommon.BotAgeCollectionMetadata.AgeCollectionType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotAgeCollectionMetadata.AgeCollectionType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "AgeCollectionType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "O18_BINARY",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WAFFLE",
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

  field(:O18_BINARY, 0)
  field(:WAFFLE, 1)
end

defmodule WAWebProtobufsAICommon.BotSourcesMetadata.BotSourceItem.SourceProvider do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotSourcesMetadata.BotSourceItem.SourceProvider",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "SourceProvider",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BING",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GOOGLE",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SUPPORT",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "OTHER",
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

  field(:UNKNOWN, 0)
  field(:BING, 1)
  field(:GOOGLE, 2)
  field(:SUPPORT, 3)
  field(:OTHER, 4)
end

defmodule WAWebProtobufsAICommon.BotMessageOrigin.BotMessageOriginType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotMessageOrigin.BotMessageOriginType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotMessageOriginType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_MESSAGE_ORIGIN_TYPE_AI_INITIATED",
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

  field(:BOT_MESSAGE_ORIGIN_TYPE_AI_INITIATED, 0)
end

defmodule WAWebProtobufsAICommon.AIThreadInfo.AIThreadClientInfo.AIThreadType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.AIThreadInfo.AIThreadClientInfo.AIThreadType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "AIThreadType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DEFAULT",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INCOGNITO",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SIDE_CHAT",
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

  field(:UNKNOWN, 0)
  field(:DEFAULT, 1)
  field(:INCOGNITO, 2)
  field(:SIDE_CHAT, 3)
end

defmodule WAWebProtobufsAICommon.BotFeedbackMessage.ReportKind do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotFeedbackMessage.ReportKind",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ReportKind",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NONE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GENERIC",
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

  field(:NONE, 0)
  field(:GENERIC, 1)
end

defmodule WAWebProtobufsAICommon.BotFeedbackMessage.BotFeedbackKindMultiplePositive do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotFeedbackMessage.BotFeedbackKindMultiplePositive",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotFeedbackKindMultiplePositive",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_MULTIPLE_POSITIVE_GENERIC",
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

  field(:BOT_FEEDBACK_MULTIPLE_POSITIVE_GENERIC, 1)
end

defmodule WAWebProtobufsAICommon.BotFeedbackMessage.BotFeedbackKindMultipleNegative do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotFeedbackMessage.BotFeedbackKindMultipleNegative",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotFeedbackKindMultipleNegative",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_GENERIC",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_HELPFUL",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_INTERESTING",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_ACCURATE",
          number: 8,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_SAFE",
          number: 16,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_OTHER",
          number: 32,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_REFUSED",
          number: 64,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_NOT_VISUALLY_APPEALING",
          number: 128,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_NOT_RELEVANT_TO_TEXT",
          number: 256,
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

  field(:BOT_FEEDBACK_MULTIPLE_NEGATIVE_GENERIC, 1)
  field(:BOT_FEEDBACK_MULTIPLE_NEGATIVE_HELPFUL, 2)
  field(:BOT_FEEDBACK_MULTIPLE_NEGATIVE_INTERESTING, 4)
  field(:BOT_FEEDBACK_MULTIPLE_NEGATIVE_ACCURATE, 8)
  field(:BOT_FEEDBACK_MULTIPLE_NEGATIVE_SAFE, 16)
  field(:BOT_FEEDBACK_MULTIPLE_NEGATIVE_OTHER, 32)
  field(:BOT_FEEDBACK_MULTIPLE_NEGATIVE_REFUSED, 64)
  field(:BOT_FEEDBACK_MULTIPLE_NEGATIVE_NOT_VISUALLY_APPEALING, 128)
  field(:BOT_FEEDBACK_MULTIPLE_NEGATIVE_NOT_RELEVANT_TO_TEXT, 256)
end

defmodule WAWebProtobufsAICommon.BotFeedbackMessage.BotFeedbackKind do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotFeedbackMessage.BotFeedbackKind",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotFeedbackKind",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_POSITIVE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_NEGATIVE_GENERIC",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_NEGATIVE_HELPFUL",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_NEGATIVE_INTERESTING",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_NEGATIVE_ACCURATE",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_NEGATIVE_SAFE",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_NEGATIVE_OTHER",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_NEGATIVE_REFUSED",
          number: 7,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_NEGATIVE_NOT_VISUALLY_APPEALING",
          number: 8,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_NEGATIVE_NOT_RELEVANT_TO_TEXT",
          number: 9,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_NEGATIVE_PERSONALIZED",
          number: 10,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_NEGATIVE_CLARITY",
          number: 11,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_NEGATIVE_DOESNT_LOOK_LIKE_THE_PERSON",
          number: 12,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_NEGATIVE_HALLUCINATION_INTERNAL_ONLY",
          number: 13,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BOT_FEEDBACK_NEGATIVE",
          number: 14,
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

  field(:BOT_FEEDBACK_POSITIVE, 0)
  field(:BOT_FEEDBACK_NEGATIVE_GENERIC, 1)
  field(:BOT_FEEDBACK_NEGATIVE_HELPFUL, 2)
  field(:BOT_FEEDBACK_NEGATIVE_INTERESTING, 3)
  field(:BOT_FEEDBACK_NEGATIVE_ACCURATE, 4)
  field(:BOT_FEEDBACK_NEGATIVE_SAFE, 5)
  field(:BOT_FEEDBACK_NEGATIVE_OTHER, 6)
  field(:BOT_FEEDBACK_NEGATIVE_REFUSED, 7)
  field(:BOT_FEEDBACK_NEGATIVE_NOT_VISUALLY_APPEALING, 8)
  field(:BOT_FEEDBACK_NEGATIVE_NOT_RELEVANT_TO_TEXT, 9)
  field(:BOT_FEEDBACK_NEGATIVE_PERSONALIZED, 10)
  field(:BOT_FEEDBACK_NEGATIVE_CLARITY, 11)
  field(:BOT_FEEDBACK_NEGATIVE_DOESNT_LOOK_LIKE_THE_PERSON, 12)
  field(:BOT_FEEDBACK_NEGATIVE_HALLUCINATION_INTERNAL_ONLY, 13)
  field(:BOT_FEEDBACK_NEGATIVE, 14)
end

defmodule WAWebProtobufsAICommon.BotDocumentMessageMetadata.DocumentPluginType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotDocumentMessageMetadata.DocumentPluginType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "DocumentPluginType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TEXT_EXTRACTION",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "OCR_AND_IMAGES",
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

  field(:TEXT_EXTRACTION, 0)
  field(:OCR_AND_IMAGES, 1)
end

defmodule WAWebProtobufsAICommon.AIHomeState.AIHomeOption.AIHomeActionType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.AIHomeState.AIHomeOption.AIHomeActionType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "AIHomeActionType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PROMPT",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CREATE_IMAGE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ANIMATE_PHOTO",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ANALYZE_FILE",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COLLABORATE",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "OPEN_GREETING_CARD",
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

  field(:PROMPT, 0)
  field(:CREATE_IMAGE, 1)
  field(:ANIMATE_PHOTO, 2)
  field(:ANALYZE_FILE, 3)
  field(:COLLABORATE, 4)
  field(:OPEN_GREETING_CARD, 5)
end

defmodule WAWebProtobufsAICommon.BotInfrastructureDiagnostics.BotBackend do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsAICommon.BotInfrastructureDiagnostics.BotBackend",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotBackend",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AAPI",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CLIPPY",
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

  field(:AAPI, 0)
  field(:CLIPPY, 1)
end

defmodule WAWebProtobufsAICommon.BotPluginMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotPluginMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotPluginMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "provider",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotPluginMetadata.SearchProvider",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "provider",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pluginType",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotPluginMetadata.PluginType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pluginType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "thumbnailCDNURL",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "thumbnailCDNURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "profilePhotoCDNURL",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "profilePhotoCDNURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "searchProviderURL",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "searchProviderURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "referenceIndex",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "referenceIndex",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "expectedLinksCount",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "expectedLinksCount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "searchQuery",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "searchQuery",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "parentPluginMessageKey",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "parentPluginMessageKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deprecatedField",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotPluginMetadata.PluginType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deprecatedField",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "parentPluginType",
          extendee: nil,
          number: 12,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotPluginMetadata.PluginType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "parentPluginType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "faviconCDNURL",
          extendee: nil,
          number: 13,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "faviconCDNURL",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "PluginType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN_PLUGIN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REELS",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SEARCH",
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
          name: "SearchProvider",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BING",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GOOGLE",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SUPPORT",
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

  field(:provider, 1,
    optional: true,
    type: WAWebProtobufsAICommon.BotPluginMetadata.SearchProvider,
    enum: true
  )

  field(:pluginType, 2,
    optional: true,
    type: WAWebProtobufsAICommon.BotPluginMetadata.PluginType,
    enum: true
  )

  field(:thumbnailCDNURL, 3, optional: true, type: :string)
  field(:profilePhotoCDNURL, 4, optional: true, type: :string)
  field(:searchProviderURL, 5, optional: true, type: :string)
  field(:referenceIndex, 6, optional: true, type: :uint32)
  field(:expectedLinksCount, 7, optional: true, type: :uint32)
  field(:searchQuery, 9, optional: true, type: :string)
  field(:parentPluginMessageKey, 10, optional: true, type: WACommon.MessageKey)

  field(:deprecatedField, 11,
    optional: true,
    type: WAWebProtobufsAICommon.BotPluginMetadata.PluginType,
    enum: true
  )

  field(:parentPluginType, 12,
    optional: true,
    type: WAWebProtobufsAICommon.BotPluginMetadata.PluginType,
    enum: true
  )

  field(:faviconCDNURL, 13, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotLinkedAccount do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotLinkedAccount",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotLinkedAccount",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "type",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotLinkedAccount.BotLinkedAccountType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "type",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "BotLinkedAccountType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_LINKED_ACCOUNT_TYPE_1P",
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

  field(:type, 1,
    optional: true,
    type: WAWebProtobufsAICommon.BotLinkedAccount.BotLinkedAccountType,
    enum: true
  )
end

defmodule WAWebProtobufsAICommon.BotSignatureVerificationUseCaseProof do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotSignatureVerificationUseCaseProof",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotSignatureVerificationUseCaseProof",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "version",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "version",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "useCase",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAWebProtobufsAICommon.BotSignatureVerificationUseCaseProof.BotSignatureUseCase",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "useCase",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "signature",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "signature",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "certificateChain",
          extendee: nil,
          number: 4,
          label: :LABEL_REPEATED,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "certificateChain",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "BotSignatureUseCase",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNSPECIFIED",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WA_BOT_MSG",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WA_TEE_BOT_MSG",
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

  field(:version, 1, optional: true, type: :int32)

  field(:useCase, 2,
    optional: true,
    type: WAWebProtobufsAICommon.BotSignatureVerificationUseCaseProof.BotSignatureUseCase,
    enum: true
  )

  field(:signature, 3, optional: true, type: :bytes)
  field(:certificateChain, 4, repeated: true, type: :bytes)
end

defmodule WAWebProtobufsAICommon.BotPromotionMessageMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotPromotionMessageMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotPromotionMessageMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "promotionType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotPromotionMessageMetadata.BotPromotionType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "promotionType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "buttonTitle",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "buttonTitle",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "BotPromotionType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN_TYPE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "C50",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SURVEY_PLATFORM",
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

  field(:promotionType, 1,
    optional: true,
    type: WAWebProtobufsAICommon.BotPromotionMessageMetadata.BotPromotionType,
    enum: true
  )

  field(:buttonTitle, 2, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotMediaMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotMediaMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotMediaMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "fileSHA256",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fileSHA256",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaKey",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fileEncSHA256",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fileEncSHA256",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "directPath",
          extendee: nil,
          number: 4,
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
          name: "mediaKeyTimestamp",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaKeyTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mimetype",
          extendee: nil,
          number: 6,
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
          name: "orientationType",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotMediaMetadata.OrientationType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "orientationType",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "OrientationType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CENTER",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "LEFT",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RIGHT",
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

  field(:fileSHA256, 1, optional: true, type: :string)
  field(:mediaKey, 2, optional: true, type: :string)
  field(:fileEncSHA256, 3, optional: true, type: :string)
  field(:directPath, 4, optional: true, type: :string)
  field(:mediaKeyTimestamp, 5, optional: true, type: :int64)
  field(:mimetype, 6, optional: true, type: :string)

  field(:orientationType, 7,
    optional: true,
    type: WAWebProtobufsAICommon.BotMediaMetadata.OrientationType,
    enum: true
  )
end

defmodule WAWebProtobufsAICommon.BotReminderMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotReminderMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotReminderMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "requestMessageKey",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "requestMessageKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "action",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotReminderMetadata.ReminderAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "action",
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
          name: "nextTriggerTimestamp",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "nextTriggerTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "frequency",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotReminderMetadata.ReminderFrequency",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "frequency",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "ReminderFrequency",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ONCE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DAILY",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WEEKLY",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIWEEKLY",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MONTHLY",
              number: 5,
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
          name: "ReminderAction",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NOTIFY",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CREATE",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DELETE",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UPDATE",
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

  field(:requestMessageKey, 1, optional: true, type: WACommon.MessageKey)

  field(:action, 2,
    optional: true,
    type: WAWebProtobufsAICommon.BotReminderMetadata.ReminderAction,
    enum: true
  )

  field(:name, 3, optional: true, type: :string)
  field(:nextTriggerTimestamp, 4, optional: true, type: :uint64)

  field(:frequency, 5,
    optional: true,
    type: WAWebProtobufsAICommon.BotReminderMetadata.ReminderFrequency,
    enum: true
  )
end

defmodule WAWebProtobufsAICommon.BotModelMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotModelMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotModelMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "modelType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotModelMetadata.ModelType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "modelType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "premiumModelStatus",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotModelMetadata.PremiumModelStatus",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "premiumModelStatus",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "modelNameOverride",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "modelNameOverride",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "PremiumModelStatus",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN_STATUS",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AVAILABLE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "QUOTA_EXCEED_LIMIT",
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
          name: "ModelType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN_TYPE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "LLAMA_PROD",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "LLAMA_PROD_PREMIUM",
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

  field(:modelType, 1,
    optional: true,
    type: WAWebProtobufsAICommon.BotModelMetadata.ModelType,
    enum: true
  )

  field(:premiumModelStatus, 2,
    optional: true,
    type: WAWebProtobufsAICommon.BotModelMetadata.PremiumModelStatus,
    enum: true
  )

  field(:modelNameOverride, 3, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotPlanningSearchSourcesMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "sourceTitle",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sourceTitle",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "provider",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata.BotPlanningSearchSourceProvider",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "provider",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sourceURL",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sourceURL",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "BotPlanningSearchSourceProvider",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "OTHER",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GOOGLE",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BING",
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

  field(:sourceTitle, 1, optional: true, type: :string)

  field(:provider, 2,
    optional: true,
    type:
      WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata.BotPlanningSearchSourceProvider,
    enum: true
  )

  field(:sourceURL, 3, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningStepSectionMetadata do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningStepSectionMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotPlanningStepSectionMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "sectionTitle",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sectionTitle",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sectionBody",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sectionBody",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sourcesMetadata",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourceMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sourcesMetadata",
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

  field(:sectionTitle, 1, optional: true, type: :string)
  field(:sectionBody, 2, optional: true, type: :string)

  field(:sourcesMetadata, 3,
    repeated: true,
    type:
      WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourceMetadata
  )
end

defmodule WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourceMetadata do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourceMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotPlanningSearchSourceMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "title",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "title",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "provider",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotSearchSourceProvider",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "provider",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sourceURL",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sourceURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "favIconURL",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "favIconURL",
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

  field(:title, 1, optional: true, type: :string)

  field(:provider, 2,
    optional: true,
    type:
      WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotSearchSourceProvider,
    enum: true
  )

  field(:sourceURL, 3, optional: true, type: :string)
  field(:favIconURL, 4, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotPlanningStepMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "statusTitle",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "statusTitle",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "statusBody",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "statusBody",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sourcesMetadata",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sourcesMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "status",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.PlanningStepStatus",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "status",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isReasoning",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isReasoning",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isEnhancedSearch",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isEnhancedSearch",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sections",
          extendee: nil,
          number: 7,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningStepSectionMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sections",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "BotPlanningSearchSourcesMetadata",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "sourceTitle",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sourceTitle",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "provider",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata.BotPlanningSearchSourceProvider",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "provider",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "sourceURL",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sourceURL",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "BotPlanningSearchSourceProvider",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UNKNOWN",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "OTHER",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "GOOGLE",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "BING",
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
          name: "BotPlanningStepSectionMetadata",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "sectionTitle",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sectionTitle",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "sectionBody",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sectionBody",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "sourcesMetadata",
              extendee: nil,
              number: 3,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourceMetadata",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sourcesMetadata",
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
          name: "BotPlanningSearchSourceMetadata",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "title",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "title",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "provider",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotSearchSourceProvider",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "provider",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "sourceURL",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sourceURL",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "favIconURL",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "favIconURL",
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
          name: "BotSearchSourceProvider",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN_PROVIDER",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "OTHER",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GOOGLE",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BING",
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
          name: "PlanningStepStatus",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PLANNED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "EXECUTING",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FINISHED",
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

  field(:statusTitle, 1, optional: true, type: :string)
  field(:statusBody, 2, optional: true, type: :string)

  field(:sourcesMetadata, 3,
    repeated: true,
    type:
      WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata
  )

  field(:status, 4,
    optional: true,
    type:
      WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.PlanningStepStatus,
    enum: true
  )

  field(:isReasoning, 5, optional: true, type: :bool)
  field(:isEnhancedSearch, 6, optional: true, type: :bool)

  field(:sections, 7,
    repeated: true,
    type:
      WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningStepSectionMetadata
  )
end

defmodule WAWebProtobufsAICommon.BotProgressIndicatorMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotProgressIndicatorMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotProgressIndicatorMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "progressDescription",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "progressDescription",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "stepsMetadata",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "stepsMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "estimatedCompletionTime",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "estimatedCompletionTime",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "BotPlanningStepMetadata",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "statusTitle",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "statusTitle",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "statusBody",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "statusBody",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "sourcesMetadata",
              extendee: nil,
              number: 3,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sourcesMetadata",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "status",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.PlanningStepStatus",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "status",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "isReasoning",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "isReasoning",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "isEnhancedSearch",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "isEnhancedSearch",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "sections",
              extendee: nil,
              number: 7,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningStepSectionMetadata",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sections",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "BotPlanningSearchSourcesMetadata",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "sourceTitle",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "sourceTitle",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "provider",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_ENUM,
                  type_name:
                    ".WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata.BotPlanningSearchSourceProvider",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "provider",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "sourceURL",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "sourceURL",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [],
              enum_type: [
                %Google.Protobuf.EnumDescriptorProto{
                  name: "BotPlanningSearchSourceProvider",
                  value: [
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "UNKNOWN",
                      number: 0,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "OTHER",
                      number: 1,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "GOOGLE",
                      number: 2,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "BING",
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
              name: "BotPlanningStepSectionMetadata",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "sectionTitle",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "sectionTitle",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "sectionBody",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "sectionBody",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "sourcesMetadata",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_REPEATED,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourceMetadata",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "sourcesMetadata",
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
              name: "BotPlanningSearchSourceMetadata",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "title",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "title",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "provider",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_ENUM,
                  type_name:
                    ".WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotSearchSourceProvider",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "provider",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "sourceURL",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "sourceURL",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "favIconURL",
                  extendee: nil,
                  number: 4,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "favIconURL",
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
              name: "BotSearchSourceProvider",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UNKNOWN_PROVIDER",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "OTHER",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "GOOGLE",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "BING",
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
              name: "PlanningStepStatus",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UNKNOWN",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "PLANNED",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "EXECUTING",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "FINISHED",
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

  field(:progressDescription, 1, optional: true, type: :string)

  field(:stepsMetadata, 2,
    repeated: true,
    type: WAWebProtobufsAICommon.BotProgressIndicatorMetadata.BotPlanningStepMetadata
  )

  field(:estimatedCompletionTime, 3, optional: true, type: :int64)
end

defmodule WAWebProtobufsAICommon.BotCapabilityMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotCapabilityMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotCapabilityMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "capabilities",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotCapabilityMetadata.BotCapabilityType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "capabilities",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "BotCapabilityType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PROGRESS_INDICATOR",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_HEADING",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_NESTED_LIST",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_MEMORY",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_THREAD_SURFING",
              number: 5,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_TABLE",
              number: 6,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_CODE",
              number: 7,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_STRUCTURED_RESPONSE",
              number: 8,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_INLINE_IMAGE",
              number: 9,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WA_IG_1P_PLUGIN_RANKING_CONTROL",
              number: 10,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_1",
              number: 11,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_2",
              number: 12,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_3",
              number: 13,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_4",
              number: 14,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_5",
              number: 15,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_6",
              number: 16,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_7",
              number: 17,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_8",
              number: 18,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_9",
              number: 19,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WA_IG_1P_PLUGIN_RANKING_UPDATE_10",
              number: 20,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_SUB_HEADING",
              number: 21,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_GRID_IMAGE",
              number: 22,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_STUDIO_UGC_MEMORY",
              number: 23,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_LATEX",
              number: 24,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_MAPS",
              number: 25,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_INLINE_REELS",
              number: 26,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AGENTIC_PLANNING",
              number: 27,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ACCOUNT_LINKING",
              number: 28,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "STREAMING_DISAGGREGATION",
              number: 29,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_GRID_IMAGE_3P",
              number: 30,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_LATEX_INLINE",
              number: 31,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "QUERY_PLAN",
              number: 32,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PROACTIVE_MESSAGE",
              number: 33,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_UNIFIED_RESPONSE",
              number: 34,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PROMOTION_MESSAGE",
              number: 35,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SIMPLIFIED_PROFILE_PAGE",
              number: 36,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_SOURCES_IN_MESSAGE",
              number: 37,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_SIDE_BY_SIDE_SURVEY",
              number: 38,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_UNIFIED_TEXT_COMPONENT",
              number: 39,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_SHARED_MEMORY",
              number: 40,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_UNIFIED_SOURCES",
              number: 41,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_UNIFIED_DOMAIN_CITATIONS",
              number: 42,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_UR_INLINE_REELS_ENABLED",
              number: 43,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_UR_MEDIA_GRID_ENABLED",
              number: 44,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_UR_TIMESTAMP_PLACEHOLDER",
              number: 45,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_IN_APP_SURVEY",
              number: 46,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_RESPONSE_MODEL_BRANDING",
              number: 47,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SESSION_TRANSPARENCY_SYSTEM_MESSAGE",
              number: 48,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_UR_REASONING",
              number: 49,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_UR_ZEITGEIST_CITATIONS",
              number: 50,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_UR_ZEITGEIST_CAROUSEL",
              number: 51,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_IMAGINE_LOADING_INDICATOR",
              number: 52,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_UR_IMAGINE",
              number: 53,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_IMAGINE_UR_TO_NATIVE_LOADING_INDICATOR",
              number: 54,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_UR_BLOKS_ENABLED",
              number: 55,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_INLINE_LINKS_ENABLED",
              number: 56,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RICH_RESPONSE_UR_IMAGINE_VIDEO",
              number: 57,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "JSON_PATCH_STREAMING",
              number: 58,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_TAB_FORCE_CLIPPY",
              number: 59,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNIFIED_RESPONSE_EMBEDDED_SCREENS",
              number: 60,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_SUBSCRIPTION_ENABLED",
              number: 61,
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

  field(:capabilities, 1,
    repeated: true,
    type: WAWebProtobufsAICommon.BotCapabilityMetadata.BotCapabilityType,
    enum: true
  )
end

defmodule WAWebProtobufsAICommon.BotModeSelectionMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotModeSelectionMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotModeSelectionMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "mode",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotModeSelectionMetadata.BotUserSelectionMode",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mode",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "overrideMode",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "overrideMode",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "BotUserSelectionMode",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DEFAULT_MODE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "THINK_HARD_MODE",
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

  field(:mode, 1,
    repeated: true,
    type: WAWebProtobufsAICommon.BotModeSelectionMetadata.BotUserSelectionMode,
    enum: true
  )

  field(:overrideMode, 2, repeated: true, type: :uint32)
end

defmodule WAWebProtobufsAICommon.BotQuotaMetadata.BotFeatureQuotaMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotQuotaMetadata.BotFeatureQuotaMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotFeatureQuotaMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "featureType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAWebProtobufsAICommon.BotQuotaMetadata.BotFeatureQuotaMetadata.BotFeatureType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "featureType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "remainingQuota",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "remainingQuota",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "expirationTimestamp",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "expirationTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "BotFeatureType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN_FEATURE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REASONING_FEATURE",
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

  field(:featureType, 1,
    optional: true,
    type: WAWebProtobufsAICommon.BotQuotaMetadata.BotFeatureQuotaMetadata.BotFeatureType,
    enum: true
  )

  field(:remainingQuota, 2, optional: true, type: :uint32)
  field(:expirationTimestamp, 3, optional: true, type: :uint64)
end

defmodule WAWebProtobufsAICommon.BotQuotaMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotQuotaMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotQuotaMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "botFeatureQuotaMetadata",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotQuotaMetadata.BotFeatureQuotaMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botFeatureQuotaMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "BotFeatureQuotaMetadata",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "featureType",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAWebProtobufsAICommon.BotQuotaMetadata.BotFeatureQuotaMetadata.BotFeatureType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "featureType",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "remainingQuota",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "remainingQuota",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "expirationTimestamp",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "expirationTimestamp",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "BotFeatureType",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UNKNOWN_FEATURE",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "REASONING_FEATURE",
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

  field(:botFeatureQuotaMetadata, 1,
    repeated: true,
    type: WAWebProtobufsAICommon.BotQuotaMetadata.BotFeatureQuotaMetadata
  )
end

defmodule WAWebProtobufsAICommon.BotImagineMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotImagineMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotImagineMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "imagineType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotImagineMetadata.ImagineType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imagineType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "shortPrompt",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "shortPrompt",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "ImagineType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IMAGINE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MEMU",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FLASH",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "EDIT",
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

  field(:imagineType, 1,
    optional: true,
    type: WAWebProtobufsAICommon.BotImagineMetadata.ImagineType,
    enum: true
  )

  field(:shortPrompt, 2, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotAgeCollectionMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotAgeCollectionMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotAgeCollectionMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "ageCollectionEligible",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ageCollectionEligible",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "shouldTriggerAgeCollectionOnClient",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "shouldTriggerAgeCollectionOnClient",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ageCollectionType",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotAgeCollectionMetadata.AgeCollectionType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ageCollectionType",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "AgeCollectionType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "O18_BINARY",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WAFFLE",
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

  field(:ageCollectionEligible, 1, optional: true, type: :bool)
  field(:shouldTriggerAgeCollectionOnClient, 2, optional: true, type: :bool)

  field(:ageCollectionType, 3,
    optional: true,
    type: WAWebProtobufsAICommon.BotAgeCollectionMetadata.AgeCollectionType,
    enum: true
  )
end

defmodule WAWebProtobufsAICommon.BotSourcesMetadata.BotSourceItem do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotSourcesMetadata.BotSourceItem",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotSourceItem",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "provider",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotSourcesMetadata.BotSourceItem.SourceProvider",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "provider",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "thumbnailCDNURL",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "thumbnailCDNURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sourceProviderURL",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sourceProviderURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sourceQuery",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sourceQuery",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "faviconCDNURL",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "faviconCDNURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "citationNumber",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "citationNumber",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sourceTitle",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sourceTitle",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "SourceProvider",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BING",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GOOGLE",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SUPPORT",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "OTHER",
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

  field(:provider, 1,
    optional: true,
    type: WAWebProtobufsAICommon.BotSourcesMetadata.BotSourceItem.SourceProvider,
    enum: true
  )

  field(:thumbnailCDNURL, 2, optional: true, type: :string)
  field(:sourceProviderURL, 3, optional: true, type: :string)
  field(:sourceQuery, 4, optional: true, type: :string)
  field(:faviconCDNURL, 5, optional: true, type: :string)
  field(:citationNumber, 6, optional: true, type: :uint32)
  field(:sourceTitle, 7, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotSourcesMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotSourcesMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotSourcesMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "sources",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotSourcesMetadata.BotSourceItem",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sources",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "BotSourceItem",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "provider",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAWebProtobufsAICommon.BotSourcesMetadata.BotSourceItem.SourceProvider",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "provider",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "thumbnailCDNURL",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "thumbnailCDNURL",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "sourceProviderURL",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sourceProviderURL",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "sourceQuery",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sourceQuery",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "faviconCDNURL",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "faviconCDNURL",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "citationNumber",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "citationNumber",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "sourceTitle",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sourceTitle",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "SourceProvider",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UNKNOWN",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "BING",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "GOOGLE",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "SUPPORT",
                  number: 3,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "OTHER",
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

  field(:sources, 1, repeated: true, type: WAWebProtobufsAICommon.BotSourcesMetadata.BotSourceItem)
end

defmodule WAWebProtobufsAICommon.BotMessageOrigin do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotMessageOrigin",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotMessageOrigin",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "type",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotMessageOrigin.BotMessageOriginType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "type",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "BotMessageOriginType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_MESSAGE_ORIGIN_TYPE_AI_INITIATED",
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

  field(:type, 1,
    optional: true,
    type: WAWebProtobufsAICommon.BotMessageOrigin.BotMessageOriginType,
    enum: true
  )
end

defmodule WAWebProtobufsAICommon.AIThreadInfo.AIThreadClientInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.AIThreadInfo.AIThreadClientInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIThreadClientInfo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "type",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.AIThreadInfo.AIThreadClientInfo.AIThreadType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "type",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sourceChatJID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sourceChatJID",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "AIThreadType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DEFAULT",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INCOGNITO",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SIDE_CHAT",
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

  field(:type, 1,
    optional: true,
    type: WAWebProtobufsAICommon.AIThreadInfo.AIThreadClientInfo.AIThreadType,
    enum: true
  )

  field(:sourceChatJID, 2, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.AIThreadInfo.AIThreadServerInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.AIThreadInfo.AIThreadServerInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIThreadServerInfo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "title",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "title",
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

  field(:title, 1, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.AIThreadInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.AIThreadInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIThreadInfo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "serverInfo",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.AIThreadInfo.AIThreadServerInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "serverInfo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "clientInfo",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.AIThreadInfo.AIThreadClientInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "clientInfo",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "AIThreadClientInfo",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "type",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAWebProtobufsAICommon.AIThreadInfo.AIThreadClientInfo.AIThreadType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "type",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "sourceChatJID",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sourceChatJID",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "AIThreadType",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UNKNOWN",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "DEFAULT",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "INCOGNITO",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "SIDE_CHAT",
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
          name: "AIThreadServerInfo",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "title",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "title",
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

  field(:serverInfo, 1,
    optional: true,
    type: WAWebProtobufsAICommon.AIThreadInfo.AIThreadServerInfo
  )

  field(:clientInfo, 2,
    optional: true,
    type: WAWebProtobufsAICommon.AIThreadInfo.AIThreadClientInfo
  )
end

defmodule WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyAbandonEventData do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyAbandonEventData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SideBySideSurveyAbandonEventData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "abandonDwellTimeMSString",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "abandonDwellTimeMSString",
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

  field(:abandonDwellTimeMSString, 1, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyResponseEventData do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyResponseEventData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SideBySideSurveyResponseEventData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "responseDwellTimeMSString",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "responseDwellTimeMSString",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "selectedResponseID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "selectedResponseID",
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

  field(:responseDwellTimeMSString, 1, optional: true, type: :string)
  field(:selectedResponseID, 2, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCardImpressionEventData do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCardImpressionEventData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SideBySideSurveyCardImpressionEventData",
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

defmodule WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCTAClickEventData do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCTAClickEventData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SideBySideSurveyCTAClickEventData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "isSurveyExpired",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isSurveyExpired",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "clickDwellTimeMSString",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "clickDwellTimeMSString",
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

  field(:isSurveyExpired, 1, optional: true, type: :bool)
  field(:clickDwellTimeMSString, 2, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCTAImpressionEventData do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCTAImpressionEventData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SideBySideSurveyCTAImpressionEventData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "isSurveyExpired",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isSurveyExpired",
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

  field(:isSurveyExpired, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SidebySideSurveyMetaAiAnalyticsData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "surveyID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "surveyID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "primaryResponseID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "primaryResponseID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "testArmName",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "testArmName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "timestampMSString",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "timestampMSString",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ctaImpressionEvent",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCTAImpressionEventData",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ctaImpressionEvent",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ctaClickEvent",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCTAClickEventData",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ctaClickEvent",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "cardImpressionEvent",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCardImpressionEventData",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "cardImpressionEvent",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "responseEvent",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyResponseEventData",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "responseEvent",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "abandonEvent",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyAbandonEventData",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "abandonEvent",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "SideBySideSurveyAbandonEventData",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "abandonDwellTimeMSString",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "abandonDwellTimeMSString",
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
          name: "SideBySideSurveyResponseEventData",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "responseDwellTimeMSString",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "responseDwellTimeMSString",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "selectedResponseID",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "selectedResponseID",
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
          name: "SideBySideSurveyCardImpressionEventData",
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
          name: "SideBySideSurveyCTAClickEventData",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "isSurveyExpired",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "isSurveyExpired",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "clickDwellTimeMSString",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "clickDwellTimeMSString",
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
          name: "SideBySideSurveyCTAImpressionEventData",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "isSurveyExpired",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "isSurveyExpired",
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

  field(:surveyID, 1, optional: true, type: :uint32)
  field(:primaryResponseID, 2, optional: true, type: :string)
  field(:testArmName, 3, optional: true, type: :string)
  field(:timestampMSString, 4, optional: true, type: :string)

  field(:ctaImpressionEvent, 5,
    optional: true,
    type:
      WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCTAImpressionEventData
  )

  field(:ctaClickEvent, 6,
    optional: true,
    type:
      WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCTAClickEventData
  )

  field(:cardImpressionEvent, 7,
    optional: true,
    type:
      WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCardImpressionEventData
  )

  field(:responseEvent, 8,
    optional: true,
    type:
      WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyResponseEventData
  )

  field(:abandonEvent, 9,
    optional: true,
    type:
      WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyAbandonEventData
  )
end

defmodule WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SideBySideSurveyAnalyticsData do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SideBySideSurveyAnalyticsData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SideBySideSurveyAnalyticsData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "tessaEvent",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "tessaEvent",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "tessaSessionFbid",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "tessaSessionFbid",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "simonSessionFbid",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "simonSessionFbid",
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

  field(:tessaEvent, 1, optional: true, type: :string)
  field(:tessaSessionFbid, 2, optional: true, type: :string)
  field(:simonSessionFbid, 3, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SideBySideSurveyMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "selectedRequestID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "selectedRequestID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "surveyID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "surveyID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "simonSessionFbid",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "simonSessionFbid",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "responseOtid",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "responseOtid",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "responseTimestampMSString",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "responseTimestampMSString",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isSelectedResponsePrimary",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isSelectedResponsePrimary",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageIDToEdit",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageIDToEdit",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "analyticsData",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SideBySideSurveyAnalyticsData",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "analyticsData",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "metaAiAnalyticsData",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "metaAiAnalyticsData",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "SidebySideSurveyMetaAiAnalyticsData",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "surveyID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "surveyID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "primaryResponseID",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "primaryResponseID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "testArmName",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "testArmName",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "timestampMSString",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "timestampMSString",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "ctaImpressionEvent",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCTAImpressionEventData",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "ctaImpressionEvent",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "ctaClickEvent",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCTAClickEventData",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "ctaClickEvent",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "cardImpressionEvent",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCardImpressionEventData",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "cardImpressionEvent",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "responseEvent",
              extendee: nil,
              number: 8,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyResponseEventData",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "responseEvent",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "abandonEvent",
              extendee: nil,
              number: 9,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyAbandonEventData",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "abandonEvent",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "SideBySideSurveyAbandonEventData",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "abandonDwellTimeMSString",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "abandonDwellTimeMSString",
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
              name: "SideBySideSurveyResponseEventData",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "responseDwellTimeMSString",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "responseDwellTimeMSString",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "selectedResponseID",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "selectedResponseID",
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
              name: "SideBySideSurveyCardImpressionEventData",
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
              name: "SideBySideSurveyCTAClickEventData",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "isSurveyExpired",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BOOL,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "isSurveyExpired",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "clickDwellTimeMSString",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "clickDwellTimeMSString",
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
              name: "SideBySideSurveyCTAImpressionEventData",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "isSurveyExpired",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BOOL,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "isSurveyExpired",
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
          name: "SideBySideSurveyAnalyticsData",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "tessaEvent",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "tessaEvent",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "tessaSessionFbid",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "tessaSessionFbid",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "simonSessionFbid",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "simonSessionFbid",
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

  field(:selectedRequestID, 1, optional: true, type: :string)
  field(:surveyID, 2, optional: true, type: :uint32)
  field(:simonSessionFbid, 3, optional: true, type: :string)
  field(:responseOtid, 4, optional: true, type: :string)
  field(:responseTimestampMSString, 5, optional: true, type: :string)
  field(:isSelectedResponsePrimary, 6, optional: true, type: :bool)
  field(:messageIDToEdit, 7, optional: true, type: :string)

  field(:analyticsData, 8,
    optional: true,
    type:
      WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SideBySideSurveyAnalyticsData
  )

  field(:metaAiAnalyticsData, 9,
    optional: true,
    type:
      WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData
  )
end

defmodule WAWebProtobufsAICommon.BotFeedbackMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotFeedbackMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotFeedbackMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageKey",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "kind",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotFeedbackMessage.BotFeedbackKind",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "kind",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "text",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "text",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "kindNegative",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "kindNegative",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "kindPositive",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "kindPositive",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "kindReport",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotFeedbackMessage.ReportKind",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "kindReport",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sideBySideSurveyMetadata",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sideBySideSurveyMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "SideBySideSurveyMetadata",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "selectedRequestID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "selectedRequestID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "surveyID",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "surveyID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "simonSessionFbid",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "simonSessionFbid",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "responseOtid",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "responseOtid",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "responseTimestampMSString",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "responseTimestampMSString",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "isSelectedResponsePrimary",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "isSelectedResponsePrimary",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "messageIDToEdit",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "messageIDToEdit",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "analyticsData",
              extendee: nil,
              number: 8,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SideBySideSurveyAnalyticsData",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "analyticsData",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "metaAiAnalyticsData",
              extendee: nil,
              number: 9,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "metaAiAnalyticsData",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "SidebySideSurveyMetaAiAnalyticsData",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "surveyID",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_UINT32,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "surveyID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "primaryResponseID",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "primaryResponseID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "testArmName",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "testArmName",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "timestampMSString",
                  extendee: nil,
                  number: 4,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "timestampMSString",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "ctaImpressionEvent",
                  extendee: nil,
                  number: 5,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCTAImpressionEventData",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "ctaImpressionEvent",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "ctaClickEvent",
                  extendee: nil,
                  number: 6,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCTAClickEventData",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "ctaClickEvent",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "cardImpressionEvent",
                  extendee: nil,
                  number: 7,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyCardImpressionEventData",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "cardImpressionEvent",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "responseEvent",
                  extendee: nil,
                  number: 8,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyResponseEventData",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "responseEvent",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "abandonEvent",
                  extendee: nil,
                  number: 9,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata.SidebySideSurveyMetaAiAnalyticsData.SideBySideSurveyAbandonEventData",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "abandonEvent",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [
                %Google.Protobuf.DescriptorProto{
                  name: "SideBySideSurveyAbandonEventData",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "abandonDwellTimeMSString",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_STRING,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "abandonDwellTimeMSString",
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
                  name: "SideBySideSurveyResponseEventData",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "responseDwellTimeMSString",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_STRING,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "responseDwellTimeMSString",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "selectedResponseID",
                      extendee: nil,
                      number: 2,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_STRING,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "selectedResponseID",
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
                  name: "SideBySideSurveyCardImpressionEventData",
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
                  name: "SideBySideSurveyCTAClickEventData",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "isSurveyExpired",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_BOOL,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "isSurveyExpired",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "clickDwellTimeMSString",
                      extendee: nil,
                      number: 2,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_STRING,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "clickDwellTimeMSString",
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
                  name: "SideBySideSurveyCTAImpressionEventData",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "isSurveyExpired",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_BOOL,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "isSurveyExpired",
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
              name: "SideBySideSurveyAnalyticsData",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "tessaEvent",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "tessaEvent",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "tessaSessionFbid",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "tessaSessionFbid",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "simonSessionFbid",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "simonSessionFbid",
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
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "ReportKind",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NONE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GENERIC",
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
          name: "BotFeedbackKindMultiplePositive",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_MULTIPLE_POSITIVE_GENERIC",
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
          name: "BotFeedbackKindMultipleNegative",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_GENERIC",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_HELPFUL",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_INTERESTING",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_ACCURATE",
              number: 8,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_SAFE",
              number: 16,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_OTHER",
              number: 32,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_REFUSED",
              number: 64,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_NOT_VISUALLY_APPEALING",
              number: 128,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_MULTIPLE_NEGATIVE_NOT_RELEVANT_TO_TEXT",
              number: 256,
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
          name: "BotFeedbackKind",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_POSITIVE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_NEGATIVE_GENERIC",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_NEGATIVE_HELPFUL",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_NEGATIVE_INTERESTING",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_NEGATIVE_ACCURATE",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_NEGATIVE_SAFE",
              number: 5,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_NEGATIVE_OTHER",
              number: 6,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_NEGATIVE_REFUSED",
              number: 7,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_NEGATIVE_NOT_VISUALLY_APPEALING",
              number: 8,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_NEGATIVE_NOT_RELEVANT_TO_TEXT",
              number: 9,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_NEGATIVE_PERSONALIZED",
              number: 10,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_NEGATIVE_CLARITY",
              number: 11,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_NEGATIVE_DOESNT_LOOK_LIKE_THE_PERSON",
              number: 12,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_NEGATIVE_HALLUCINATION_INTERNAL_ONLY",
              number: 13,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BOT_FEEDBACK_NEGATIVE",
              number: 14,
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

  field(:messageKey, 1, optional: true, type: WACommon.MessageKey)

  field(:kind, 2,
    optional: true,
    type: WAWebProtobufsAICommon.BotFeedbackMessage.BotFeedbackKind,
    enum: true
  )

  field(:text, 3, optional: true, type: :string)
  field(:kindNegative, 4, optional: true, type: :uint64)
  field(:kindPositive, 5, optional: true, type: :uint64)

  field(:kindReport, 6,
    optional: true,
    type: WAWebProtobufsAICommon.BotFeedbackMessage.ReportKind,
    enum: true
  )

  field(:sideBySideSurveyMetadata, 7,
    optional: true,
    type: WAWebProtobufsAICommon.BotFeedbackMessage.SideBySideSurveyMetadata
  )
end

defmodule WAWebProtobufsAICommon.BotDocumentMessageMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotDocumentMessageMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotDocumentMessageMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "pluginType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotDocumentMessageMetadata.DocumentPluginType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pluginType",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "DocumentPluginType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TEXT_EXTRACTION",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "OCR_AND_IMAGES",
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

  field(:pluginType, 1,
    optional: true,
    type: WAWebProtobufsAICommon.BotDocumentMessageMetadata.DocumentPluginType,
    enum: true
  )
end

defmodule WAWebProtobufsAICommon.AIHomeState.AIHomeOption do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.AIHomeState.AIHomeOption",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIHomeOption",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "type",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.AIHomeState.AIHomeOption.AIHomeActionType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "type",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "title",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "title",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "promptText",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "promptText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sessionID",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sessionID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "imageWdsIdentifier",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imageWdsIdentifier",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "imageTintColor",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imageTintColor",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "imageBackgroundColor",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imageBackgroundColor",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "cardTypeID",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "cardTypeID",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "AIHomeActionType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PROMPT",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CREATE_IMAGE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ANIMATE_PHOTO",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ANALYZE_FILE",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COLLABORATE",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "OPEN_GREETING_CARD",
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

  field(:type, 1,
    optional: true,
    type: WAWebProtobufsAICommon.AIHomeState.AIHomeOption.AIHomeActionType,
    enum: true
  )

  field(:title, 2, optional: true, type: :string)
  field(:promptText, 3, optional: true, type: :string)
  field(:sessionID, 4, optional: true, type: :string)
  field(:imageWdsIdentifier, 5, optional: true, type: :string)
  field(:imageTintColor, 6, optional: true, type: :string)
  field(:imageBackgroundColor, 7, optional: true, type: :string)
  field(:cardTypeID, 8, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.AIHomeState do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.AIHomeState",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIHomeState",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "lastFetchTime",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lastFetchTime",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "capabilityOptions",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.AIHomeState.AIHomeOption",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "capabilityOptions",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "conversationOptions",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.AIHomeState.AIHomeOption",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "conversationOptions",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "AIHomeOption",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "type",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAWebProtobufsAICommon.AIHomeState.AIHomeOption.AIHomeActionType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "type",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "title",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "title",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "promptText",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "promptText",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "sessionID",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sessionID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "imageWdsIdentifier",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "imageWdsIdentifier",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "imageTintColor",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "imageTintColor",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "imageBackgroundColor",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "imageBackgroundColor",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "cardTypeID",
              extendee: nil,
              number: 8,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "cardTypeID",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "AIHomeActionType",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "PROMPT",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "CREATE_IMAGE",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "ANIMATE_PHOTO",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "ANALYZE_FILE",
                  number: 3,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "COLLABORATE",
                  number: 4,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "OPEN_GREETING_CARD",
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

  field(:lastFetchTime, 1, optional: true, type: :int64)

  field(:capabilityOptions, 2,
    repeated: true,
    type: WAWebProtobufsAICommon.AIHomeState.AIHomeOption
  )

  field(:conversationOptions, 3,
    repeated: true,
    type: WAWebProtobufsAICommon.AIHomeState.AIHomeOption
  )
end

defmodule WAWebProtobufsAICommon.BotInfrastructureDiagnostics do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotInfrastructureDiagnostics",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotInfrastructureDiagnostics",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "botBackend",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotInfrastructureDiagnostics.BotBackend",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botBackend",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "toolsUsed",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "toolsUsed",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isThinking",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isThinking",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "BotBackend",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AAPI",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CLIPPY",
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

  field(:botBackend, 1,
    optional: true,
    type: WAWebProtobufsAICommon.BotInfrastructureDiagnostics.BotBackend,
    enum: true
  )

  field(:toolsUsed, 2, repeated: true, type: :string)
  field(:isThinking, 3, optional: true, type: :bool)
end

defmodule WAWebProtobufsAICommon.BotSuggestedPromptMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotSuggestedPromptMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotSuggestedPromptMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "suggestedPrompts",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "suggestedPrompts",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "selectedPromptIndex",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "selectedPromptIndex",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "promptSuggestions",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotPromptSuggestions",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "promptSuggestions",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "selectedPromptID",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "selectedPromptID",
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

  field(:suggestedPrompts, 1, repeated: true, type: :string)
  field(:selectedPromptIndex, 2, optional: true, type: :uint32)
  field(:promptSuggestions, 3, optional: true, type: WAWebProtobufsAICommon.BotPromptSuggestions)
  field(:selectedPromptID, 4, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotPromptSuggestions do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotPromptSuggestions",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotPromptSuggestions",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "suggestions",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotPromptSuggestion",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "suggestions",
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

  field(:suggestions, 1, repeated: true, type: WAWebProtobufsAICommon.BotPromptSuggestion)
end

defmodule WAWebProtobufsAICommon.BotPromptSuggestion do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotPromptSuggestion",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotPromptSuggestion",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "prompt",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "prompt",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "promptID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "promptID",
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

  field(:prompt, 1, optional: true, type: :string)
  field(:promptID, 2, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotLinkedAccountsMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotLinkedAccountsMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotLinkedAccountsMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "accounts",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotLinkedAccount",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "accounts",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "acAuthTokens",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "acAuthTokens",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "acErrorCode",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "acErrorCode",
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

  field(:accounts, 1, repeated: true, type: WAWebProtobufsAICommon.BotLinkedAccount)
  field(:acAuthTokens, 2, optional: true, type: :bytes)
  field(:acErrorCode, 3, optional: true, type: :int32)
end

defmodule WAWebProtobufsAICommon.BotMemoryMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotMemoryMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotMemoryMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "addedFacts",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotMemoryFact",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "addedFacts",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "removedFacts",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotMemoryFact",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "removedFacts",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "disclaimer",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "disclaimer",
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

  field(:addedFacts, 1, repeated: true, type: WAWebProtobufsAICommon.BotMemoryFact)
  field(:removedFacts, 2, repeated: true, type: WAWebProtobufsAICommon.BotMemoryFact)
  field(:disclaimer, 3, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotMemoryFact do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotMemoryFact",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotMemoryFact",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "fact",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fact",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "factID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "factID",
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

  field(:fact, 1, optional: true, type: :string)
  field(:factID, 2, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotSignatureVerificationMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotSignatureVerificationMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotSignatureVerificationMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "proofs",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotSignatureVerificationUseCaseProof",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "proofs",
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

  field(:proofs, 1,
    repeated: true,
    type: WAWebProtobufsAICommon.BotSignatureVerificationUseCaseProof
  )
end

defmodule WAWebProtobufsAICommon.BotRenderingMetadata.Keyword do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotRenderingMetadata.Keyword",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Keyword",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "value",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "value",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "associatedPrompts",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "associatedPrompts",
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

  field(:value, 1, optional: true, type: :string)
  field(:associatedPrompts, 2, repeated: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotRenderingMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotRenderingMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotRenderingMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "keywords",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotRenderingMetadata.Keyword",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "keywords",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Keyword",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "value",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "value",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "associatedPrompts",
              extendee: nil,
              number: 2,
              label: :LABEL_REPEATED,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "associatedPrompts",
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

  field(:keywords, 1, repeated: true, type: WAWebProtobufsAICommon.BotRenderingMetadata.Keyword)
end

defmodule WAWebProtobufsAICommon.BotMetricsMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotMetricsMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotMetricsMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "destinationID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "destinationID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "destinationEntryPoint",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotMetricsEntryPoint",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "destinationEntryPoint",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "threadOrigin",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotMetricsThreadEntryPoint",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "threadOrigin",
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

  field(:destinationID, 1, optional: true, type: :string)

  field(:destinationEntryPoint, 2,
    optional: true,
    type: WAWebProtobufsAICommon.BotMetricsEntryPoint,
    enum: true
  )

  field(:threadOrigin, 3,
    optional: true,
    type: WAWebProtobufsAICommon.BotMetricsThreadEntryPoint,
    enum: true
  )
end

defmodule WAWebProtobufsAICommon.BotSessionMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotSessionMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotSessionMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "sessionID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sessionID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sessionSource",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotSessionSource",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sessionSource",
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

  field(:sessionID, 1, optional: true, type: :string)

  field(:sessionSource, 2,
    optional: true,
    type: WAWebProtobufsAICommon.BotSessionSource,
    enum: true
  )
end

defmodule WAWebProtobufsAICommon.BotMemuMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotMemuMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotMemuMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "faceImages",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotMediaMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "faceImages",
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

  field(:faceImages, 1, repeated: true, type: WAWebProtobufsAICommon.BotMediaMetadata)
end

defmodule WAWebProtobufsAICommon.InThreadSurveyMetadata.InThreadSurveyPrivacyStatementPart do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.InThreadSurveyMetadata.InThreadSurveyPrivacyStatementPart",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "InThreadSurveyPrivacyStatementPart",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "text",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "text",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "URL",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "URL",
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

  field(:text, 1, optional: true, type: :string)
  field(:URL, 2, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.InThreadSurveyMetadata.InThreadSurveyOption do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.InThreadSurveyMetadata.InThreadSurveyOption",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "InThreadSurveyOption",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "stringValue",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "stringValue",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "numericValue",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "numericValue",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "textTranslated",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "textTranslated",
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

  field(:stringValue, 1, optional: true, type: :string)
  field(:numericValue, 2, optional: true, type: :uint32)
  field(:textTranslated, 3, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.InThreadSurveyMetadata.InThreadSurveyQuestion do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.InThreadSurveyMetadata.InThreadSurveyQuestion",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "InThreadSurveyQuestion",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "questionText",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "questionText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "questionID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "questionID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "questionOptions",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.InThreadSurveyMetadata.InThreadSurveyOption",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "questionOptions",
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

  field(:questionText, 1, optional: true, type: :string)
  field(:questionID, 2, optional: true, type: :string)

  field(:questionOptions, 3,
    repeated: true,
    type: WAWebProtobufsAICommon.InThreadSurveyMetadata.InThreadSurveyOption
  )
end

defmodule WAWebProtobufsAICommon.InThreadSurveyMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.InThreadSurveyMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "InThreadSurveyMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "tessaSessionID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "tessaSessionID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "simonSessionID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "simonSessionID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "simonSurveyID",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "simonSurveyID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "tessaRootID",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "tessaRootID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "requestID",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "requestID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "tessaEvent",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "tessaEvent",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "invitationHeaderText",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "invitationHeaderText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "invitationBodyText",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "invitationBodyText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "invitationCtaText",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "invitationCtaText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "invitationCtaURL",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "invitationCtaURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "surveyTitle",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "surveyTitle",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "questions",
          extendee: nil,
          number: 12,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.InThreadSurveyMetadata.InThreadSurveyQuestion",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "questions",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "surveyContinueButtonText",
          extendee: nil,
          number: 13,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "surveyContinueButtonText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "surveySubmitButtonText",
          extendee: nil,
          number: 14,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "surveySubmitButtonText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "privacyStatementFull",
          extendee: nil,
          number: 15,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "privacyStatementFull",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "privacyStatementParts",
          extendee: nil,
          number: 16,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAWebProtobufsAICommon.InThreadSurveyMetadata.InThreadSurveyPrivacyStatementPart",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "privacyStatementParts",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "feedbackToastText",
          extendee: nil,
          number: 17,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "feedbackToastText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "startQuestionIndex",
          extendee: nil,
          number: 18,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "startQuestionIndex",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "InThreadSurveyPrivacyStatementPart",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "text",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "text",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "URL",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "URL",
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
          name: "InThreadSurveyOption",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "stringValue",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "stringValue",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "numericValue",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "numericValue",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "textTranslated",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "textTranslated",
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
          name: "InThreadSurveyQuestion",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "questionText",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "questionText",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "questionID",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "questionID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "questionOptions",
              extendee: nil,
              number: 3,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name: ".WAWebProtobufsAICommon.InThreadSurveyMetadata.InThreadSurveyOption",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "questionOptions",
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

  field(:tessaSessionID, 1, optional: true, type: :string)
  field(:simonSessionID, 2, optional: true, type: :string)
  field(:simonSurveyID, 3, optional: true, type: :string)
  field(:tessaRootID, 4, optional: true, type: :string)
  field(:requestID, 5, optional: true, type: :string)
  field(:tessaEvent, 6, optional: true, type: :string)
  field(:invitationHeaderText, 7, optional: true, type: :string)
  field(:invitationBodyText, 8, optional: true, type: :string)
  field(:invitationCtaText, 9, optional: true, type: :string)
  field(:invitationCtaURL, 10, optional: true, type: :string)
  field(:surveyTitle, 11, optional: true, type: :string)

  field(:questions, 12,
    repeated: true,
    type: WAWebProtobufsAICommon.InThreadSurveyMetadata.InThreadSurveyQuestion
  )

  field(:surveyContinueButtonText, 13, optional: true, type: :string)
  field(:surveySubmitButtonText, 14, optional: true, type: :string)
  field(:privacyStatementFull, 15, optional: true, type: :string)

  field(:privacyStatementParts, 16,
    repeated: true,
    type: WAWebProtobufsAICommon.InThreadSurveyMetadata.InThreadSurveyPrivacyStatementPart
  )

  field(:feedbackToastText, 17, optional: true, type: :string)
  field(:startQuestionIndex, 18, optional: true, type: :int32)
end

defmodule WAWebProtobufsAICommon.BotMessageOriginMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotMessageOriginMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotMessageOriginMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "origins",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotMessageOrigin",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "origins",
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

  field(:origins, 1, repeated: true, type: WAWebProtobufsAICommon.BotMessageOrigin)
end

defmodule WAWebProtobufsAICommon.BotUnifiedResponseMutation.MediaDetailsMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotUnifiedResponseMutation.MediaDetailsMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MediaDetailsMetadata",
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
          name: "highResMedia",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotMediaMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "highResMedia",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "previewMedia",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotMediaMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "previewMedia",
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
  field(:highResMedia, 2, optional: true, type: WAWebProtobufsAICommon.BotMediaMetadata)
  field(:previewMedia, 3, optional: true, type: WAWebProtobufsAICommon.BotMediaMetadata)
end

defmodule WAWebProtobufsAICommon.BotUnifiedResponseMutation.SideBySideMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotUnifiedResponseMutation.SideBySideMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SideBySideMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "primaryResponseID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "primaryResponseID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "surveyCtaHasRendered",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "surveyCtaHasRendered",
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

  field(:primaryResponseID, 1, optional: true, type: :string)
  field(:surveyCtaHasRendered, 2, optional: true, type: :bool)
end

defmodule WAWebProtobufsAICommon.BotUnifiedResponseMutation do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotUnifiedResponseMutation",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotUnifiedResponseMutation",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "sbsMetadata",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotUnifiedResponseMutation.SideBySideMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sbsMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaDetailsMetadataList",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotUnifiedResponseMutation.MediaDetailsMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaDetailsMetadataList",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "MediaDetailsMetadata",
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
              name: "highResMedia",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAWebProtobufsAICommon.BotMediaMetadata",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "highResMedia",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "previewMedia",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAWebProtobufsAICommon.BotMediaMetadata",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "previewMedia",
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
          name: "SideBySideMetadata",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "primaryResponseID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "primaryResponseID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "surveyCtaHasRendered",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "surveyCtaHasRendered",
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

  field(:sbsMetadata, 1,
    optional: true,
    type: WAWebProtobufsAICommon.BotUnifiedResponseMutation.SideBySideMetadata
  )

  field(:mediaDetailsMetadataList, 2,
    repeated: true,
    type: WAWebProtobufsAICommon.BotUnifiedResponseMutation.MediaDetailsMetadata
  )
end

defmodule WAWebProtobufsAICommon.AIMediaCollectionMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.AIMediaCollectionMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIMediaCollectionMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "collectionID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "collectionID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "uploadOrderIndex",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "uploadOrderIndex",
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

  field(:collectionID, 1, optional: true, type: :string)
  field(:uploadOrderIndex, 2, optional: true, type: :uint32)
end

defmodule WAWebProtobufsAICommon.AIMediaCollectionMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.AIMediaCollectionMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIMediaCollectionMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "collectionID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "collectionID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "expectedMediaCount",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "expectedMediaCount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "hasGlobalCaption",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "hasGlobalCaption",
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

  field(:collectionID, 1, optional: true, type: :string)
  field(:expectedMediaCount, 2, optional: true, type: :uint32)
  field(:hasGlobalCaption, 3, optional: true, type: :bool)
end

defmodule WAWebProtobufsAICommon.BotCommandMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotCommandMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotCommandMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "commandName",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "commandName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "commandDescription",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "commandDescription",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "commandPrompt",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "commandPrompt",
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

  field(:commandName, 1, optional: true, type: :string)
  field(:commandDescription, 2, optional: true, type: :string)
  field(:commandPrompt, 3, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotResolvedToolCallMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotResolvedToolCallMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotResolvedToolCallMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "toolCallID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "toolCallID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "resolutionDataSerialized",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "resolutionDataSerialized",
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

  field(:toolCallID, 1, optional: true, type: :string)
  field(:resolutionDataSerialized, 2, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "personaID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "personaID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pluginMetadata",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotPluginMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pluginMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "suggestedPromptMetadata",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotSuggestedPromptMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "suggestedPromptMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "invokerJID",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "invokerJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sessionMetadata",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotSessionMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sessionMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "memuMetadata",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotMemuMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "memuMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "timezone",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "timezone",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "reminderMetadata",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotReminderMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "reminderMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "modelMetadata",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotModelMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "modelMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageDisclaimerText",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageDisclaimerText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "progressIndicatorMetadata",
          extendee: nil,
          number: 12,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotProgressIndicatorMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "progressIndicatorMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "capabilityMetadata",
          extendee: nil,
          number: 13,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotCapabilityMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "capabilityMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "imagineMetadata",
          extendee: nil,
          number: 14,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotImagineMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imagineMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "memoryMetadata",
          extendee: nil,
          number: 15,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotMemoryMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "memoryMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "renderingMetadata",
          extendee: nil,
          number: 16,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotRenderingMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "renderingMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botMetricsMetadata",
          extendee: nil,
          number: 17,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotMetricsMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botMetricsMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botLinkedAccountsMetadata",
          extendee: nil,
          number: 18,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotLinkedAccountsMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botLinkedAccountsMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "richResponseSourcesMetadata",
          extendee: nil,
          number: 19,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotSourcesMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "richResponseSourcesMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "aiConversationContext",
          extendee: nil,
          number: 20,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "aiConversationContext",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botPromotionMessageMetadata",
          extendee: nil,
          number: 21,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotPromotionMessageMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botPromotionMessageMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botModeSelectionMetadata",
          extendee: nil,
          number: 22,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotModeSelectionMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botModeSelectionMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botQuotaMetadata",
          extendee: nil,
          number: 23,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotQuotaMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botQuotaMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botAgeCollectionMetadata",
          extendee: nil,
          number: 24,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotAgeCollectionMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botAgeCollectionMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "conversationStarterPromptID",
          extendee: nil,
          number: 25,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "conversationStarterPromptID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botResponseID",
          extendee: nil,
          number: 26,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botResponseID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "verificationMetadata",
          extendee: nil,
          number: 27,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotSignatureVerificationMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "verificationMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "unifiedResponseMutation",
          extendee: nil,
          number: 28,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotUnifiedResponseMutation",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "unifiedResponseMutation",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botMessageOriginMetadata",
          extendee: nil,
          number: 29,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotMessageOriginMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botMessageOriginMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "inThreadSurveyMetadata",
          extendee: nil,
          number: 30,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.InThreadSurveyMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "inThreadSurveyMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botThreadInfo",
          extendee: nil,
          number: 31,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.AIThreadInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botThreadInfo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "regenerateMetadata",
          extendee: nil,
          number: 32,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.AIRegenerateMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "regenerateMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sessionTransparencyMetadata",
          extendee: nil,
          number: 33,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.SessionTransparencyMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sessionTransparencyMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botDocumentMessageMetadata",
          extendee: nil,
          number: 34,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotDocumentMessageMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botDocumentMessageMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botGroupMetadata",
          extendee: nil,
          number: 35,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotGroupMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botGroupMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botRenderingConfigMetadata",
          extendee: nil,
          number: 36,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotRenderingConfigMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botRenderingConfigMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botInfrastructureDiagnostics",
          extendee: nil,
          number: 37,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotInfrastructureDiagnostics",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botInfrastructureDiagnostics",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "aiMediaCollectionMetadata",
          extendee: nil,
          number: 38,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.AIMediaCollectionMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "aiMediaCollectionMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "commandMetadata",
          extendee: nil,
          number: 39,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotCommandMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "commandMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "resolvedToolCallMetadata",
          extendee: nil,
          number: 40,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotResolvedToolCallMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "resolvedToolCallMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "subscriptionUpsellMetadata",
          extendee: nil,
          number: 41,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.AISubscriptionUpsellMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "subscriptionUpsellMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "internalMetadata",
          extendee: nil,
          number: 999,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "internalMetadata",
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

  field(:personaID, 2, optional: true, type: :string)
  field(:pluginMetadata, 3, optional: true, type: WAWebProtobufsAICommon.BotPluginMetadata)

  field(:suggestedPromptMetadata, 4,
    optional: true,
    type: WAWebProtobufsAICommon.BotSuggestedPromptMetadata
  )

  field(:invokerJID, 5, optional: true, type: :string)
  field(:sessionMetadata, 6, optional: true, type: WAWebProtobufsAICommon.BotSessionMetadata)
  field(:memuMetadata, 7, optional: true, type: WAWebProtobufsAICommon.BotMemuMetadata)
  field(:timezone, 8, optional: true, type: :string)
  field(:reminderMetadata, 9, optional: true, type: WAWebProtobufsAICommon.BotReminderMetadata)
  field(:modelMetadata, 10, optional: true, type: WAWebProtobufsAICommon.BotModelMetadata)
  field(:messageDisclaimerText, 11, optional: true, type: :string)

  field(:progressIndicatorMetadata, 12,
    optional: true,
    type: WAWebProtobufsAICommon.BotProgressIndicatorMetadata
  )

  field(:capabilityMetadata, 13,
    optional: true,
    type: WAWebProtobufsAICommon.BotCapabilityMetadata
  )

  field(:imagineMetadata, 14, optional: true, type: WAWebProtobufsAICommon.BotImagineMetadata)
  field(:memoryMetadata, 15, optional: true, type: WAWebProtobufsAICommon.BotMemoryMetadata)
  field(:renderingMetadata, 16, optional: true, type: WAWebProtobufsAICommon.BotRenderingMetadata)
  field(:botMetricsMetadata, 17, optional: true, type: WAWebProtobufsAICommon.BotMetricsMetadata)

  field(:botLinkedAccountsMetadata, 18,
    optional: true,
    type: WAWebProtobufsAICommon.BotLinkedAccountsMetadata
  )

  field(:richResponseSourcesMetadata, 19,
    optional: true,
    type: WAWebProtobufsAICommon.BotSourcesMetadata
  )

  field(:aiConversationContext, 20, optional: true, type: :bytes)

  field(:botPromotionMessageMetadata, 21,
    optional: true,
    type: WAWebProtobufsAICommon.BotPromotionMessageMetadata
  )

  field(:botModeSelectionMetadata, 22,
    optional: true,
    type: WAWebProtobufsAICommon.BotModeSelectionMetadata
  )

  field(:botQuotaMetadata, 23, optional: true, type: WAWebProtobufsAICommon.BotQuotaMetadata)

  field(:botAgeCollectionMetadata, 24,
    optional: true,
    type: WAWebProtobufsAICommon.BotAgeCollectionMetadata
  )

  field(:conversationStarterPromptID, 25, optional: true, type: :string)
  field(:botResponseID, 26, optional: true, type: :string)

  field(:verificationMetadata, 27,
    optional: true,
    type: WAWebProtobufsAICommon.BotSignatureVerificationMetadata
  )

  field(:unifiedResponseMutation, 28,
    optional: true,
    type: WAWebProtobufsAICommon.BotUnifiedResponseMutation
  )

  field(:botMessageOriginMetadata, 29,
    optional: true,
    type: WAWebProtobufsAICommon.BotMessageOriginMetadata
  )

  field(:inThreadSurveyMetadata, 30,
    optional: true,
    type: WAWebProtobufsAICommon.InThreadSurveyMetadata
  )

  field(:botThreadInfo, 31, optional: true, type: WAWebProtobufsAICommon.AIThreadInfo)
  field(:regenerateMetadata, 32, optional: true, type: WAWebProtobufsAICommon.AIRegenerateMetadata)

  field(:sessionTransparencyMetadata, 33,
    optional: true,
    type: WAWebProtobufsAICommon.SessionTransparencyMetadata
  )

  field(:botDocumentMessageMetadata, 34,
    optional: true,
    type: WAWebProtobufsAICommon.BotDocumentMessageMetadata
  )

  field(:botGroupMetadata, 35, optional: true, type: WAWebProtobufsAICommon.BotGroupMetadata)

  field(:botRenderingConfigMetadata, 36,
    optional: true,
    type: WAWebProtobufsAICommon.BotRenderingConfigMetadata
  )

  field(:botInfrastructureDiagnostics, 37,
    optional: true,
    type: WAWebProtobufsAICommon.BotInfrastructureDiagnostics
  )

  field(:aiMediaCollectionMetadata, 38,
    optional: true,
    type: WAWebProtobufsAICommon.AIMediaCollectionMetadata
  )

  field(:commandMetadata, 39, optional: true, type: WAWebProtobufsAICommon.BotCommandMetadata)

  field(:resolvedToolCallMetadata, 40,
    optional: true,
    type: WAWebProtobufsAICommon.BotResolvedToolCallMetadata
  )

  field(:subscriptionUpsellMetadata, 41,
    optional: true,
    type: WAWebProtobufsAICommon.AISubscriptionUpsellMetadata
  )

  field(:internalMetadata, 999, optional: true, type: :bytes)
end

defmodule WAWebProtobufsAICommon.AISubscriptionUpsellMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.AISubscriptionUpsellMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AISubscriptionUpsellMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "requestType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.AISubscriptionRequestType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "requestType",
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

  field(:requestType, 1,
    optional: true,
    type: WAWebProtobufsAICommon.AISubscriptionRequestType,
    enum: true
  )
end

defmodule WAWebProtobufsAICommon.BotGroupMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotGroupMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotGroupMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "participantsMetadata",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotGroupParticipantMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "participantsMetadata",
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

  field(:participantsMetadata, 1,
    repeated: true,
    type: WAWebProtobufsAICommon.BotGroupParticipantMetadata
  )
end

defmodule WAWebProtobufsAICommon.BotRenderingConfigMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotRenderingConfigMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotRenderingConfigMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "bloksVersioningID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "bloksVersioningID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pixelDensity",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pixelDensity",
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

  field(:bloksVersioningID, 1, optional: true, type: :string)
  field(:pixelDensity, 2, optional: true, type: :double)
end

defmodule WAWebProtobufsAICommon.BotGroupParticipantMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotGroupParticipantMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotGroupParticipantMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "botFbid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botFbid",
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

  field(:botFbid, 1, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.ForwardedAIBotMessageInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.ForwardedAIBotMessageInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ForwardedAIBotMessageInfo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "botName",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botJID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "creatorName",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "creatorName",
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

  field(:botName, 1, optional: true, type: :string)
  field(:botJID, 2, optional: true, type: :string)
  field(:creatorName, 3, optional: true, type: :string)
end

defmodule WAWebProtobufsAICommon.BotMessageSharingInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotMessageSharingInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotMessageSharingInfo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "botEntryPointOrigin",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.BotMetricsEntryPoint",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botEntryPointOrigin",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "forwardScore",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "forwardScore",
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

  field(:botEntryPointOrigin, 1,
    optional: true,
    type: WAWebProtobufsAICommon.BotMetricsEntryPoint,
    enum: true
  )

  field(:forwardScore, 2, optional: true, type: :uint32)
end

defmodule WAWebProtobufsAICommon.AIRichResponseUnifiedResponse do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.AIRichResponseUnifiedResponse",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRichResponseUnifiedResponse",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "data",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "data",
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

  field(:data, 1, optional: true, type: :bytes)
end

defmodule WAWebProtobufsAICommon.AIRegenerateMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.AIRegenerateMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRegenerateMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageKey",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "responseTimestampMS",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "responseTimestampMS",
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

  field(:messageKey, 1, optional: true, type: WACommon.MessageKey)
  field(:responseTimestampMS, 2, optional: true, type: :int64)
end

defmodule WAWebProtobufsAICommon.SessionTransparencyMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.SessionTransparencyMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SessionTransparencyMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "disclaimerText",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "disclaimerText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "hcaID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "hcaID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sessionTransparencyType",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsAICommon.SessionTransparencyType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sessionTransparencyType",
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

  field(:disclaimerText, 1, optional: true, type: :string)
  field(:hcaID, 2, optional: true, type: :string)

  field(:sessionTransparencyType, 3,
    optional: true,
    type: WAWebProtobufsAICommon.SessionTransparencyType,
    enum: true
  )
end

defmodule WAWebProtobufsAICommon.BotAgentMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotAgentMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotAgentMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "deepLinkMetadata",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsAICommon.BotAgentDeepLinkMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deepLinkMetadata",
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

  field(:deepLinkMetadata, 1,
    optional: true,
    type: WAWebProtobufsAICommon.BotAgentDeepLinkMetadata
  )
end

defmodule WAWebProtobufsAICommon.BotAgentDeepLinkMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsAICommon.BotAgentDeepLinkMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotAgentDeepLinkMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "token",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "token",
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

  field(:token, 1, optional: true, type: :string)
end
