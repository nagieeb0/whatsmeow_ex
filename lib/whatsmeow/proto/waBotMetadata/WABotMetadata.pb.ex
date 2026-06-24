defmodule WABotMetadata.BotMetricsEntryPoint do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotMetricsEntryPoint",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotMetricsEntryPoint",
      value: [
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
        }
      ],
      options: nil,
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

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
end

defmodule WABotMetadata.BotMetricsThreadEntryPoint do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotMetricsThreadEntryPoint",
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

defmodule WABotMetadata.BotSessionSource do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotSessionSource",
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
end

defmodule WABotMetadata.BotPluginMetadata.PluginType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotPluginMetadata.PluginType",
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

defmodule WABotMetadata.BotPluginMetadata.SearchProvider do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotPluginMetadata.SearchProvider",
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

defmodule WABotMetadata.BotLinkedAccount.BotLinkedAccountType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotLinkedAccount.BotLinkedAccountType",
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

defmodule WABotMetadata.BotSignatureVerificationUseCaseProof.BotSignatureUseCase do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotSignatureVerificationUseCaseProof.BotSignatureUseCase",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotSignatureUseCase",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WA_BOT_MSG",
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

  field(:WA_BOT_MSG, 0)
end

defmodule WABotMetadata.BotPromotionMessageMetadata.BotPromotionType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotPromotionMessageMetadata.BotPromotionType",
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

defmodule WABotMetadata.BotMediaMetadata.OrientationType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotMediaMetadata.OrientationType",
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

defmodule WABotMetadata.BotReminderMetadata.ReminderFrequency do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotReminderMetadata.ReminderFrequency",
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

defmodule WABotMetadata.BotReminderMetadata.ReminderAction do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotReminderMetadata.ReminderAction",
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

defmodule WABotMetadata.BotModelMetadata.PremiumModelStatus do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotModelMetadata.PremiumModelStatus",
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

defmodule WABotMetadata.BotModelMetadata.ModelType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotModelMetadata.ModelType",
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

defmodule WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotSearchSourceProvider do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name:
      "WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotSearchSourceProvider",
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

defmodule WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.PlanningStepStatus do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name:
      "WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.PlanningStepStatus",
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

defmodule WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata.BotPlanningSearchSourceProvider do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name:
      "WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata.BotPlanningSearchSourceProvider",
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

defmodule WABotMetadata.BotCapabilityMetadata.BotCapabilityType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotCapabilityMetadata.BotCapabilityType",
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
end

defmodule WABotMetadata.BotModeSelectionMetadata.BotUserSelectionMode do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotModeSelectionMetadata.BotUserSelectionMode",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BotUserSelectionMode",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN_MODE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REASONING_MODE",
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

  field(:UNKNOWN_MODE, 0)
  field(:REASONING_MODE, 1)
end

defmodule WABotMetadata.BotQuotaMetadata.BotFeatureQuotaMetadata.BotFeatureType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotQuotaMetadata.BotFeatureQuotaMetadata.BotFeatureType",
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

defmodule WABotMetadata.BotImagineMetadata.ImagineType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotImagineMetadata.ImagineType",
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

defmodule WABotMetadata.BotSourcesMetadata.BotSourceItem.SourceProvider do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotSourcesMetadata.BotSourceItem.SourceProvider",
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

defmodule WABotMetadata.BotMessageOrigin.BotMessageOriginType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.BotMessageOrigin.BotMessageOriginType",
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

defmodule WABotMetadata.AIThreadInfo.AIThreadClientInfo.AIThreadType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WABotMetadata.AIThreadInfo.AIThreadClientInfo.AIThreadType",
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
end

