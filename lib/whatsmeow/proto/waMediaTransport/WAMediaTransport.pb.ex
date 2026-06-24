defmodule WAMediaTransport.ImageTransport.Ancillary.HdType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAMediaTransport.ImageTransport.Ancillary.HdType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "HdType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NONE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LQ_4K",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "HQ_4K",
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
  field(:LQ_4K, 1)
  field(:HQ_4K, 2)
end

defmodule WAMediaTransport.VideoTransport.Ancillary.Attribution do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAMediaTransport.VideoTransport.Ancillary.Attribution",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Attribution",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NONE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GIPHY",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TENOR",
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
  field(:GIPHY, 1)
  field(:TENOR, 2)
end

defmodule WAMediaTransport.AudioTransport.Ancillary.AvatarAudio.AnimationsType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAMediaTransport.AudioTransport.Ancillary.AvatarAudio.AnimationsType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "AnimationsType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TALKING_A",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IDLE_A",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TALKING_B",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IDLE_B",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BACKGROUND",
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

  field(:TALKING_A, 0)
  field(:IDLE_A, 1)
  field(:TALKING_B, 2)
  field(:IDLE_B, 3)
  field(:BACKGROUND, 4)
end

defmodule WAMediaTransport.AudioTransport.Integral.AudioFormat do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAMediaTransport.AudioTransport.Integral.AudioFormat",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "AudioFormat",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "OPUS",
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

  field(:UNKNOWN, 0)
  field(:OPUS, 1)
end

defmodule WAMediaTransport.WAMediaTransport.Ancillary.Thumbnail.DownloadableThumbnail do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.WAMediaTransport.Ancillary.Thumbnail.DownloadableThumbnail",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "DownloadableThumbnail",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "fileSHA256",
          extendee: nil,
          number: 1,
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
          name: "directPath",
          extendee: nil,
          number: 3,
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
          name: "objectID",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "objectID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "thumbnailScansSidecar",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "thumbnailScansSidecar",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "thumbnailScanLengths",
          extendee: nil,
          number: 8,
          label: :LABEL_REPEATED,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "thumbnailScanLengths",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:fileSHA256, 1, optional: true, type: :bytes)
  field(:fileEncSHA256, 2, optional: true, type: :bytes)
  field(:directPath, 3, optional: true, type: :string)
  field(:mediaKey, 4, optional: true, type: :bytes)
  field(:mediaKeyTimestamp, 5, optional: true, type: :int64)
  field(:objectID, 6, optional: true, type: :string)
  field(:thumbnailScansSidecar, 7, optional: true, type: :bytes)
  field(:thumbnailScanLengths, 8, repeated: true, type: :uint32)
end

defmodule WAMediaTransport.WAMediaTransport.Ancillary.Thumbnail do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.WAMediaTransport.Ancillary.Thumbnail",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Thumbnail",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "JPEGThumbnail",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "JPEGThumbnail",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "downloadableThumbnail",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.WAMediaTransport.Ancillary.Thumbnail.DownloadableThumbnail",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "downloadableThumbnail",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "thumbnailWidth",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "thumbnailWidth",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "thumbnailHeight",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "thumbnailHeight",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "DownloadableThumbnail",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "fileSHA256",
              extendee: nil,
              number: 1,
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
              name: "directPath",
              extendee: nil,
              number: 3,
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
              name: "objectID",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "objectID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "thumbnailScansSidecar",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "thumbnailScansSidecar",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "thumbnailScanLengths",
              extendee: nil,
              number: 8,
              label: :LABEL_REPEATED,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "thumbnailScanLengths",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
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

  field(:JPEGThumbnail, 1, optional: true, type: :bytes)

  field(:downloadableThumbnail, 2,
    optional: true,
    type: WAMediaTransport.WAMediaTransport.Ancillary.Thumbnail.DownloadableThumbnail
  )

  field(:thumbnailWidth, 3, optional: true, type: :uint32)
  field(:thumbnailHeight, 4, optional: true, type: :uint32)
end

