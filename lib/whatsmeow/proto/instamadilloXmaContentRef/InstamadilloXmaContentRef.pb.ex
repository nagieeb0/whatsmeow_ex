defmodule InstamadilloXmaContentRef.XmaActionType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "InstamadilloXmaContentRef.XmaActionType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "XmaActionType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "XMA_ACTION_TYPE_UNSPECIFIED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "XMA_ACTION_TYPE_SHARE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "XMA_ACTION_TYPE_REPLY",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "XMA_ACTION_TYPE_REACT",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "XMA_ACTION_TYPE_MENTION",
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

  field(:XMA_ACTION_TYPE_UNSPECIFIED, 0)
  field(:XMA_ACTION_TYPE_SHARE, 1)
  field(:XMA_ACTION_TYPE_REPLY, 2)
  field(:XMA_ACTION_TYPE_REACT, 3)
  field(:XMA_ACTION_TYPE_MENTION, 4)
end

defmodule InstamadilloXmaContentRef.ReceiverFetchContentType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "InstamadilloXmaContentRef.ReceiverFetchContentType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ReceiverFetchContentType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RECEIVER_FETCH_CONTENT_TYPE_UNSPECIFIED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RECEIVER_FETCH_CONTENT_TYPE_NOTE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RECEIVER_FETCH_CONTENT_TYPE_STORY",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RECEIVER_FETCH_CONTENT_TYPE_PROFILE",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RECEIVER_FETCH_CONTENT_TYPE_CLIP",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RECEIVER_FETCH_CONTENT_TYPE_FEED",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RECEIVER_FETCH_CONTENT_TYPE_LIVE",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RECEIVER_FETCH_CONTENT_TYPE_COMMENT",
          number: 7,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RECEIVER_FETCH_CONTENT_TYPE_LOCATION_SHARE",
          number: 8,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RECEIVER_FETCH_CONTENT_TYPE_REELS_AUDIO",
          number: 9,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RECEIVER_FETCH_CONTENT_TYPE_MEDIA_NOTE",
          number: 10,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RECEIVER_FETCH_CONTENT_TYPE_STORY_HIGHLIGHT",
          number: 11,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RECEIVER_FETCH_CONTENT_TYPE_SOCIAL_CONTEXT",
          number: 12,
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

  field(:RECEIVER_FETCH_CONTENT_TYPE_UNSPECIFIED, 0)
  field(:RECEIVER_FETCH_CONTENT_TYPE_NOTE, 1)
  field(:RECEIVER_FETCH_CONTENT_TYPE_STORY, 2)
  field(:RECEIVER_FETCH_CONTENT_TYPE_PROFILE, 3)
  field(:RECEIVER_FETCH_CONTENT_TYPE_CLIP, 4)
  field(:RECEIVER_FETCH_CONTENT_TYPE_FEED, 5)
  field(:RECEIVER_FETCH_CONTENT_TYPE_LIVE, 6)
  field(:RECEIVER_FETCH_CONTENT_TYPE_COMMENT, 7)
  field(:RECEIVER_FETCH_CONTENT_TYPE_LOCATION_SHARE, 8)
  field(:RECEIVER_FETCH_CONTENT_TYPE_REELS_AUDIO, 9)
  field(:RECEIVER_FETCH_CONTENT_TYPE_MEDIA_NOTE, 10)
  field(:RECEIVER_FETCH_CONTENT_TYPE_STORY_HIGHLIGHT, 11)
  field(:RECEIVER_FETCH_CONTENT_TYPE_SOCIAL_CONTEXT, 12)
end

defmodule InstamadilloXmaContentRef.MediaNoteFetchParamsMessageType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "InstamadilloXmaContentRef.MediaNoteFetchParamsMessageType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "MediaNoteFetchParamsMessageType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MEDIA_NOTE_FETCH_PARAMS_MESSAGE_TYPE_UNSPECIFIED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MEDIA_NOTE_FETCH_PARAMS_MESSAGE_TYPE_MENTION",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MEDIA_NOTE_FETCH_PARAMS_MESSAGE_TYPE_REPLY",
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

  field(:MEDIA_NOTE_FETCH_PARAMS_MESSAGE_TYPE_UNSPECIFIED, 0)
  field(:MEDIA_NOTE_FETCH_PARAMS_MESSAGE_TYPE_MENTION, 1)
  field(:MEDIA_NOTE_FETCH_PARAMS_MESSAGE_TYPE_REPLY, 2)
end