defmodule WABotMetadata.BotPluginMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotPluginMetadata",
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
          type_name: ".WABotMetadata.BotPluginMetadata.SearchProvider",
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
          type_name: ".WABotMetadata.BotPluginMetadata.PluginType",
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
          type_name: ".WABotMetadata.BotPluginMetadata.PluginType",
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
          type_name: ".WABotMetadata.BotPluginMetadata.PluginType",
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
    type: WABotMetadata.BotPluginMetadata.SearchProvider,
    enum: true
  )

  field(:pluginType, 2,
    optional: true,
    type: WABotMetadata.BotPluginMetadata.PluginType,
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
    type: WABotMetadata.BotPluginMetadata.PluginType,
    enum: true
  )

  field(:parentPluginType, 12,
    optional: true,
    type: WABotMetadata.BotPluginMetadata.PluginType,
    enum: true
  )

  field(:faviconCDNURL, 13, optional: true, type: :string)
end

defmodule WABotMetadata.BotLinkedAccount do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotLinkedAccount",
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
          type_name: ".WABotMetadata.BotLinkedAccount.BotLinkedAccountType",
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
    type: WABotMetadata.BotLinkedAccount.BotLinkedAccountType,
    enum: true
  )
end

defmodule WABotMetadata.BotSignatureVerificationUseCaseProof do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotSignatureVerificationUseCaseProof",
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
          type_name: ".WABotMetadata.BotSignatureVerificationUseCaseProof.BotSignatureUseCase",
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
          label: :LABEL_OPTIONAL,
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
              name: "WA_BOT_MSG",
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

  field(:version, 1, optional: true, type: :int32)

  field(:useCase, 2,
    optional: true,
    type: WABotMetadata.BotSignatureVerificationUseCaseProof.BotSignatureUseCase,
    enum: true
  )

  field(:signature, 3, optional: true, type: :bytes)
  field(:certificateChain, 4, optional: true, type: :bytes)
end

defmodule WABotMetadata.BotPromotionMessageMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotPromotionMessageMetadata",
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
          type_name: ".WABotMetadata.BotPromotionMessageMetadata.BotPromotionType",
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
    type: WABotMetadata.BotPromotionMessageMetadata.BotPromotionType,
    enum: true
  )

  field(:buttonTitle, 2, optional: true, type: :string)
end

defmodule WABotMetadata.BotMediaMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotMediaMetadata",
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
          type_name: ".WABotMetadata.BotMediaMetadata.OrientationType",
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
    type: WABotMetadata.BotMediaMetadata.OrientationType,
    enum: true
  )
end

defmodule WABotMetadata.BotReminderMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotReminderMetadata",
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
          type_name: ".WABotMetadata.BotReminderMetadata.ReminderAction",
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
          type_name: ".WABotMetadata.BotReminderMetadata.ReminderFrequency",
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
    type: WABotMetadata.BotReminderMetadata.ReminderAction,
    enum: true
  )

  field(:name, 3, optional: true, type: :string)
  field(:nextTriggerTimestamp, 4, optional: true, type: :uint64)

  field(:frequency, 5,
    optional: true,
    type: WABotMetadata.BotReminderMetadata.ReminderFrequency,
    enum: true
  )
end

defmodule WABotMetadata.BotModelMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotModelMetadata",
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
          type_name: ".WABotMetadata.BotModelMetadata.ModelType",
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
          type_name: ".WABotMetadata.BotModelMetadata.PremiumModelStatus",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "premiumModelStatus",
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

  field(:modelType, 1, optional: true, type: WABotMetadata.BotModelMetadata.ModelType, enum: true)

  field(:premiumModelStatus, 2,
    optional: true,
    type: WABotMetadata.BotModelMetadata.PremiumModelStatus,
    enum: true
  )
end

defmodule WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata do
  @moduledoc false

  use Protobuf,
    full_name:
      "WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata",
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
            ".WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata.BotPlanningSearchSourceProvider",
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
      WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata.BotPlanningSearchSourceProvider,
    enum: true
  )

  field(:sourceURL, 3, optional: true, type: :string)
end