defmodule WAMediaTransport.WAMediaTransport.Ancillary do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.WAMediaTransport.Ancillary",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Ancillary",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "fileLength",
          extendee: nil,
          number: 1,
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
          name: "mimetype",
          extendee: nil,
          number: 2,
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
          name: "thumbnail",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.WAMediaTransport.Ancillary.Thumbnail",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "thumbnail",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "objectID",
          extendee: nil,
          number: 4,
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
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Thumbnail",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "JPEGThumbnail",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "JPEGThumbnail",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "downloadableThumbnail",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAMediaTransport.WAMediaTransport.Ancillary.Thumbnail.DownloadableThumbnail",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "downloadableThumbnail",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "thumbnailWidth",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "thumbnailWidth",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "thumbnailHeight",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "thumbnailHeight",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "DownloadableThumbnail",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "fileSHA256",
                  extendee: nil,
                  number: 1,
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
                  name: "directPath",
                  extendee: nil,
                  number: 3,
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
                  name: "objectID",
                  extendee: nil,
                  number: 6,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "objectID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "thumbnailScansSidecar",
                  extendee: nil,
                  number: 7,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BYTES,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "thumbnailScansSidecar",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "thumbnailScanLengths",
                  extendee: nil,
                  number: 8,
                  label: :LABEL_REPEATED,
                  type: :TYPE_UINT32,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "thumbnailScanLengths",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
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

  field(:fileLength, 1, optional: true, type: :uint64)
  field(:mimetype, 2, optional: true, type: :string)
  field(:thumbnail, 3, optional: true, type: WAMediaTransport.WAMediaTransport.Ancillary.Thumbnail)
  field(:objectID, 4, optional: true, type: :string)
end

defmodule WAMediaTransport.WAMediaTransport.Integral do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.WAMediaTransport.Integral",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Integral",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "fileSHA256",
          extendee: nil,
          number: 1,
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
          name: "mediaKey",
          extendee: nil,
          number: 2,
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
        }
      ],
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

  field(:fileSHA256, 1, optional: true, type: :bytes)
  field(:mediaKey, 2, optional: true, type: :bytes)
  field(:fileEncSHA256, 3, optional: true, type: :bytes)
  field(:directPath, 4, optional: true, type: :string)
  field(:mediaKeyTimestamp, 5, optional: true, type: :int64)
end

defmodule WAMediaTransport.WAMediaTransport do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.WAMediaTransport",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "WAMediaTransport",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "integral",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.WAMediaTransport.Integral",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "integral",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ancillary",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.WAMediaTransport.Ancillary",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ancillary",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Ancillary",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "fileLength",
              extendee: nil,
              number: 1,
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
              name: "mimetype",
              extendee: nil,
              number: 2,
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
              name: "thumbnail",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMediaTransport.WAMediaTransport.Ancillary.Thumbnail",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "thumbnail",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "objectID",
              extendee: nil,
              number: 4,
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
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "Thumbnail",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "JPEGThumbnail",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BYTES,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "JPEGThumbnail",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "downloadableThumbnail",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAMediaTransport.WAMediaTransport.Ancillary.Thumbnail.DownloadableThumbnail",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "downloadableThumbnail",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "thumbnailWidth",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_UINT32,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "thumbnailWidth",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "thumbnailHeight",
                  extendee: nil,
                  number: 4,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_UINT32,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "thumbnailHeight",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [
                %Google.Protobuf.DescriptorProto{
                  name: "DownloadableThumbnail",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "fileSHA256",
                      extendee: nil,
                      number: 1,
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
                      name: "directPath",
                      extendee: nil,
                      number: 3,
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
                      name: "objectID",
                      extendee: nil,
                      number: 6,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_STRING,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "objectID",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "thumbnailScansSidecar",
                      extendee: nil,
                      number: 7,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_BYTES,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "thumbnailScansSidecar",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "thumbnailScanLengths",
                      extendee: nil,
                      number: 8,
                      label: :LABEL_REPEATED,
                      type: :TYPE_UINT32,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "thumbnailScanLengths",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    }
                  ],
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
          name: "Integral",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "fileSHA256",
              extendee: nil,
              number: 1,
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
              name: "mediaKey",
              extendee: nil,
              number: 2,
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
            }
          ],
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

  field(:integral, 1, optional: true, type: WAMediaTransport.WAMediaTransport.Integral)
  field(:ancillary, 2, optional: true, type: WAMediaTransport.WAMediaTransport.Ancillary)
end

