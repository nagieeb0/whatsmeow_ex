defmodule WAArmadilloXMA.ExtendedContentMessage.XmaDataclassType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAArmadilloXMA.ExtendedContentMessage.XmaDataclassType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "XmaDataclassType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SENDER_COPY",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SERVER",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SIGNED_CLIENT",
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

  field(:SENDER_COPY, 0)
  field(:SERVER, 1)
  field(:SIGNED_CLIENT, 2)
end

defmodule WAArmadilloXMA.ExtendedContentMessage.OverlayIconGlyph do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAArmadilloXMA.ExtendedContentMessage.OverlayIconGlyph",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "OverlayIconGlyph",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INFO",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "EYE_OFF",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NEWS_OFF",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WARNING",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PRIVATE",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NONE",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MEDIA_LABEL",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "POST_COVER",
          number: 7,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "POST_LABEL",
          number: 8,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WARNING_SCREENS",
          number: 9,
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

  field(:INFO, 0)
  field(:EYE_OFF, 1)
  field(:NEWS_OFF, 2)
  field(:WARNING, 3)
  field(:PRIVATE, 4)
  field(:NONE, 5)
  field(:MEDIA_LABEL, 6)
  field(:POST_COVER, 7)
  field(:POST_LABEL, 8)
  field(:WARNING_SCREENS, 9)
end

defmodule WAArmadilloXMA.ExtendedContentMessage.CtaButtonType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAArmadilloXMA.ExtendedContentMessage.CtaButtonType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "CtaButtonType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "OPEN_NATIVE",
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

  field(:OPEN_NATIVE, 11)
end

defmodule WAArmadilloXMA.ExtendedContentMessage.XmaLayoutType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAArmadilloXMA.ExtendedContentMessage.XmaLayoutType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "XmaLayoutType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SINGLE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "HSCROLL",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PORTRAIT",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "STANDARD_DXMA",
          number: 12,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LIST_DXMA",
          number: 15,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GRID",
          number: 16,
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

  field(:SINGLE, 0)
  field(:HSCROLL, 1)
  field(:PORTRAIT, 3)
  field(:STANDARD_DXMA, 12)
  field(:LIST_DXMA, 15)
  field(:GRID, 16)
end