defmodule WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningStepSectionMetadata do
  @moduledoc false

  use Protobuf,
    full_name:
      "WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningStepSectionMetadata",
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
            ".WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourceMetadata",
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
      WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourceMetadata
  )
end

defmodule WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourceMetadata do
  @moduledoc false

  use Protobuf,
    full_name:
      "WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourceMetadata",
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
            ".WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotSearchSourceProvider",
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
      WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotSearchSourceProvider,
    enum: true
  )

  field(:sourceURL, 3, optional: true, type: :string)
  field(:favIconURL, 4, optional: true, type: :string)
end

defmodule WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata",
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
            ".WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata",
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
            ".WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.PlanningStepStatus",
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
            ".WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningStepSectionMetadata",
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
                ".WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata.BotPlanningSearchSourceProvider",
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
                ".WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourceMetadata",
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
                ".WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotSearchSourceProvider",
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
      WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata
  )

  field(:status, 4,
    optional: true,
    type: WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.PlanningStepStatus,
    enum: true
  )

  field(:isReasoning, 5, optional: true, type: :bool)
  field(:isEnhancedSearch, 6, optional: true, type: :bool)

  field(:sections, 7,
    repeated: true,
    type:
      WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningStepSectionMetadata
  )
end

defmodule WABotMetadata.BotProgressIndicatorMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotProgressIndicatorMetadata",
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
          type_name: ".WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "stepsMetadata",
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
                ".WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata",
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
                ".WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.PlanningStepStatus",
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
                ".WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningStepSectionMetadata",
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
                    ".WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourcesMetadata.BotPlanningSearchSourceProvider",
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
                    ".WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotPlanningSearchSourceMetadata",
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
                    ".WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata.BotSearchSourceProvider",
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
    type: WABotMetadata.BotProgressIndicatorMetadata.BotPlanningStepMetadata
  )
end

defmodule WABotMetadata.BotCapabilityMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotCapabilityMetadata",
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
          type_name: ".WABotMetadata.BotCapabilityMetadata.BotCapabilityType",
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
    type: WABotMetadata.BotCapabilityMetadata.BotCapabilityType,
    enum: true
  )
end

defmodule WABotMetadata.BotModeSelectionMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotModeSelectionMetadata",
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
          type_name: ".WABotMetadata.BotModeSelectionMetadata.BotUserSelectionMode",
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
          name: "BotUserSelectionMode",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN_MODE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REASONING_MODE",
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
    type: WABotMetadata.BotModeSelectionMetadata.BotUserSelectionMode,
    enum: true
  )
end

defmodule WABotMetadata.BotQuotaMetadata.BotFeatureQuotaMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotQuotaMetadata.BotFeatureQuotaMetadata",
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
          type_name: ".WABotMetadata.BotQuotaMetadata.BotFeatureQuotaMetadata.BotFeatureType",
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
    type: WABotMetadata.BotQuotaMetadata.BotFeatureQuotaMetadata.BotFeatureType,
    enum: true
  )

  field(:remainingQuota, 2, optional: true, type: :uint32)
  field(:expirationTimestamp, 3, optional: true, type: :uint64)
end

defmodule WABotMetadata.BotQuotaMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotQuotaMetadata",
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
          type_name: ".WABotMetadata.BotQuotaMetadata.BotFeatureQuotaMetadata",
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
              type_name: ".WABotMetadata.BotQuotaMetadata.BotFeatureQuotaMetadata.BotFeatureType",
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
    type: WABotMetadata.BotQuotaMetadata.BotFeatureQuotaMetadata
  )
end

defmodule WABotMetadata.BotImagineMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotImagineMetadata",
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
          type_name: ".WABotMetadata.BotImagineMetadata.ImagineType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imagineType",
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
    type: WABotMetadata.BotImagineMetadata.ImagineType,
    enum: true
  )
end