defmodule WAMediaTransport.ImageTransport.Ancillary do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.ImageTransport.Ancillary",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Ancillary",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "height",
          extendee: nil,
          number: 1,
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
          number: 2,
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
          name: "scansSidecar",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "scansSidecar",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "scanLengths",
          extendee: nil,
          number: 4,
          label: :LABEL_REPEATED,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "scanLengths",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "midQualityFileSHA256",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "midQualityFileSHA256",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "hdType",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAMediaTransport.ImageTransport.Ancillary.HdType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "hdType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "memoriesConceptScores",
          extendee: nil,
          number: 7,
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
          json_name: "memoriesConceptScores",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "memoriesConceptIDs",
          extendee: nil,
          number: 8,
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
          json_name: "memoriesConceptIDs",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "HdType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NONE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "LQ_4K",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "HQ_4K",
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

  field(:height, 1, optional: true, type: :uint32)
  field(:width, 2, optional: true, type: :uint32)
  field(:scansSidecar, 3, optional: true, type: :bytes)
  field(:scanLengths, 4, repeated: true, type: :uint32)
  field(:midQualityFileSHA256, 5, optional: true, type: :bytes)

  field(:hdType, 6,
    optional: true,
    type: WAMediaTransport.ImageTransport.Ancillary.HdType,
    enum: true
  )

  field(:memoriesConceptScores, 7, repeated: true, type: :float, packed: true, deprecated: false)
  field(:memoriesConceptIDs, 8, repeated: true, type: :uint32, packed: true, deprecated: false)
end

defmodule WAMediaTransport.ImageTransport.Integral do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.ImageTransport.Integral",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Integral",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "transport",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.WAMediaTransport",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "transport",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:transport, 1, optional: true, type: WAMediaTransport.WAMediaTransport)
end

defmodule WAMediaTransport.ImageTransport do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.ImageTransport",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ImageTransport",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "integral",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.ImageTransport.Integral",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "integral",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ancillary",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.ImageTransport.Ancillary",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ancillary",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Ancillary",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "height",
              extendee: nil,
              number: 1,
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
              number: 2,
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
              name: "scansSidecar",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "scansSidecar",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "scanLengths",
              extendee: nil,
              number: 4,
              label: :LABEL_REPEATED,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "scanLengths",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "midQualityFileSHA256",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "midQualityFileSHA256",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "hdType",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAMediaTransport.ImageTransport.Ancillary.HdType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "hdType",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "memoriesConceptScores",
              extendee: nil,
              number: 7,
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
              json_name: "memoriesConceptScores",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "memoriesConceptIDs",
              extendee: nil,
              number: 8,
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
              json_name: "memoriesConceptIDs",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "HdType",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "NONE",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "LQ_4K",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "HQ_4K",
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
          name: "Integral",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "transport",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMediaTransport.WAMediaTransport",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "transport",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
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

  field(:integral, 1, optional: true, type: WAMediaTransport.ImageTransport.Integral)
  field(:ancillary, 2, optional: true, type: WAMediaTransport.ImageTransport.Ancillary)
end

defmodule WAMediaTransport.VideoTransport.Ancillary do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.VideoTransport.Ancillary",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Ancillary",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "seconds",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "seconds",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "caption",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageText",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "caption",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "gifPlayback",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "gifPlayback",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "height",
          extendee: nil,
          number: 4,
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
          number: 5,
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
          name: "sidecar",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sidecar",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "gifAttribution",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAMediaTransport.VideoTransport.Ancillary.Attribution",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "gifAttribution",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "accessibilityLabel",
          extendee: nil,
          number: 8,
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
          name: "isHd",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isHd",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "Attribution",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NONE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GIPHY",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TENOR",
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

  field(:seconds, 1, optional: true, type: :uint32)
  field(:caption, 2, optional: true, type: WACommon.MessageText)
  field(:gifPlayback, 3, optional: true, type: :bool)
  field(:height, 4, optional: true, type: :uint32)
  field(:width, 5, optional: true, type: :uint32)
  field(:sidecar, 6, optional: true, type: :bytes)

  field(:gifAttribution, 7,
    optional: true,
    type: WAMediaTransport.VideoTransport.Ancillary.Attribution,
    enum: true
  )

  field(:accessibilityLabel, 8, optional: true, type: :string)
  field(:isHd, 9, optional: true, type: :bool)
end

