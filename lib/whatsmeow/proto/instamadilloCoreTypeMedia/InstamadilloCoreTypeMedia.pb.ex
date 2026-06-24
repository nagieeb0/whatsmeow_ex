defmodule InstamadilloCoreTypeMedia.PjpegScanConfiguration do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "InstamadilloCoreTypeMedia.PjpegScanConfiguration",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "PjpegScanConfiguration",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PJPEG_SCAN_CONFIGURATION_UNSPECIFIED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PJPEG_SCAN_CONFIGURATION_WA",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PJPEG_SCAN_CONFIGURATION_E15",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PJPEG_SCAN_CONFIGURATION_E35",
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

  field(:PJPEG_SCAN_CONFIGURATION_UNSPECIFIED, 0)
  field(:PJPEG_SCAN_CONFIGURATION_WA, 1)
  field(:PJPEG_SCAN_CONFIGURATION_E15, 2)
  field(:PJPEG_SCAN_CONFIGURATION_E35, 3)
end

defmodule InstamadilloCoreTypeMedia.Media.InterventionType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "InstamadilloCoreTypeMedia.Media.InterventionType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "InterventionType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNSET",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NONE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NUDE",
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
  field(:NONE, 1)
  field(:NUDE, 2)
end

defmodule InstamadilloCoreTypeMedia.Raven.ViewMode do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "InstamadilloCoreTypeMedia.Raven.ViewMode",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ViewMode",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RAVEN_VIEW_MODEL_UNSPECIFIED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RAVEN_VIEW_MODEL_ONCE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RAVEN_VIEW_MODEL_REPLAYABLE",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RAVEN_VIEW_MODEL_PERMANENT",
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

  field(:RAVEN_VIEW_MODEL_UNSPECIFIED, 0)
  field(:RAVEN_VIEW_MODEL_ONCE, 1)
  field(:RAVEN_VIEW_MODEL_REPLAYABLE, 2)
  field(:RAVEN_VIEW_MODEL_PERMANENT, 3)
end

defmodule InstamadilloCoreTypeMedia.Media do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeMedia.Media",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Media",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "staticPhoto",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.StaticPhoto",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "staticPhoto",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "voice",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.Voice",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "voice",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "video",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.Video",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "video",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "raven",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.Raven",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "raven",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "gif",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.Gif",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "gif",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "avatarSticker",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.AvatarSticker",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "avatarSticker",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "InterventionType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNSET",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NONE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NUDE",
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
      oneof_decl: [
        %Google.Protobuf.OneofDescriptorProto{name: "media", options: nil, __unknown_fields__: []}
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:media, 0)

  field(:staticPhoto, 1, optional: true, type: InstamadilloCoreTypeMedia.StaticPhoto, oneof: 0)
  field(:voice, 2, optional: true, type: InstamadilloCoreTypeMedia.Voice, oneof: 0)
  field(:video, 3, optional: true, type: InstamadilloCoreTypeMedia.Video, oneof: 0)
  field(:raven, 4, optional: true, type: InstamadilloCoreTypeMedia.Raven, oneof: 0)
  field(:gif, 5, optional: true, type: InstamadilloCoreTypeMedia.Gif, oneof: 0)
  field(:avatarSticker, 6, optional: true, type: InstamadilloCoreTypeMedia.AvatarSticker, oneof: 0)
end

defmodule InstamadilloCoreTypeMedia.StaticPhoto do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeMedia.StaticPhoto",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "StaticPhoto",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaTransport",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.CommonMediaTransport",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaTransport",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "height",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
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
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "width",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "scanLengths",
          extendee: nil,
          number: 4,
          label: :LABEL_REPEATED,
          type: :TYPE_INT32,
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
          json_name: "scanLengths",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "thumbnail",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.Thumbnail",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "thumbnail",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pjpegScanConfiguration",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".InstamadilloCoreTypeMedia.PjpegScanConfiguration",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pjpegScanConfiguration",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:mediaTransport, 1, optional: true, type: InstamadilloCoreTypeMedia.CommonMediaTransport)
  field(:height, 2, optional: true, type: :int32)
  field(:width, 3, optional: true, type: :int32)
  field(:scanLengths, 4, repeated: true, type: :int32, packed: true, deprecated: false)
  field(:thumbnail, 5, optional: true, type: InstamadilloCoreTypeMedia.Thumbnail)

  field(:pjpegScanConfiguration, 6,
    optional: true,
    type: InstamadilloCoreTypeMedia.PjpegScanConfiguration,
    enum: true
  )
end

defmodule InstamadilloCoreTypeMedia.Voice do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeMedia.Voice",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Voice",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaTransport",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.CommonMediaTransport",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaTransport",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "duration",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "duration",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "waveforms",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_FLOAT,
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
          json_name: "waveforms",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "waveformSamplingFrequencyHz",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "waveformSamplingFrequencyHz",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:mediaTransport, 1, optional: true, type: InstamadilloCoreTypeMedia.CommonMediaTransport)
  field(:duration, 2, optional: true, type: :int32)
  field(:waveforms, 3, repeated: true, type: :float, packed: true, deprecated: false)
  field(:waveformSamplingFrequencyHz, 4, optional: true, type: :int32)
end