defmodule WABotMetadata.BotSourcesMetadata.BotSourceItem do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotSourcesMetadata.BotSourceItem",
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
          type_name: ".WABotMetadata.BotSourcesMetadata.BotSourceItem.SourceProvider",
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
    type: WABotMetadata.BotSourcesMetadata.BotSourceItem.SourceProvider,
    enum: true
  )

  field(:thumbnailCDNURL, 2, optional: true, type: :string)
  field(:sourceProviderURL, 3, optional: true, type: :string)
  field(:sourceQuery, 4, optional: true, type: :string)
  field(:faviconCDNURL, 5, optional: true, type: :string)
  field(:citationNumber, 6, optional: true, type: :uint32)
  field(:sourceTitle, 7, optional: true, type: :string)
end

defmodule WABotMetadata.BotSourcesMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotSourcesMetadata",
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
          type_name: ".WABotMetadata.BotSourcesMetadata.BotSourceItem",
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
              type_name: ".WABotMetadata.BotSourcesMetadata.BotSourceItem.SourceProvider",
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

  field(:sources, 1, repeated: true, type: WABotMetadata.BotSourcesMetadata.BotSourceItem)
end

defmodule WABotMetadata.BotMessageOrigin do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotMessageOrigin",
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
          type_name: ".WABotMetadata.BotMessageOrigin.BotMessageOriginType",
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
    type: WABotMetadata.BotMessageOrigin.BotMessageOriginType,
    enum: true
  )
end

defmodule WABotMetadata.AIThreadInfo.AIThreadClientInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.AIThreadInfo.AIThreadClientInfo",
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
          type_name: ".WABotMetadata.AIThreadInfo.AIThreadClientInfo.AIThreadType",
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
    type: WABotMetadata.AIThreadInfo.AIThreadClientInfo.AIThreadType,
    enum: true
  )
end

defmodule WABotMetadata.AIThreadInfo.AIThreadServerInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.AIThreadInfo.AIThreadServerInfo",
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

defmodule WABotMetadata.AIThreadInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.AIThreadInfo",
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
          type_name: ".WABotMetadata.AIThreadInfo.AIThreadServerInfo",
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
          type_name: ".WABotMetadata.AIThreadInfo.AIThreadClientInfo",
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
              type_name: ".WABotMetadata.AIThreadInfo.AIThreadClientInfo.AIThreadType",
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

  field(:serverInfo, 1, optional: true, type: WABotMetadata.AIThreadInfo.AIThreadServerInfo)
  field(:clientInfo, 2, optional: true, type: WABotMetadata.AIThreadInfo.AIThreadClientInfo)
end

defmodule WABotMetadata.BotAvatarMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotAvatarMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotAvatarMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "sentiment",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sentiment",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "behaviorGraph",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "behaviorGraph",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "action",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "action",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "intensity",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "intensity",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "wordCount",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "wordCount",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:sentiment, 1, optional: true, type: :uint32)
  field(:behaviorGraph, 2, optional: true, type: :string)
  field(:action, 3, optional: true, type: :uint32)
  field(:intensity, 4, optional: true, type: :uint32)
  field(:wordCount, 5, optional: true, type: :uint32)
end

defmodule WABotMetadata.BotSuggestedPromptMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotSuggestedPromptMetadata",
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
          type_name: ".WABotMetadata.BotPromptSuggestions",
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
  field(:promptSuggestions, 3, optional: true, type: WABotMetadata.BotPromptSuggestions)
  field(:selectedPromptID, 4, optional: true, type: :string)
end

defmodule WABotMetadata.BotPromptSuggestions do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotPromptSuggestions",
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
          type_name: ".WABotMetadata.BotPromptSuggestion",
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

  field(:suggestions, 1, repeated: true, type: WABotMetadata.BotPromptSuggestion)
end

defmodule WABotMetadata.BotPromptSuggestion do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotPromptSuggestion",
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