defmodule WAMediaTransport.VideoTransport.Integral do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.VideoTransport.Integral",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Integral",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "transport",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.WAMediaTransport",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "transport",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:transport, 1, optional: true, type: WAMediaTransport.WAMediaTransport)
end

defmodule WAMediaTransport.VideoTransport do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.VideoTransport",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "VideoTransport",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "integral",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.VideoTransport.Integral",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "integral",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ancillary",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.VideoTransport.Ancillary",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ancillary",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Ancillary",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "seconds",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "seconds",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "caption",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.MessageText",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "caption",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "gifPlayback",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "gifPlayback",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "height",
              extendee: nil,
              number: 4,
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
              number: 5,
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
              name: "sidecar",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sidecar",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "gifAttribution",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAMediaTransport.VideoTransport.Ancillary.Attribution",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "gifAttribution",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "accessibilityLabel",
              extendee: nil,
              number: 8,
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
              name: "isHd",
              extendee: nil,
              number: 9,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "isHd",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "Attribution",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "NONE",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "GIPHY",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TENOR",
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
          name: "Integral",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "transport",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMediaTransport.WAMediaTransport",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "transport",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
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

  field(:integral, 1, optional: true, type: WAMediaTransport.VideoTransport.Integral)
  field(:ancillary, 2, optional: true, type: WAMediaTransport.VideoTransport.Ancillary)
end

defmodule WAMediaTransport.AudioTransport.Ancillary.AvatarAudio.DownloadableAvatarAnimations do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.AudioTransport.Ancillary.AvatarAudio.DownloadableAvatarAnimations",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "DownloadableAvatarAnimations",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "fileSHA256",
          extendee: nil,
          number: 1,
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
          name: "directPath",
          extendee: nil,
          number: 3,
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
          name: "objectID",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "objectID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "animationsType",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAMediaTransport.AudioTransport.Ancillary.AvatarAudio.AnimationsType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "animationsType",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:fileSHA256, 1, optional: true, type: :bytes)
  field(:fileEncSHA256, 2, optional: true, type: :bytes)
  field(:directPath, 3, optional: true, type: :string)
  field(:mediaKey, 4, optional: true, type: :bytes)
  field(:mediaKeyTimestamp, 5, optional: true, type: :int64)
  field(:objectID, 6, optional: true, type: :string)

  field(:animationsType, 7,
    optional: true,
    type: WAMediaTransport.AudioTransport.Ancillary.AvatarAudio.AnimationsType,
    enum: true
  )
end

defmodule WAMediaTransport.AudioTransport.Ancillary.AvatarAudio do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.AudioTransport.Ancillary.AvatarAudio",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AvatarAudio",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "poseID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "poseID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "avatarAnimations",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAMediaTransport.AudioTransport.Ancillary.AvatarAudio.DownloadableAvatarAnimations",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "avatarAnimations",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "DownloadableAvatarAnimations",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "fileSHA256",
              extendee: nil,
              number: 1,
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
              name: "directPath",
              extendee: nil,
              number: 3,
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
              name: "objectID",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "objectID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "animationsType",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAMediaTransport.AudioTransport.Ancillary.AvatarAudio.AnimationsType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "animationsType",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
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
          name: "AnimationsType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TALKING_A",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IDLE_A",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TALKING_B",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IDLE_B",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BACKGROUND",
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

  field(:poseID, 1, optional: true, type: :uint32)

  field(:avatarAnimations, 2,
    repeated: true,
    type: WAMediaTransport.AudioTransport.Ancillary.AvatarAudio.DownloadableAvatarAnimations
  )
end

defmodule WAMediaTransport.AudioTransport.Ancillary do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.AudioTransport.Ancillary",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Ancillary",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "seconds",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "seconds",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "avatarAudio",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.AudioTransport.Ancillary.AvatarAudio",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "avatarAudio",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "waveformData",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "waveformData",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "waveform",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "waveform",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "AvatarAudio",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "poseID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "poseID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "avatarAnimations",
              extendee: nil,
              number: 2,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAMediaTransport.AudioTransport.Ancillary.AvatarAudio.DownloadableAvatarAnimations",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "avatarAnimations",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "DownloadableAvatarAnimations",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "fileSHA256",
                  extendee: nil,
                  number: 1,
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
                  name: "directPath",
                  extendee: nil,
                  number: 3,
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
                  name: "objectID",
                  extendee: nil,
                  number: 6,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "objectID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "animationsType",
                  extendee: nil,
                  number: 7,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_ENUM,
                  type_name:
                    ".WAMediaTransport.AudioTransport.Ancillary.AvatarAudio.AnimationsType",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "animationsType",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
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
              name: "AnimationsType",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TALKING_A",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "IDLE_A",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TALKING_B",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "IDLE_B",
                  number: 3,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "BACKGROUND",
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

  field(:seconds, 1, optional: true, type: :uint32)

  field(:avatarAudio, 2,
    optional: true,
    type: WAMediaTransport.AudioTransport.Ancillary.AvatarAudio
  )

  field(:waveformData, 3, optional: true, type: :string)
  field(:waveform, 4, optional: true, type: :bytes)