defmodule WAArmadilloXMA.ExtendedContentMessage.ExtendedContentType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAArmadilloXMA.ExtendedContentMessage.ExtendedContentType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ExtendedContentType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNSUPPORTED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_STORY_PHOTO_MENTION",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_SINGLE_IMAGE_POST_SHARE",
          number: 9,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_MULTIPOST_SHARE",
          number: 10,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_SINGLE_VIDEO_POST_SHARE",
          number: 11,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_STORY_PHOTO_SHARE",
          number: 12,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_STORY_VIDEO_SHARE",
          number: 13,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_CLIPS_SHARE",
          number: 14,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_IGTV_SHARE",
          number: 15,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_SHOP_SHARE",
          number: 16,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_PROFILE_SHARE",
          number: 19,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_STORY_PHOTO_HIGHLIGHT_SHARE",
          number: 20,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_STORY_VIDEO_HIGHLIGHT_SHARE",
          number: 21,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_STORY_REPLY",
          number: 22,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_STORY_REACTION",
          number: 23,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_STORY_VIDEO_MENTION",
          number: 24,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_STORY_HIGHLIGHT_REPLY",
          number: 25,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_STORY_HIGHLIGHT_REACTION",
          number: 26,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_EXTERNAL_LINK",
          number: 27,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IG_RECEIVER_FETCH",
          number: 28,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FB_FEED_SHARE",
          number: 1000,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FB_STORY_REPLY",
          number: 1001,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FB_STORY_SHARE",
          number: 1002,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FB_STORY_MENTION",
          number: 1003,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FB_FEED_VIDEO_SHARE",
          number: 1004,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FB_GAMING_CUSTOM_UPDATE",
          number: 1005,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FB_PRODUCER_STORY_REPLY",
          number: 1006,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FB_EVENT",
          number: 1007,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FB_FEED_POST_PRIVATE_REPLY",
          number: 1008,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FB_SHORT",
          number: 1009,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FB_COMMENT_MENTION_SHARE",
          number: 1010,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FB_POST_MENTION",
          number: 1011,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FB_PROFILE_DIRECTORY_ITEM",
          number: 1013,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FB_FEED_POST_REACTION_REPLY",
          number: 1014,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FB_QUICKSNAP_REPLY",
          number: 1015,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_EXTERNAL_LINK_SHARE",
          number: 2000,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_P2P_PAYMENT",
          number: 2001,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_LOCATION_SHARING",
          number: 2002,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_LOCATION_SHARING_V2",
          number: 2003,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_HIGHLIGHTS_TAB_FRIEND_UPDATES_REPLY",
          number: 2004,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_HIGHLIGHTS_TAB_LOCAL_EVENT_REPLY",
          number: 2005,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_RECEIVER_FETCH",
          number: 2006,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_IG_MEDIA_SHARE",
          number: 2007,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_GEN_AI_SEARCH_PLUGIN_RESPONSE",
          number: 2008,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_REELS_LIST",
          number: 2009,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_CONTACT",
          number: 2010,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_THREADS_POST_SHARE",
          number: 2011,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_FILE",
          number: 2012,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_AVATAR_DETAILS",
          number: 2013,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_AI_CONTACT",
          number: 2014,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_MEMORIES_SHARE",
          number: 2015,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_SHARED_ALBUM_REPLY",
          number: 2016,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_SHARED_ALBUM",
          number: 2017,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_OCCAMADILLO_XMA",
          number: 2018,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_GEN_AI_SUBSCRIPTION",
          number: 2021,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_GEN_AI_REMINDER",
          number: 2022,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_GEN_AI_MEMU_ONBOARDING_RESPONSE",
          number: 2023,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_NOTE_REPLY",
          number: 2024,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_NOTE_MENTION",
          number: 2025,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GEN_AI_ENTITY",
          number: 2026,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_OPG_P2P_PAYMENT",
          number: 2027,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GEN_AI_RICH_RESPONSE",
          number: 2028,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_MUSIC_STICKER",
          number: 2029,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_PHONE_NUMBER",
          number: 2030,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_ACTIVITY_SHARE",
          number: 2031,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_PRIVATE_XMA",
          number: 2032,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_SOCIAL_CUE_MEMORIES",
          number: 2033,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_MANUS_GROWTH_REFERRAL",
          number: 2060,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_MOMENT_LINK",
          number: 2061,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_HORIZON_WEEL",
          number: 2062,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_MOMENT_ADDED",
          number: 2063,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RTC_AUDIO_CALL",
          number: 3000,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RTC_VIDEO_CALL",
          number: 3001,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RTC_MISSED_AUDIO_CALL",
          number: 3002,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RTC_MISSED_VIDEO_CALL",
          number: 3003,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RTC_GROUP_AUDIO_CALL",
          number: 3004,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RTC_GROUP_VIDEO_CALL",
          number: 3005,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RTC_MISSED_GROUP_AUDIO_CALL",
          number: 3006,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RTC_MISSED_GROUP_VIDEO_CALL",
          number: 3007,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RTC_ONGOING_AUDIO_CALL",
          number: 3008,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RTC_ONGOING_VIDEO_CALL",
          number: 3009,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MSG_RECEIVER_FETCH_FALLBACK",
          number: 3025,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DATACLASS_SENDER_COPY",
          number: 4000,
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

  field(:UNSUPPORTED, 0)
  field(:IG_STORY_PHOTO_MENTION, 4)
  field(:IG_SINGLE_IMAGE_POST_SHARE, 9)
  field(:IG_MULTIPOST_SHARE, 10)
  field(:IG_SINGLE_VIDEO_POST_SHARE, 11)
  field(:IG_STORY_PHOTO_SHARE, 12)
  field(:IG_STORY_VIDEO_SHARE, 13)
  field(:IG_CLIPS_SHARE, 14)
  field(:IG_IGTV_SHARE, 15)
  field(:IG_SHOP_SHARE, 16)
  field(:IG_PROFILE_SHARE, 19)
  field(:IG_STORY_PHOTO_HIGHLIGHT_SHARE, 20)
  field(:IG_STORY_VIDEO_HIGHLIGHT_SHARE, 21)
  field(:IG_STORY_REPLY, 22)
  field(:IG_STORY_REACTION, 23)
  field(:IG_STORY_VIDEO_MENTION, 24)
  field(:IG_STORY_HIGHLIGHT_REPLY, 25)
  field(:IG_STORY_HIGHLIGHT_REACTION, 26)
  field(:IG_EXTERNAL_LINK, 27)
  field(:IG_RECEIVER_FETCH, 28)
  field(:FB_FEED_SHARE, 1000)
  field(:FB_STORY_REPLY, 1001)
  field(:FB_STORY_SHARE, 1002)
  field(:FB_STORY_MENTION, 1003)
  field(:FB_FEED_VIDEO_SHARE, 1004)
  field(:FB_GAMING_CUSTOM_UPDATE, 1005)
  field(:FB_PRODUCER_STORY_REPLY, 1006)
  field(:FB_EVENT, 1007)
  field(:FB_FEED_POST_PRIVATE_REPLY, 1008)
  field(:FB_SHORT, 1009)
  field(:FB_COMMENT_MENTION_SHARE, 1010)
  field(:FB_POST_MENTION, 1011)
  field(:FB_PROFILE_DIRECTORY_ITEM, 1013)
  field(:FB_FEED_POST_REACTION_REPLY, 1014)
  field(:FB_QUICKSNAP_REPLY, 1015)
  field(:MSG_EXTERNAL_LINK_SHARE, 2000)
  field(:MSG_P2P_PAYMENT, 2001)
  field(:MSG_LOCATION_SHARING, 2002)
  field(:MSG_LOCATION_SHARING_V2, 2003)
  field(:MSG_HIGHLIGHTS_TAB_FRIEND_UPDATES_REPLY, 2004)
  field(:MSG_HIGHLIGHTS_TAB_LOCAL_EVENT_REPLY, 2005)
  field(:MSG_RECEIVER_FETCH, 2006)
  field(:MSG_IG_MEDIA_SHARE, 2007)
  field(:MSG_GEN_AI_SEARCH_PLUGIN_RESPONSE, 2008)
  field(:MSG_REELS_LIST, 2009)
  field(:MSG_CONTACT, 2010)
  field(:MSG_THREADS_POST_SHARE, 2011)
  field(:MSG_FILE, 2012)
  field(:MSG_AVATAR_DETAILS, 2013)
  field(:MSG_AI_CONTACT, 2014)
  field(:MSG_MEMORIES_SHARE, 2015)
  field(:MSG_SHARED_ALBUM_REPLY, 2016)
  field(:MSG_SHARED_ALBUM, 2017)
  field(:MSG_OCCAMADILLO_XMA, 2018)
  field(:MSG_GEN_AI_SUBSCRIPTION, 2021)
  field(:MSG_GEN_AI_REMINDER, 2022)
  field(:MSG_GEN_AI_MEMU_ONBOARDING_RESPONSE, 2023)
  field(:MSG_NOTE_REPLY, 2024)
  field(:MSG_NOTE_MENTION, 2025)
  field(:GEN_AI_ENTITY, 2026)
  field(:MSG_OPG_P2P_PAYMENT, 2027)
  field(:GEN_AI_RICH_RESPONSE, 2028)
  field(:MSG_MUSIC_STICKER, 2029)
  field(:MSG_PHONE_NUMBER, 2030)
  field(:AI_ACTIVITY_SHARE, 2031)
  field(:MSG_PRIVATE_XMA, 2032)
  field(:MSG_SOCIAL_CUE_MEMORIES, 2033)
  field(:MSG_MANUS_GROWTH_REFERRAL, 2060)
  field(:MSG_MOMENT_LINK, 2061)
  field(:MSG_HORIZON_WEEL, 2062)
  field(:MSG_MOMENT_ADDED, 2063)
  field(:RTC_AUDIO_CALL, 3000)
  field(:RTC_VIDEO_CALL, 3001)
  field(:RTC_MISSED_AUDIO_CALL, 3002)
  field(:RTC_MISSED_VIDEO_CALL, 3003)
  field(:RTC_GROUP_AUDIO_CALL, 3004)
  field(:RTC_GROUP_VIDEO_CALL, 3005)
  field(:RTC_MISSED_GROUP_AUDIO_CALL, 3006)
  field(:RTC_MISSED_GROUP_VIDEO_CALL, 3007)
  field(:RTC_ONGOING_AUDIO_CALL, 3008)
  field(:RTC_ONGOING_VIDEO_CALL, 3009)
  field(:MSG_RECEIVER_FETCH_FALLBACK, 3025)
  field(:DATACLASS_SENDER_COPY, 4000)