defmodule WABotMetadata.BotLinkedAccountsMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotLinkedAccountsMetadata",
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
          type_name: ".WABotMetadata.BotLinkedAccount",
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

  field(:accounts, 1, repeated: true, type: WABotMetadata.BotLinkedAccount)
  field(:acAuthTokens, 2, optional: true, type: :bytes)
  field(:acErrorCode, 3, optional: true, type: :int32)
end

defmodule WABotMetadata.BotMemoryMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotMemoryMetadata",
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
          type_name: ".WABotMetadata.BotMemoryFact",
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
          type_name: ".WABotMetadata.BotMemoryFact",
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

  field(:addedFacts, 1, repeated: true, type: WABotMetadata.BotMemoryFact)
  field(:removedFacts, 2, repeated: true, type: WABotMetadata.BotMemoryFact)
  field(:disclaimer, 3, optional: true, type: :string)
end

defmodule WABotMetadata.BotMemoryFact do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotMemoryFact",
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

defmodule WABotMetadata.BotSignatureVerificationMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotSignatureVerificationMetadata",
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
          type_name: ".WABotMetadata.BotSignatureVerificationUseCaseProof",
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

  field(:proofs, 1, repeated: true, type: WABotMetadata.BotSignatureVerificationUseCaseProof)
end

defmodule WABotMetadata.BotRenderingMetadata.Keyword do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotRenderingMetadata.Keyword",
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

defmodule WABotMetadata.BotRenderingMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotRenderingMetadata",
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
          type_name: ".WABotMetadata.BotRenderingMetadata.Keyword",
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

  field(:keywords, 1, repeated: true, type: WABotMetadata.BotRenderingMetadata.Keyword)
end

defmodule WABotMetadata.BotMetricsMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotMetricsMetadata",
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
          type_name: ".WABotMetadata.BotMetricsEntryPoint",
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
          type_name: ".WABotMetadata.BotMetricsThreadEntryPoint",
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
    type: WABotMetadata.BotMetricsEntryPoint,
    enum: true
  )

  field(:threadOrigin, 3,
    optional: true,
    type: WABotMetadata.BotMetricsThreadEntryPoint,
    enum: true
  )
end

defmodule WABotMetadata.BotSessionMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotSessionMetadata",
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
          type_name: ".WABotMetadata.BotSessionSource",
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
  field(:sessionSource, 2, optional: true, type: WABotMetadata.BotSessionSource, enum: true)
end

defmodule WABotMetadata.BotMemuMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotMemuMetadata",
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
          type_name: ".WABotMetadata.BotMediaMetadata",
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

  field(:faceImages, 1, repeated: true, type: WABotMetadata.BotMediaMetadata)
end

defmodule WABotMetadata.BotAgeCollectionMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotAgeCollectionMetadata",
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
        }
      ],
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

  field(:ageCollectionEligible, 1, optional: true, type: :bool)
  field(:shouldTriggerAgeCollectionOnClient, 2, optional: true, type: :bool)
end

defmodule WABotMetadata.InThreadSurveyMetadata.InThreadSurveyPrivacyStatementPart do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.InThreadSurveyMetadata.InThreadSurveyPrivacyStatementPart",
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

defmodule WABotMetadata.InThreadSurveyMetadata.InThreadSurveyOption do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.InThreadSurveyMetadata.InThreadSurveyOption",
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

defmodule WABotMetadata.InThreadSurveyMetadata.InThreadSurveyQuestion do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.InThreadSurveyMetadata.InThreadSurveyQuestion",
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
          type_name: ".WABotMetadata.InThreadSurveyMetadata.InThreadSurveyOption",
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
    type: WABotMetadata.InThreadSurveyMetadata.InThreadSurveyOption
  )
end