end

defmodule WAMediaTransport.AudioTransport.Integral do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.AudioTransport.Integral",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Integral",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "transport",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.WAMediaTransport",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "transport",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "audioFormat",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAMediaTransport.AudioTransport.Integral.AudioFormat",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "audioFormat",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "AudioFormat",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "OPUS",
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

  field(:transport, 1, optional: true, type: WAMediaTransport.WAMediaTransport)

  field(:audioFormat, 2,
    optional: true,
    type: WAMediaTransport.AudioTransport.Integral.AudioFormat,
    enum: true
  )
end

defmodule WAMediaTransport.AudioTransport do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.AudioTransport",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AudioTransport",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "integral",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.AudioTransport.Integral",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "integral",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ancillary",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.AudioTransport.Ancillary",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ancillary",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Ancillary",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "seconds",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "seconds",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "avatarAudio",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMediaTransport.AudioTransport.Ancillary.AvatarAudio",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "avatarAudio",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "waveformData",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "waveformData",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "waveform",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "waveform",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "AvatarAudio",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "poseID",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_UINT32,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "poseID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "avatarAnimations",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_REPEATED,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAMediaTransport.AudioTransport.Ancillary.AvatarAudio.DownloadableAvatarAnimations",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "avatarAnimations",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [
                %Google.Protobuf.DescriptorProto{
                  name: "DownloadableAvatarAnimations",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "fileSHA256",
                      extendee: nil,
                      number: 1,
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
                      name: "directPath",
                      extendee: nil,
                      number: 3,
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
                      name: "objectID",
                      extendee: nil,
                      number: 6,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_STRING,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "objectID",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "animationsType",
                      extendee: nil,
                      number: 7,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_ENUM,
                      type_name:
                        ".WAMediaTransport.AudioTransport.Ancillary.AvatarAudio.AnimationsType",
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "animationsType",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    }
                  ],
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
                  name: "AnimationsType",
                  value: [
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "TALKING_A",
                      number: 0,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "IDLE_A",
                      number: 1,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "TALKING_B",
                      number: 2,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "IDLE_B",
                      number: 3,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "BACKGROUND",
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
        },
        %Google.Protobuf.DescriptorProto{
          name: "Integral",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "transport",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMediaTransport.WAMediaTransport",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "transport",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "audioFormat",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAMediaTransport.AudioTransport.Integral.AudioFormat",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "audioFormat",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "AudioFormat",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UNKNOWN",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "OPUS",
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

  field(:integral, 1, optional: true, type: WAMediaTransport.AudioTransport.Integral)
  field(:ancillary, 2, optional: true, type: WAMediaTransport.AudioTransport.Ancillary)
end

defmodule WAMediaTransport.DocumentTransport.Ancillary do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.DocumentTransport.Ancillary",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Ancillary",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "pageCount",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pageCount",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:pageCount, 1, optional: true, type: :uint32)
end

defmodule WAMediaTransport.DocumentTransport.Integral do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.DocumentTransport.Integral",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Integral",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "transport",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.WAMediaTransport",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "transport",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:transport, 1, optional: true, type: WAMediaTransport.WAMediaTransport)
end

defmodule WAMediaTransport.DocumentTransport do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.DocumentTransport",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "DocumentTransport",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "integral",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.DocumentTransport.Integral",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "integral",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ancillary",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.DocumentTransport.Ancillary",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ancillary",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Ancillary",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "pageCount",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "pageCount",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
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
          name: "Integral",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "transport",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMediaTransport.WAMediaTransport",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "transport",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
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

  field(:integral, 1, optional: true, type: WAMediaTransport.DocumentTransport.Integral)
  field(:ancillary, 2, optional: true, type: WAMediaTransport.DocumentTransport.Ancillary)
end

defmodule WAMediaTransport.StickerTransport.Ancillary do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.StickerTransport.Ancillary",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Ancillary",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "pageCount",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pageCount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "height",
          extendee: nil,
          number: 2,
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
          number: 3,
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
          name: "firstFrameLength",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "firstFrameLength",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "firstFrameSidecar",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "firstFrameSidecar",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mustacheText",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mustacheText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isThirdParty",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isThirdParty",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "receiverFetchID",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "receiverFetchID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "accessibilityLabel",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "accessibilityLabel",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:pageCount, 1, optional: true, type: :uint32)
  field(:height, 2, optional: true, type: :uint32)
  field(:width, 3, optional: true, type: :uint32)
  field(:firstFrameLength, 4, optional: true, type: :uint32)
  field(:firstFrameSidecar, 5, optional: true, type: :bytes)
  field(:mustacheText, 6, optional: true, type: :string)
  field(:isThirdParty, 7, optional: true, type: :bool)
  field(:receiverFetchID, 8, optional: true, type: :string)
  field(:accessibilityLabel, 9, optional: true, type: :string)