defmodule InstamadilloCoreTypeMedia.Video do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeMedia.Video",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Video",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaTransport",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.CommonMediaTransport",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaTransport",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "height",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
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
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "width",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "thumbnail",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.Thumbnail",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "thumbnail",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "videoExtraMetadata",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.VideoExtraMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "videoExtraMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:mediaTransport, 1, optional: true, type: InstamadilloCoreTypeMedia.CommonMediaTransport)
  field(:height, 2, optional: true, type: :int32)
  field(:width, 3, optional: true, type: :int32)
  field(:thumbnail, 4, optional: true, type: InstamadilloCoreTypeMedia.Thumbnail)
  field(:videoExtraMetadata, 5, optional: true, type: InstamadilloCoreTypeMedia.VideoExtraMetadata)
end

defmodule InstamadilloCoreTypeMedia.Gif do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeMedia.Gif",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Gif",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaTransport",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.CommonMediaTransport",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaTransport",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "height",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
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
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "width",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isSticker",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isSticker",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "stickerID",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "stickerID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "gifURL",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "gifURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "gifSize",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "gifSize",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isRandom",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isRandom",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:mediaTransport, 1, optional: true, type: InstamadilloCoreTypeMedia.CommonMediaTransport)
  field(:height, 2, optional: true, type: :int32)
  field(:width, 3, optional: true, type: :int32)
  field(:isSticker, 4, optional: true, type: :bool)
  field(:stickerID, 5, optional: true, type: :string)
  field(:gifURL, 6, optional: true, type: :string)
  field(:gifSize, 7, optional: true, type: :int32)
  field(:isRandom, 8, optional: true, type: :bool)
end

defmodule InstamadilloCoreTypeMedia.AvatarSticker do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeMedia.AvatarSticker",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AvatarSticker",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaTransport",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.CommonMediaTransport",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaTransport",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isAnimated",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isAnimated",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "stickerID",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "stickerID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "stickerTemplate",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "stickerTemplate",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "nuxType",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "nuxType",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:mediaTransport, 1, optional: true, type: InstamadilloCoreTypeMedia.CommonMediaTransport)
  field(:isAnimated, 2, optional: true, type: :bool)
  field(:stickerID, 3, optional: true, type: :string)
  field(:stickerTemplate, 4, optional: true, type: :string)
  field(:nuxType, 5, optional: true, type: :int32)
end

defmodule InstamadilloCoreTypeMedia.Raven do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeMedia.Raven",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Raven",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "viewMode",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".InstamadilloCoreTypeMedia.Raven.ViewMode",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "viewMode",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "content",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.RavenContent",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "content",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "ViewMode",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RAVEN_VIEW_MODEL_UNSPECIFIED",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RAVEN_VIEW_MODEL_ONCE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RAVEN_VIEW_MODEL_REPLAYABLE",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RAVEN_VIEW_MODEL_PERMANENT",
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

  field(:viewMode, 1, optional: true, type: InstamadilloCoreTypeMedia.Raven.ViewMode, enum: true)
  field(:content, 2, optional: true, type: InstamadilloCoreTypeMedia.RavenContent)
end

defmodule InstamadilloCoreTypeMedia.RavenContent do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeMedia.RavenContent",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "RavenContent",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "staticPhoto",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.StaticPhoto",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "staticPhoto",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "video",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.Video",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "video",
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
          name: "ravenContent",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:ravenContent, 0)

  field(:staticPhoto, 1, optional: true, type: InstamadilloCoreTypeMedia.StaticPhoto, oneof: 0)
  field(:video, 2, optional: true, type: InstamadilloCoreTypeMedia.Video, oneof: 0)
end

defmodule InstamadilloCoreTypeMedia.Thumbnail do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeMedia.Thumbnail",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Thumbnail",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaTransport",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".InstamadilloCoreTypeMedia.CommonMediaTransport",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaTransport",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "height",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
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
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "width",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:mediaTransport, 1, optional: true, type: InstamadilloCoreTypeMedia.CommonMediaTransport)
  field(:height, 2, optional: true, type: :int32)
  field(:width, 3, optional: true, type: :int32)
end

defmodule InstamadilloCoreTypeMedia.CommonMediaTransport do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeMedia.CommonMediaTransport",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "CommonMediaTransport",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fileSHA256",
          extendee: nil,
          number: 2,
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
          number: 3,
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
          number: 4,
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
          number: 5,
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
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaKeyTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sidecar",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sidecar",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fileLength",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fileLength",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mimetype",
          extendee: nil,
          number: 9,
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
          name: "objectID",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "objectID",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:mediaID, 1, optional: true, type: :string)
  field(:fileSHA256, 2, optional: true, type: :string)
  field(:mediaKey, 3, optional: true, type: :string)
  field(:fileEncSHA256, 4, optional: true, type: :string)
  field(:directPath, 5, optional: true, type: :string)
  field(:mediaKeyTimestamp, 6, optional: true, type: :string)
  field(:sidecar, 7, optional: true, type: :string)
  field(:fileLength, 8, optional: true, type: :int32)
  field(:mimetype, 9, optional: true, type: :string)
  field(:objectID, 10, optional: true, type: :string)
end

defmodule InstamadilloCoreTypeMedia.VideoExtraMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "InstamadilloCoreTypeMedia.VideoExtraMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "VideoExtraMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "uploadMosClientScore",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_FLOAT,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "uploadMosClientScore",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:uploadMosClientScore, 1, optional: true, type: :float)
end