defmodule InstamadilloXmaContentRef.XmaContentRef do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloXmaContentRef.XmaContentRef",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "XmaContentRef",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "actionType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".InstamadilloXmaContentRef.XmaActionType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "actionType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "contentType",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".InstamadilloXmaContentRef.ReceiverFetchContentType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "contentType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "targetURL",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "targetURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "userName",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "userName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ownerFbid",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ownerFbid",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fetchParams",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloXmaContentRef.ReceiverFetchXmaFetchParams",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fetchParams",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:actionType, 1, optional: true, type: InstamadilloXmaContentRef.XmaActionType, enum: true)

  field(:contentType, 2,
    optional: true,
    type: InstamadilloXmaContentRef.ReceiverFetchContentType,
    enum: true
  )

  field(:targetURL, 3, optional: true, type: :string)
  field(:userName, 4, optional: true, type: :string)
  field(:ownerFbid, 5, optional: true, type: :string)

  field(:fetchParams, 6,
    optional: true,
    type: InstamadilloXmaContentRef.ReceiverFetchXmaFetchParams
  )
end

defmodule InstamadilloXmaContentRef.ReceiverFetchXmaFetchParams do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloXmaContentRef.ReceiverFetchXmaFetchParams",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ReceiverFetchXmaFetchParams",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "noteFetchParams",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloXmaContentRef.ReceiverFetchXmaNoteFetchParams",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "noteFetchParams",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "storyFetchParams",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloXmaContentRef.ReceiverFetchXmaStoryFetchParams",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "storyFetchParams",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "profileFetchParams",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloXmaContentRef.ReceiverFetchXmaProfileFetchParams",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "profileFetchParams",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "clipFetchParams",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloXmaContentRef.ReceiverFetchXmaClipFetchParams",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "clipFetchParams",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "feedFetchParams",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloXmaContentRef.ReceiverFetchXmaFeedFetchParams",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "feedFetchParams",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "liveFetchParams",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloXmaContentRef.ReceiverFetchXmaLiveFetchParams",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "liveFetchParams",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "commentFetchParams",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloXmaContentRef.ReceiverFetchXmaCommentFetchParams",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "commentFetchParams",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "locationShareFetchParams",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloXmaContentRef.ReceiverFetchXmaLocationShareFetchParams",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "locationShareFetchParams",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "reelsAudioFetchParams",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloXmaContentRef.ReceiverFetchXmaReelsAudioFetchParams",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "reelsAudioFetchParams",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaNoteFetchParams",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloXmaContentRef.ReceiverFetchXmaMediaNoteFetchParams",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "mediaNoteFetchParams",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "socialContextFetchParams",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloXmaContentRef.ReceiverFetchXmaSocialContextFetchParams",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "socialContextFetchParams",
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
          name: "receiverFetchXmaFetchParams",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:receiverFetchXmaFetchParams, 0)

  field(:noteFetchParams, 1,
    optional: true,
    type: InstamadilloXmaContentRef.ReceiverFetchXmaNoteFetchParams,
    oneof: 0
  )

  field(:storyFetchParams, 2,
    optional: true,
    type: InstamadilloXmaContentRef.ReceiverFetchXmaStoryFetchParams,
    oneof: 0
  )

  field(:profileFetchParams, 3,
    optional: true,
    type: InstamadilloXmaContentRef.ReceiverFetchXmaProfileFetchParams,
    oneof: 0
  )

  field(:clipFetchParams, 4,
    optional: true,
    type: InstamadilloXmaContentRef.ReceiverFetchXmaClipFetchParams,
    oneof: 0
  )

  field(:feedFetchParams, 5,
    optional: true,
    type: InstamadilloXmaContentRef.ReceiverFetchXmaFeedFetchParams,
    oneof: 0
  )

  field(:liveFetchParams, 6,
    optional: true,
    type: InstamadilloXmaContentRef.ReceiverFetchXmaLiveFetchParams,
    oneof: 0
  )

  field(:commentFetchParams, 7,
    optional: true,
    type: InstamadilloXmaContentRef.ReceiverFetchXmaCommentFetchParams,
    oneof: 0
  )

  field(:locationShareFetchParams, 8,
    optional: true,
    type: InstamadilloXmaContentRef.ReceiverFetchXmaLocationShareFetchParams,
    oneof: 0
  )

  field(:reelsAudioFetchParams, 9,
    optional: true,
    type: InstamadilloXmaContentRef.ReceiverFetchXmaReelsAudioFetchParams,
    oneof: 0
  )

  field(:mediaNoteFetchParams, 10,
    optional: true,
    type: InstamadilloXmaContentRef.ReceiverFetchXmaMediaNoteFetchParams,
    oneof: 0
  )

  field(:socialContextFetchParams, 11,
    optional: true,
    type: InstamadilloXmaContentRef.ReceiverFetchXmaSocialContextFetchParams,
    oneof: 0
  )