defmodule WABotMetadata.InThreadSurveyMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.InThreadSurveyMetadata",
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
          type_name: ".WABotMetadata.InThreadSurveyMetadata.InThreadSurveyQuestion",
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
          type_name: ".WABotMetadata.InThreadSurveyMetadata.InThreadSurveyPrivacyStatementPart",
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
              type_name: ".WABotMetadata.InThreadSurveyMetadata.InThreadSurveyOption",
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
    type: WABotMetadata.InThreadSurveyMetadata.InThreadSurveyQuestion
  )

  field(:surveyContinueButtonText, 13, optional: true, type: :string)
  field(:surveySubmitButtonText, 14, optional: true, type: :string)
  field(:privacyStatementFull, 15, optional: true, type: :string)

  field(:privacyStatementParts, 16,
    repeated: true,
    type: WABotMetadata.InThreadSurveyMetadata.InThreadSurveyPrivacyStatementPart
  )

  field(:feedbackToastText, 17, optional: true, type: :string)
end

defmodule WABotMetadata.BotMessageOriginMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotMessageOriginMetadata",
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
          type_name: ".WABotMetadata.BotMessageOrigin",
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

  field(:origins, 1, repeated: true, type: WABotMetadata.BotMessageOrigin)
end

defmodule WABotMetadata.BotUnifiedResponseMutation.MediaDetailsMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotUnifiedResponseMutation.MediaDetailsMetadata",
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
          type_name: ".WABotMetadata.BotMediaMetadata",
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
          type_name: ".WABotMetadata.BotMediaMetadata",
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
  field(:highResMedia, 2, optional: true, type: WABotMetadata.BotMediaMetadata)
  field(:previewMedia, 3, optional: true, type: WABotMetadata.BotMediaMetadata)
end

defmodule WABotMetadata.BotUnifiedResponseMutation.SideBySideMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotUnifiedResponseMutation.SideBySideMetadata",
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
        }
      ],
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
end

defmodule WABotMetadata.BotUnifiedResponseMutation do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotUnifiedResponseMutation",
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
          type_name: ".WABotMetadata.BotUnifiedResponseMutation.SideBySideMetadata",
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
          type_name: ".WABotMetadata.BotUnifiedResponseMutation.MediaDetailsMetadata",
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
              type_name: ".WABotMetadata.BotMediaMetadata",
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
              type_name: ".WABotMetadata.BotMediaMetadata",
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
            }
          ],
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
    type: WABotMetadata.BotUnifiedResponseMutation.SideBySideMetadata
  )

  field(:mediaDetailsMetadataList, 2,
    repeated: true,
    type: WABotMetadata.BotUnifiedResponseMutation.MediaDetailsMetadata
  )
end