end

defmodule WAMediaTransport.StickerTransport.Integral do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.StickerTransport.Integral",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Integral",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "transport",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.WAMediaTransport",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "transport",
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
          name: "receiverFetchID",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "receiverFetchID",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:transport, 1, optional: true, type: WAMediaTransport.WAMediaTransport)
  field(:isAnimated, 2, optional: true, type: :bool)
  field(:receiverFetchID, 3, optional: true, type: :string)
end

defmodule WAMediaTransport.StickerTransport do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.StickerTransport",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "StickerTransport",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "integral",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.StickerTransport.Integral",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "integral",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ancillary",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.StickerTransport.Ancillary",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ancillary",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Ancillary",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "pageCount",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "pageCount",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "height",
              extendee: nil,
              number: 2,
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
              number: 3,
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
              name: "firstFrameLength",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "firstFrameLength",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "firstFrameSidecar",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "firstFrameSidecar",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "mustacheText",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "mustacheText",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "isThirdParty",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "isThirdParty",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "receiverFetchID",
              extendee: nil,
              number: 8,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "receiverFetchID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "accessibilityLabel",
              extendee: nil,
              number: 9,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "accessibilityLabel",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
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
          name: "Integral",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "transport",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMediaTransport.WAMediaTransport",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "transport",
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
              name: "receiverFetchID",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "receiverFetchID",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
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

  field(:integral, 1, optional: true, type: WAMediaTransport.StickerTransport.Integral)
  field(:ancillary, 2, optional: true, type: WAMediaTransport.StickerTransport.Ancillary)
end

defmodule WAMediaTransport.ContactTransport.Ancillary do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.ContactTransport.Ancillary",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Ancillary",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "displayName",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "displayName",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
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

  field(:displayName, 1, optional: true, type: :string)
end

defmodule WAMediaTransport.ContactTransport.Integral do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.ContactTransport.Integral",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Integral",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "vcard",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "vcard",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "downloadableVcard",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.WAMediaTransport",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "downloadableVcard",
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
          name: "contact",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:contact, 0)

  field(:vcard, 1, optional: true, type: :string, oneof: 0)
  field(:downloadableVcard, 2, optional: true, type: WAMediaTransport.WAMediaTransport, oneof: 0)
end

defmodule WAMediaTransport.ContactTransport do
  @moduledoc false

  use Protobuf,
    full_name: "WAMediaTransport.ContactTransport",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ContactTransport",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "integral",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.ContactTransport.Integral",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "integral",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ancillary",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAMediaTransport.ContactTransport.Ancillary",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ancillary",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Ancillary",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "displayName",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "displayName",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
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
          name: "Integral",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "vcard",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "vcard",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "downloadableVcard",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAMediaTransport.WAMediaTransport",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "downloadableVcard",
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
              name: "contact",
              options: nil,
              __unknown_fields__: []
            }
          ],
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

  field(:integral, 1, optional: true, type: WAMediaTransport.ContactTransport.Integral)
  field(:ancillary, 2, optional: true, type: WAMediaTransport.ContactTransport.Ancillary)
end