end

defmodule WAArmadilloXMA.ExtendedContentMessage.CTA do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloXMA.ExtendedContentMessage.CTA",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "CTA",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "buttonType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAArmadilloXMA.ExtendedContentMessage.CtaButtonType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "buttonType",
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
          name: "actionURL",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "actionURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "nativeURL",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "nativeURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ctaType",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ctaType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "actionContentBlob",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "actionContentBlob",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:buttonType, 1,
    optional: true,
    type: WAArmadilloXMA.ExtendedContentMessage.CtaButtonType,
    enum: true
  )

  field(:title, 2, optional: true, type: :string)
  field(:actionURL, 3, optional: true, type: :string)
  field(:nativeURL, 4, optional: true, type: :string)
  field(:ctaType, 5, optional: true, type: :string)
  field(:actionContentBlob, 6, optional: true, type: :string)
end

defmodule WAArmadilloXMA.ExtendedContentMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloXMA.ExtendedContentMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ExtendedContentMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "associatedMessage",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "associatedMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "targetType",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAArmadilloXMA.ExtendedContentMessage.ExtendedContentType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "targetType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "targetUsername",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "targetUsername",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "targetID",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "targetID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "targetExpiringAtSec",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "targetExpiringAtSec",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmaLayoutType",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAArmadilloXMA.ExtendedContentMessage.XmaLayoutType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "xmaLayoutType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ctas",
          extendee: nil,
          number: 7,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloXMA.ExtendedContentMessage.CTA",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ctas",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "previews",
          extendee: nil,
          number: 8,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "previews",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "titleText",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "titleText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "subtitleText",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "subtitleText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "maxTitleNumOfLines",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "maxTitleNumOfLines",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "maxSubtitleNumOfLines",
          extendee: nil,
          number: 12,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "maxSubtitleNumOfLines",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "favicon",
          extendee: nil,
          number: 13,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "favicon",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "headerImage",
          extendee: nil,
          number: 14,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "headerImage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "headerTitle",
          extendee: nil,
          number: 15,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "headerTitle",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "overlayIconGlyph",
          extendee: nil,
          number: 16,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAArmadilloXMA.ExtendedContentMessage.OverlayIconGlyph",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "overlayIconGlyph",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "overlayTitle",
          extendee: nil,
          number: 17,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "overlayTitle",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "overlayDescription",
          extendee: nil,
          number: 18,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "overlayDescription",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sentWithMessageID",
          extendee: nil,
          number: 19,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sentWithMessageID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageText",
          extendee: nil,
          number: 20,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "headerSubtitle",
          extendee: nil,
          number: 21,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "headerSubtitle",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmaDataclass",
          extendee: nil,
          number: 22,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "xmaDataclass",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "contentRef",
          extendee: nil,
          number: 23,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "contentRef",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mentionedJID",
          extendee: nil,
          number: 24,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mentionedJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "commands",
          extendee: nil,
          number: 25,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.Command",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "commands",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mentions",
          extendee: nil,
          number: 26,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.Mention",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mentions",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "xmaDataclassType",
          extendee: nil,
          number: 27,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAArmadilloXMA.ExtendedContentMessage.XmaDataclassType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "xmaDataclassType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "signedXmaDataclassValidation",
          extendee: nil,
          number: 28,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "signedXmaDataclassValidation",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "featureSharedSessionID",
          extendee: nil,
          number: 29,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "featureSharedSessionID",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "CTA",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "buttonType",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAArmadilloXMA.ExtendedContentMessage.CtaButtonType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "buttonType",
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
              name: "actionURL",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "actionURL",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "nativeURL",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "nativeURL",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "ctaType",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "ctaType",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "actionContentBlob",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "actionContentBlob",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
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
          name: "XmaDataclassType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SENDER_COPY",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SERVER",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SIGNED_CLIENT",
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
          name: "OverlayIconGlyph",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INFO",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "EYE_OFF",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NEWS_OFF",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WARNING",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PRIVATE",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NONE",
              number: 5,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MEDIA_LABEL",
              number: 6,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "POST_COVER",
              number: 7,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "POST_LABEL",
              number: 8,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WARNING_SCREENS",
              number: 9,
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
          name: "CtaButtonType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "OPEN_NATIVE",
              number: 11,
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
          name: "XmaLayoutType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SINGLE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "HSCROLL",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PORTRAIT",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "STANDARD_DXMA",
              number: 12,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "LIST_DXMA",
              number: 15,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GRID",
              number: 16,
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
          name: "ExtendedContentType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNSUPPORTED",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_STORY_PHOTO_MENTION",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_SINGLE_IMAGE_POST_SHARE",
              number: 9,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_MULTIPOST_SHARE",
              number: 10,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_SINGLE_VIDEO_POST_SHARE",
              number: 11,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_STORY_PHOTO_SHARE",
              number: 12,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_STORY_VIDEO_SHARE",
              number: 13,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_CLIPS_SHARE",
              number: 14,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_IGTV_SHARE",
              number: 15,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_SHOP_SHARE",
              number: 16,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_PROFILE_SHARE",
              number: 19,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_STORY_PHOTO_HIGHLIGHT_SHARE",
              number: 20,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_STORY_VIDEO_HIGHLIGHT_SHARE",
              number: 21,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_STORY_REPLY",
              number: 22,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_STORY_REACTION",
              number: 23,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_STORY_VIDEO_MENTION",
              number: 24,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_STORY_HIGHLIGHT_REPLY",
              number: 25,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_STORY_HIGHLIGHT_REACTION",
              number: 26,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_EXTERNAL_LINK",
              number: 27,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IG_RECEIVER_FETCH",
              number: 28,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FB_FEED_SHARE",
              number: 1000,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FB_STORY_REPLY",
              number: 1001,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FB_STORY_SHARE",
              number: 1002,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FB_STORY_MENTION",
              number: 1003,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FB_FEED_VIDEO_SHARE",
              number: 1004,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FB_GAMING_CUSTOM_UPDATE",
              number: 1005,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FB_PRODUCER_STORY_REPLY",
              number: 1006,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FB_EVENT",
              number: 1007,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FB_FEED_POST_PRIVATE_REPLY",
              number: 1008,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FB_SHORT",
              number: 1009,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FB_COMMENT_MENTION_SHARE",
              number: 1010,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FB_POST_MENTION",
              number: 1011,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FB_PROFILE_DIRECTORY_ITEM",
              number: 1013,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FB_FEED_POST_REACTION_REPLY",
              number: 1014,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FB_QUICKSNAP_REPLY",
              number: 1015,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_EXTERNAL_LINK_SHARE",
              number: 2000,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_P2P_PAYMENT",
              number: 2001,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_LOCATION_SHARING",
              number: 2002,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_LOCATION_SHARING_V2",
              number: 2003,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_HIGHLIGHTS_TAB_FRIEND_UPDATES_REPLY",
              number: 2004,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_HIGHLIGHTS_TAB_LOCAL_EVENT_REPLY",
              number: 2005,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_RECEIVER_FETCH",
              number: 2006,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_IG_MEDIA_SHARE",
              number: 2007,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_GEN_AI_SEARCH_PLUGIN_RESPONSE",
              number: 2008,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_REELS_LIST",
              number: 2009,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_CONTACT",
              number: 2010,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_THREADS_POST_SHARE",
              number: 2011,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_FILE",
              number: 2012,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_AVATAR_DETAILS",
              number: 2013,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_AI_CONTACT",
              number: 2014,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_MEMORIES_SHARE",
              number: 2015,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_SHARED_ALBUM_REPLY",
              number: 2016,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_SHARED_ALBUM",
              number: 2017,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_OCCAMADILLO_XMA",
              number: 2018,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_GEN_AI_SUBSCRIPTION",
              number: 2021,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_GEN_AI_REMINDER",
              number: 2022,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_GEN_AI_MEMU_ONBOARDING_RESPONSE",
              number: 2023,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_NOTE_REPLY",
              number: 2024,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_NOTE_MENTION",
              number: 2025,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GEN_AI_ENTITY",
              number: 2026,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_OPG_P2P_PAYMENT",
              number: 2027,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GEN_AI_RICH_RESPONSE",
              number: 2028,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_MUSIC_STICKER",
              number: 2029,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_PHONE_NUMBER",
              number: 2030,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_ACTIVITY_SHARE",
              number: 2031,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_PRIVATE_XMA",
              number: 2032,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_SOCIAL_CUE_MEMORIES",
              number: 2033,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_MANUS_GROWTH_REFERRAL",
              number: 2060,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_MOMENT_LINK",
              number: 2061,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_HORIZON_WEEL",
              number: 2062,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_MOMENT_ADDED",
              number: 2063,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RTC_AUDIO_CALL",
              number: 3000,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RTC_VIDEO_CALL",
              number: 3001,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RTC_MISSED_AUDIO_CALL",
              number: 3002,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RTC_MISSED_VIDEO_CALL",
              number: 3003,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RTC_GROUP_AUDIO_CALL",
              number: 3004,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RTC_GROUP_VIDEO_CALL",
              number: 3005,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RTC_MISSED_GROUP_AUDIO_CALL",
              number: 3006,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RTC_MISSED_GROUP_VIDEO_CALL",
              number: 3007,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RTC_ONGOING_AUDIO_CALL",
              number: 3008,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RTC_ONGOING_VIDEO_CALL",
              number: 3009,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MSG_RECEIVER_FETCH_FALLBACK",
              number: 3025,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DATACLASS_SENDER_COPY",
              number: 4000,
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

  field(:associatedMessage, 1, optional: true, type: WACommon.SubProtocol)

  field(:targetType, 2,
    optional: true,
    type: WAArmadilloXMA.ExtendedContentMessage.ExtendedContentType,
    enum: true
  )

  field(:targetUsername, 3, optional: true, type: :string)
  field(:targetID, 4, optional: true, type: :string)
  field(:targetExpiringAtSec, 5, optional: true, type: :int64)

  field(:xmaLayoutType, 6,
    optional: true,
    type: WAArmadilloXMA.ExtendedContentMessage.XmaLayoutType,
    enum: true
  )

  field(:ctas, 7, repeated: true, type: WAArmadilloXMA.ExtendedContentMessage.CTA)
  field(:previews, 8, repeated: true, type: WACommon.SubProtocol)
  field(:titleText, 9, optional: true, type: :string)
  field(:subtitleText, 10, optional: true, type: :string)
  field(:maxTitleNumOfLines, 11, optional: true, type: :uint32)
  field(:maxSubtitleNumOfLines, 12, optional: true, type: :uint32)
  field(:favicon, 13, optional: true, type: WACommon.SubProtocol)
  field(:headerImage, 14, optional: true, type: WACommon.SubProtocol)
  field(:headerTitle, 15, optional: true, type: :string)

  field(:overlayIconGlyph, 16,
    optional: true,
    type: WAArmadilloXMA.ExtendedContentMessage.OverlayIconGlyph,
    enum: true
  )

  field(:overlayTitle, 17, optional: true, type: :string)
  field(:overlayDescription, 18, optional: true, type: :string)
  field(:sentWithMessageID, 19, optional: true, type: :string)
  field(:messageText, 20, optional: true, type: :string)
  field(:headerSubtitle, 21, optional: true, type: :string)
  field(:xmaDataclass, 22, optional: true, type: :string)
  field(:contentRef, 23, optional: true, type: :string)
  field(:mentionedJID, 24, repeated: true, type: :string)
  field(:commands, 25, repeated: true, type: WACommon.Command)
  field(:mentions, 26, repeated: true, type: WACommon.Mention)

  field(:xmaDataclassType, 27,
    optional: true,
    type: WAArmadilloXMA.ExtendedContentMessage.XmaDataclassType,
    enum: true
  )

  field(:signedXmaDataclassValidation, 28, optional: true, type: :string)
  field(:featureSharedSessionID, 29, optional: true, type: :string)
end