defmodule WABotMetadata.BotMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WABotMetadata.BotMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BotMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "avatarMetadata",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WABotMetadata.BotAvatarMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "avatarMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
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
          type_name: ".WABotMetadata.BotPluginMetadata",
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
          type_name: ".WABotMetadata.BotSuggestedPromptMetadata",
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
          type_name: ".WABotMetadata.BotSessionMetadata",
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
          type_name: ".WABotMetadata.BotMemuMetadata",
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
          type_name: ".WABotMetadata.BotReminderMetadata",
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
          type_name: ".WABotMetadata.BotModelMetadata",
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
          type_name: ".WABotMetadata.BotProgressIndicatorMetadata",
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
          type_name: ".WABotMetadata.BotCapabilityMetadata",
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
          type_name: ".WABotMetadata.BotImagineMetadata",
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
          type_name: ".WABotMetadata.BotMemoryMetadata",
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
          type_name: ".WABotMetadata.BotRenderingMetadata",
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
          type_name: ".WABotMetadata.BotMetricsMetadata",
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
          type_name: ".WABotMetadata.BotLinkedAccountsMetadata",
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
          type_name: ".WABotMetadata.BotSourcesMetadata",
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
          type_name: ".WABotMetadata.BotPromotionMessageMetadata",
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
          type_name: ".WABotMetadata.BotModeSelectionMetadata",
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
          type_name: ".WABotMetadata.BotQuotaMetadata",
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
          type_name: ".WABotMetadata.BotAgeCollectionMetadata",
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
          type_name: ".WABotMetadata.BotSignatureVerificationMetadata",
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
          type_name: ".WABotMetadata.BotUnifiedResponseMutation",
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
          type_name: ".WABotMetadata.BotMessageOriginMetadata",
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
          type_name: ".WABotMetadata.InThreadSurveyMetadata",
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
          type_name: ".WABotMetadata.AIThreadInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botThreadInfo",
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

  field(:avatarMetadata, 1, optional: true, type: WABotMetadata.BotAvatarMetadata)
  field(:personaID, 2, optional: true, type: :string)
  field(:pluginMetadata, 3, optional: true, type: WABotMetadata.BotPluginMetadata)

  field(:suggestedPromptMetadata, 4,
    optional: true,
    type: WABotMetadata.BotSuggestedPromptMetadata
  )

  field(:invokerJID, 5, optional: true, type: :string)
  field(:sessionMetadata, 6, optional: true, type: WABotMetadata.BotSessionMetadata)
  field(:memuMetadata, 7, optional: true, type: WABotMetadata.BotMemuMetadata)
  field(:timezone, 8, optional: true, type: :string)
  field(:reminderMetadata, 9, optional: true, type: WABotMetadata.BotReminderMetadata)
  field(:modelMetadata, 10, optional: true, type: WABotMetadata.BotModelMetadata)
  field(:messageDisclaimerText, 11, optional: true, type: :string)

  field(:progressIndicatorMetadata, 12,
    optional: true,
    type: WABotMetadata.BotProgressIndicatorMetadata
  )

  field(:capabilityMetadata, 13, optional: true, type: WABotMetadata.BotCapabilityMetadata)
  field(:imagineMetadata, 14, optional: true, type: WABotMetadata.BotImagineMetadata)
  field(:memoryMetadata, 15, optional: true, type: WABotMetadata.BotMemoryMetadata)
  field(:renderingMetadata, 16, optional: true, type: WABotMetadata.BotRenderingMetadata)
  field(:botMetricsMetadata, 17, optional: true, type: WABotMetadata.BotMetricsMetadata)

  field(:botLinkedAccountsMetadata, 18,
    optional: true,
    type: WABotMetadata.BotLinkedAccountsMetadata
  )

  field(:richResponseSourcesMetadata, 19, optional: true, type: WABotMetadata.BotSourcesMetadata)
  field(:aiConversationContext, 20, optional: true, type: :bytes)

  field(:botPromotionMessageMetadata, 21,
    optional: true,
    type: WABotMetadata.BotPromotionMessageMetadata
  )

  field(:botModeSelectionMetadata, 22,
    optional: true,
    type: WABotMetadata.BotModeSelectionMetadata
  )

  field(:botQuotaMetadata, 23, optional: true, type: WABotMetadata.BotQuotaMetadata)

  field(:botAgeCollectionMetadata, 24,
    optional: true,
    type: WABotMetadata.BotAgeCollectionMetadata
  )

  field(:conversationStarterPromptID, 25, optional: true, type: :string)
  field(:botResponseID, 26, optional: true, type: :string)

  field(:verificationMetadata, 27,
    optional: true,
    type: WABotMetadata.BotSignatureVerificationMetadata
  )

  field(:unifiedResponseMutation, 28,
    optional: true,
    type: WABotMetadata.BotUnifiedResponseMutation
  )

  field(:botMessageOriginMetadata, 29,
    optional: true,
    type: WABotMetadata.BotMessageOriginMetadata
  )

  field(:inThreadSurveyMetadata, 30, optional: true, type: WABotMetadata.InThreadSurveyMetadata)
  field(:botThreadInfo, 31, optional: true, type: WABotMetadata.AIThreadInfo)
  field(:internalMetadata, 999, optional: true, type: :bytes)
end