end

defmodule InstamadilloXmaContentRef.ReceiverFetchXmaNoteFetchParams do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloXmaContentRef.ReceiverFetchXmaNoteFetchParams",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ReceiverFetchXmaNoteFetchParams",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "noteIgid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "noteIgid",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:noteIgid, 1, optional: true, type: :string)
end

defmodule InstamadilloXmaContentRef.ReceiverFetchXmaStoryFetchParams do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloXmaContentRef.ReceiverFetchXmaStoryFetchParams",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ReceiverFetchXmaStoryFetchParams",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "storyIgid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "storyIgid",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "reelID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "reelID",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:storyIgid, 1, optional: true, type: :string)
  field(:reelID, 2, optional: true, type: :string)
end

defmodule InstamadilloXmaContentRef.ReceiverFetchXmaProfileFetchParams do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloXmaContentRef.ReceiverFetchXmaProfileFetchParams",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ReceiverFetchXmaProfileFetchParams",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "profileIgid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "profileIgid",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:profileIgid, 1, optional: true, type: :string)
end

defmodule InstamadilloXmaContentRef.ReceiverFetchXmaClipFetchParams do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloXmaContentRef.ReceiverFetchXmaClipFetchParams",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ReceiverFetchXmaClipFetchParams",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaIgid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaIgid",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:mediaIgid, 1, optional: true, type: :string)
end

defmodule InstamadilloXmaContentRef.ReceiverFetchXmaFeedFetchParams do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloXmaContentRef.ReceiverFetchXmaFeedFetchParams",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ReceiverFetchXmaFeedFetchParams",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaIgid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaIgid",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "carouselShareChildMediaIgid",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "carouselShareChildMediaIgid",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:mediaIgid, 1, optional: true, type: :string)
  field(:carouselShareChildMediaIgid, 2, optional: true, type: :string)
end

defmodule InstamadilloXmaContentRef.ReceiverFetchXmaLiveFetchParams do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloXmaContentRef.ReceiverFetchXmaLiveFetchParams",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ReceiverFetchXmaLiveFetchParams",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "liveIgid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "liveIgid",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:liveIgid, 1, optional: true, type: :string)
end

defmodule InstamadilloXmaContentRef.ReceiverFetchXmaCommentFetchParams do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloXmaContentRef.ReceiverFetchXmaCommentFetchParams",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ReceiverFetchXmaCommentFetchParams",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "commentFbid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "commentFbid",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:commentFbid, 1, optional: true, type: :string)
end

defmodule InstamadilloXmaContentRef.ReceiverFetchXmaLocationShareFetchParams do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloXmaContentRef.ReceiverFetchXmaLocationShareFetchParams",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ReceiverFetchXmaLocationShareFetchParams",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "locationIgid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "locationIgid",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:locationIgid, 1, optional: true, type: :string)
end

defmodule InstamadilloXmaContentRef.ReceiverFetchXmaReelsAudioFetchParams do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloXmaContentRef.ReceiverFetchXmaReelsAudioFetchParams",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ReceiverFetchXmaReelsAudioFetchParams",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "audioIgid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "audioIgid",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:audioIgid, 1, optional: true, type: :string)
end

defmodule InstamadilloXmaContentRef.ReceiverFetchXmaMediaNoteFetchParams do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloXmaContentRef.ReceiverFetchXmaMediaNoteFetchParams",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ReceiverFetchXmaMediaNoteFetchParams",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaNoteIgid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaNoteIgid",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageType",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".InstamadilloXmaContentRef.MediaNoteFetchParamsMessageType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageType",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:mediaNoteIgid, 1, optional: true, type: :string)

  field(:messageType, 2,
    optional: true,
    type: InstamadilloXmaContentRef.MediaNoteFetchParamsMessageType,
    enum: true
  )
end

defmodule InstamadilloXmaContentRef.ReceiverFetchXmaSocialContextFetchParams do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloXmaContentRef.ReceiverFetchXmaSocialContextFetchParams",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ReceiverFetchXmaSocialContextFetchParams",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaIgid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaIgid",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:mediaIgid, 1, optional: true, type: :string)
end
