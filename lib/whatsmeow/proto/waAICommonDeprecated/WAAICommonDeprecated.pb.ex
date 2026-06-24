defmodule WAAICommonDeprecated.AIRichResponseMessageType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAAICommonDeprecated.AIRichResponseMessageType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "AIRichResponseMessageType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_TYPE_UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_TYPE_STANDARD",
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

  field(:AI_RICH_RESPONSE_TYPE_UNKNOWN, 0)
  field(:AI_RICH_RESPONSE_TYPE_STANDARD, 1)
end

defmodule WAAICommonDeprecated.AIRichResponseSubMessageType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAAICommonDeprecated.AIRichResponseSubMessageType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "AIRichResponseSubMessageType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_GRID_IMAGE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_TEXT",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_INLINE_IMAGE",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_TABLE",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_CODE",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_DYNAMIC",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_MAP",
          number: 7,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_LATEX",
          number: 8,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_CONTENT_ITEMS",
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

  field(:AI_RICH_RESPONSE_UNKNOWN, 0)
  field(:AI_RICH_RESPONSE_GRID_IMAGE, 1)
  field(:AI_RICH_RESPONSE_TEXT, 2)
  field(:AI_RICH_RESPONSE_INLINE_IMAGE, 3)
  field(:AI_RICH_RESPONSE_TABLE, 4)
  field(:AI_RICH_RESPONSE_CODE, 5)
  field(:AI_RICH_RESPONSE_DYNAMIC, 6)
  field(:AI_RICH_RESPONSE_MAP, 7)
  field(:AI_RICH_RESPONSE_LATEX, 8)
  field(:AI_RICH_RESPONSE_CONTENT_ITEMS, 9)
end

defmodule WAAICommonDeprecated.AIRichResponseInlineImageMetadata.AIRichResponseImageAlignment do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name:
      "WAAICommonDeprecated.AIRichResponseInlineImageMetadata.AIRichResponseImageAlignment",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "AIRichResponseImageAlignment",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_IMAGE_LAYOUT_LEADING_ALIGNED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_IMAGE_LAYOUT_TRAILING_ALIGNED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_IMAGE_LAYOUT_CENTER_ALIGNED",
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

  field(:AI_RICH_RESPONSE_IMAGE_LAYOUT_LEADING_ALIGNED, 0)
  field(:AI_RICH_RESPONSE_IMAGE_LAYOUT_TRAILING_ALIGNED, 1)
  field(:AI_RICH_RESPONSE_IMAGE_LAYOUT_CENTER_ALIGNED, 2)
end

defmodule WAAICommonDeprecated.AIRichResponseCodeMetadata.AIRichResponseCodeHighlightType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAAICommonDeprecated.AIRichResponseCodeMetadata.AIRichResponseCodeHighlightType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "AIRichResponseCodeHighlightType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_CODE_HIGHLIGHT_DEFAULT",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_CODE_HIGHLIGHT_KEYWORD",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_CODE_HIGHLIGHT_METHOD",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_CODE_HIGHLIGHT_STRING",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_CODE_HIGHLIGHT_NUMBER",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_CODE_HIGHLIGHT_COMMENT",
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

  field(:AI_RICH_RESPONSE_CODE_HIGHLIGHT_DEFAULT, 0)
  field(:AI_RICH_RESPONSE_CODE_HIGHLIGHT_KEYWORD, 1)
  field(:AI_RICH_RESPONSE_CODE_HIGHLIGHT_METHOD, 2)
  field(:AI_RICH_RESPONSE_CODE_HIGHLIGHT_STRING, 3)
  field(:AI_RICH_RESPONSE_CODE_HIGHLIGHT_NUMBER, 4)
  field(:AI_RICH_RESPONSE_CODE_HIGHLIGHT_COMMENT, 5)
end

defmodule WAAICommonDeprecated.AIRichResponseDynamicMetadata.AIRichResponseDynamicMetadataType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name:
      "WAAICommonDeprecated.AIRichResponseDynamicMetadata.AIRichResponseDynamicMetadataType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "AIRichResponseDynamicMetadataType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_DYNAMIC_METADATA_TYPE_UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_DYNAMIC_METADATA_TYPE_IMAGE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AI_RICH_RESPONSE_DYNAMIC_METADATA_TYPE_GIF",
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

  field(:AI_RICH_RESPONSE_DYNAMIC_METADATA_TYPE_UNKNOWN, 0)
  field(:AI_RICH_RESPONSE_DYNAMIC_METADATA_TYPE_IMAGE, 1)
  field(:AI_RICH_RESPONSE_DYNAMIC_METADATA_TYPE_GIF, 2)
end

defmodule WAAICommonDeprecated.AIRichResponseContentItemsMetadata.ContentType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAAICommonDeprecated.AIRichResponseContentItemsMetadata.ContentType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ContentType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DEFAULT",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CAROUSEL",
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

  field(:DEFAULT, 0)
  field(:CAROUSEL, 1)
end

defmodule WAAICommonDeprecated.AIRichResponseInlineImageMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAAICommonDeprecated.AIRichResponseInlineImageMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRichResponseInlineImageMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "imageURL",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAAICommonDeprecated.AIRichResponseImageURL",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imageURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "imageText",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imageText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "alignment",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAAICommonDeprecated.AIRichResponseInlineImageMetadata.AIRichResponseImageAlignment",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "alignment",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "tapLinkURL",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "tapLinkURL",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "AIRichResponseImageAlignment",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_RICH_RESPONSE_IMAGE_LAYOUT_LEADING_ALIGNED",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_RICH_RESPONSE_IMAGE_LAYOUT_TRAILING_ALIGNED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_RICH_RESPONSE_IMAGE_LAYOUT_CENTER_ALIGNED",
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

  field(:imageURL, 1, optional: true, type: WAAICommonDeprecated.AIRichResponseImageURL)
  field(:imageText, 2, optional: true, type: :string)

  field(:alignment, 3,
    optional: true,
    type: WAAICommonDeprecated.AIRichResponseInlineImageMetadata.AIRichResponseImageAlignment,
    enum: true
  )

  field(:tapLinkURL, 4, optional: true, type: :string)
end

defmodule WAAICommonDeprecated.AIRichResponseCodeMetadata.AIRichResponseCodeBlock do
  @moduledoc false

  use Protobuf,
    full_name: "WAAICommonDeprecated.AIRichResponseCodeMetadata.AIRichResponseCodeBlock",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRichResponseCodeBlock",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "highlightType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAAICommonDeprecated.AIRichResponseCodeMetadata.AIRichResponseCodeHighlightType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "highlightType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "codeContent",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "codeContent",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
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

  field(:highlightType, 1,
    optional: true,
    type: WAAICommonDeprecated.AIRichResponseCodeMetadata.AIRichResponseCodeHighlightType,
    enum: true
  )

  field(:codeContent, 2, optional: true, type: :string)
end

defmodule WAAICommonDeprecated.AIRichResponseCodeMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAAICommonDeprecated.AIRichResponseCodeMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRichResponseCodeMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "codeLanguage",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "codeLanguage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "codeBlocks",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAAICommonDeprecated.AIRichResponseCodeMetadata.AIRichResponseCodeBlock",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "codeBlocks",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "AIRichResponseCodeBlock",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "highlightType",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAAICommonDeprecated.AIRichResponseCodeMetadata.AIRichResponseCodeHighlightType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "highlightType",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "codeContent",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "codeContent",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
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
          name: "AIRichResponseCodeHighlightType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_RICH_RESPONSE_CODE_HIGHLIGHT_DEFAULT",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_RICH_RESPONSE_CODE_HIGHLIGHT_KEYWORD",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_RICH_RESPONSE_CODE_HIGHLIGHT_METHOD",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_RICH_RESPONSE_CODE_HIGHLIGHT_STRING",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_RICH_RESPONSE_CODE_HIGHLIGHT_NUMBER",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_RICH_RESPONSE_CODE_HIGHLIGHT_COMMENT",
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

  field(:codeLanguage, 1, optional: true, type: :string)

  field(:codeBlocks, 2,
    repeated: true,
    type: WAAICommonDeprecated.AIRichResponseCodeMetadata.AIRichResponseCodeBlock
  )
end

defmodule WAAICommonDeprecated.AIRichResponseDynamicMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAAICommonDeprecated.AIRichResponseDynamicMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRichResponseDynamicMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "type",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAAICommonDeprecated.AIRichResponseDynamicMetadata.AIRichResponseDynamicMetadataType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "type",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "version",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "version",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "URL",
          extendee: nil,
          number: 3,
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
          name: "loopCount",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "loopCount",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "AIRichResponseDynamicMetadataType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_RICH_RESPONSE_DYNAMIC_METADATA_TYPE_UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_RICH_RESPONSE_DYNAMIC_METADATA_TYPE_IMAGE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AI_RICH_RESPONSE_DYNAMIC_METADATA_TYPE_GIF",
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
    type: WAAICommonDeprecated.AIRichResponseDynamicMetadata.AIRichResponseDynamicMetadataType,
    enum: true
  )

  field(:version, 2, optional: true, type: :uint64)
  field(:URL, 3, optional: true, type: :string)
  field(:loopCount, 4, optional: true, type: :uint32)
end

defmodule WAAICommonDeprecated.AIRichResponseContentItemsMetadata.AIRichResponseContentItemMetadata do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAAICommonDeprecated.AIRichResponseContentItemsMetadata.AIRichResponseContentItemMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRichResponseContentItemMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "reelItem",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAAICommonDeprecated.AIRichResponseContentItemsMetadata.AIRichResponseReelItem",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "reelItem",
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
          name: "aIRichResponseContentItem",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:aIRichResponseContentItem, 0)

  field(:reelItem, 1,
    optional: true,
    type: WAAICommonDeprecated.AIRichResponseContentItemsMetadata.AIRichResponseReelItem,
    oneof: 0
  )
end

defmodule WAAICommonDeprecated.AIRichResponseContentItemsMetadata.AIRichResponseReelItem do
  @moduledoc false

  use Protobuf,
    full_name: "WAAICommonDeprecated.AIRichResponseContentItemsMetadata.AIRichResponseReelItem",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRichResponseReelItem",
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
          name: "profileIconURL",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "profileIconURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "thumbnailURL",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "thumbnailURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "videoURL",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "videoURL",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
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
  field(:profileIconURL, 2, optional: true, type: :string)
  field(:thumbnailURL, 3, optional: true, type: :string)
  field(:videoURL, 4, optional: true, type: :string)
end

defmodule WAAICommonDeprecated.AIRichResponseContentItemsMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAAICommonDeprecated.AIRichResponseContentItemsMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRichResponseContentItemsMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "itemsMetadata",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAAICommonDeprecated.AIRichResponseContentItemsMetadata.AIRichResponseContentItemMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "itemsMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "contentType",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAAICommonDeprecated.AIRichResponseContentItemsMetadata.ContentType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "contentType",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "AIRichResponseContentItemMetadata",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "reelItem",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAAICommonDeprecated.AIRichResponseContentItemsMetadata.AIRichResponseReelItem",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "reelItem",
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
              name: "aIRichResponseContentItem",
              options: nil,
              __unknown_fields__: []
            }
          ],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "AIRichResponseReelItem",
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
              name: "profileIconURL",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "profileIconURL",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "thumbnailURL",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "thumbnailURL",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "videoURL",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "videoURL",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
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
          name: "ContentType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DEFAULT",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CAROUSEL",
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

  field(:itemsMetadata, 1,
    repeated: true,
    type: WAAICommonDeprecated.AIRichResponseContentItemsMetadata.AIRichResponseContentItemMetadata
  )

  field(:contentType, 2,
    optional: true,
    type: WAAICommonDeprecated.AIRichResponseContentItemsMetadata.ContentType,
    enum: true
  )
end

defmodule WAAICommonDeprecated.AIRichResponseImageURL do
  @moduledoc false

  use Protobuf,
    full_name: "WAAICommonDeprecated.AIRichResponseImageURL",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRichResponseImageURL",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "imagePreviewURL",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imagePreviewURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "imageHighResURL",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imageHighResURL",
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

  field(:imagePreviewURL, 1, optional: true, type: :string)
  field(:imageHighResURL, 2, optional: true, type: :string)
  field(:sourceURL, 3, optional: true, type: :string)
end

defmodule WAAICommonDeprecated.AIRichResponseGridImageMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAAICommonDeprecated.AIRichResponseGridImageMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRichResponseGridImageMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "gridImageURL",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAAICommonDeprecated.AIRichResponseImageURL",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "gridImageURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "imageURLs",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAAICommonDeprecated.AIRichResponseImageURL",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imageURLs",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
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

  field(:gridImageURL, 1, optional: true, type: WAAICommonDeprecated.AIRichResponseImageURL)
  field(:imageURLs, 2, repeated: true, type: WAAICommonDeprecated.AIRichResponseImageURL)
end

defmodule WAAICommonDeprecated.AIRichResponseTableMetadata.AIRichResponseTableRow do
  @moduledoc false

  use Protobuf,
    full_name: "WAAICommonDeprecated.AIRichResponseTableMetadata.AIRichResponseTableRow",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRichResponseTableRow",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "items",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "items",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isHeading",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isHeading",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
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

  field(:items, 1, repeated: true, type: :string)
  field(:isHeading, 2, optional: true, type: :bool)
end

defmodule WAAICommonDeprecated.AIRichResponseTableMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAAICommonDeprecated.AIRichResponseTableMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRichResponseTableMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "rows",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAAICommonDeprecated.AIRichResponseTableMetadata.AIRichResponseTableRow",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "rows",
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
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "AIRichResponseTableRow",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "items",
              extendee: nil,
              number: 1,
              label: :LABEL_REPEATED,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "items",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "isHeading",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "isHeading",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
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

  field(:rows, 1,
    repeated: true,
    type: WAAICommonDeprecated.AIRichResponseTableMetadata.AIRichResponseTableRow
  )

  field(:title, 2, optional: true, type: :string)
end

defmodule WAAICommonDeprecated.AIRichResponseLatexMetadata.AIRichResponseLatexExpression do
  @moduledoc false

  use Protobuf,
    full_name: "WAAICommonDeprecated.AIRichResponseLatexMetadata.AIRichResponseLatexExpression",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRichResponseLatexExpression",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "latexExpression",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "latexExpression",
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
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "width",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "width",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "height",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "height",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fontHeight",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fontHeight",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "imageTopPadding",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imageTopPadding",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "imageLeadingPadding",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imageLeadingPadding",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "imageBottomPadding",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imageBottomPadding",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "imageTrailingPadding",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imageTrailingPadding",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
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

  field(:latexExpression, 1, optional: true, type: :string)
  field(:URL, 2, optional: true, type: :string)
  field(:width, 3, optional: true, type: :double)
  field(:height, 4, optional: true, type: :double)
  field(:fontHeight, 5, optional: true, type: :double)
  field(:imageTopPadding, 6, optional: true, type: :double)
  field(:imageLeadingPadding, 7, optional: true, type: :double)
  field(:imageBottomPadding, 8, optional: true, type: :double)
  field(:imageTrailingPadding, 9, optional: true, type: :double)
end

defmodule WAAICommonDeprecated.AIRichResponseLatexMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAAICommonDeprecated.AIRichResponseLatexMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRichResponseLatexMetadata",
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
          name: "expressions",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAAICommonDeprecated.AIRichResponseLatexMetadata.AIRichResponseLatexExpression",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "expressions",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "AIRichResponseLatexExpression",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "latexExpression",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "latexExpression",
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
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "width",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_DOUBLE,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "width",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "height",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_DOUBLE,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "height",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "fontHeight",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_DOUBLE,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "fontHeight",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "imageTopPadding",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_DOUBLE,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "imageTopPadding",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "imageLeadingPadding",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_DOUBLE,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "imageLeadingPadding",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "imageBottomPadding",
              extendee: nil,
              number: 8,
              label: :LABEL_OPTIONAL,
              type: :TYPE_DOUBLE,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "imageBottomPadding",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "imageTrailingPadding",
              extendee: nil,
              number: 9,
              label: :LABEL_OPTIONAL,
              type: :TYPE_DOUBLE,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "imageTrailingPadding",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
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

  field(:text, 1, optional: true, type: :string)

  field(:expressions, 2,
    repeated: true,
    type: WAAICommonDeprecated.AIRichResponseLatexMetadata.AIRichResponseLatexExpression
  )
end

defmodule WAAICommonDeprecated.AIRichResponseMapMetadata.AIRichResponseMapAnnotation do
  @moduledoc false

  use Protobuf,
    full_name: "WAAICommonDeprecated.AIRichResponseMapMetadata.AIRichResponseMapAnnotation",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRichResponseMapAnnotation",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "annotationNumber",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "annotationNumber",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "latitude",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "latitude",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "longitude",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "longitude",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "title",
          extendee: nil,
          number: 4,
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
          name: "body",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "body",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
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

  field(:annotationNumber, 1, optional: true, type: :uint32)
  field(:latitude, 2, optional: true, type: :double)
  field(:longitude, 3, optional: true, type: :double)
  field(:title, 4, optional: true, type: :string)
  field(:body, 5, optional: true, type: :string)
end

defmodule WAAICommonDeprecated.AIRichResponseMapMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAAICommonDeprecated.AIRichResponseMapMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRichResponseMapMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "centerLatitude",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "centerLatitude",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "centerLongitude",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "centerLongitude",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "latitudeDelta",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "latitudeDelta",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "longitudeDelta",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_DOUBLE,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "longitudeDelta",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "annotations",
          extendee: nil,
          number: 5,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAAICommonDeprecated.AIRichResponseMapMetadata.AIRichResponseMapAnnotation",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "annotations",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "showInfoList",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "showInfoList",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "AIRichResponseMapAnnotation",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "annotationNumber",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "annotationNumber",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "latitude",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_DOUBLE,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "latitude",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "longitude",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_DOUBLE,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "longitude",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "title",
              extendee: nil,
              number: 4,
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
              name: "body",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "body",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
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

  field(:centerLatitude, 1, optional: true, type: :double)
  field(:centerLongitude, 2, optional: true, type: :double)
  field(:latitudeDelta, 3, optional: true, type: :double)
  field(:longitudeDelta, 4, optional: true, type: :double)

  field(:annotations, 5,
    repeated: true,
    type: WAAICommonDeprecated.AIRichResponseMapMetadata.AIRichResponseMapAnnotation
  )

  field(:showInfoList, 6, optional: true, type: :bool)
end

defmodule WAAICommonDeprecated.AIRichResponseSubMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAAICommonDeprecated.AIRichResponseSubMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIRichResponseSubMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAAICommonDeprecated.AIRichResponseSubMessageType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "gridImageMetadata",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAAICommonDeprecated.AIRichResponseGridImageMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "gridImageMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageText",
          extendee: nil,
          number: 3,
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
          name: "imageMetadata",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAAICommonDeprecated.AIRichResponseInlineImageMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imageMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "codeMetadata",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAAICommonDeprecated.AIRichResponseCodeMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "codeMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "tableMetadata",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAAICommonDeprecated.AIRichResponseTableMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "tableMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "dynamicMetadata",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAAICommonDeprecated.AIRichResponseDynamicMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "dynamicMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "latexMetadata",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAAICommonDeprecated.AIRichResponseLatexMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "latexMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mapMetadata",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAAICommonDeprecated.AIRichResponseMapMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mapMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "contentItemsMetadata",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAAICommonDeprecated.AIRichResponseContentItemsMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "contentItemsMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
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

  field(:messageType, 1,
    optional: true,
    type: WAAICommonDeprecated.AIRichResponseSubMessageType,
    enum: true
  )

  field(:gridImageMetadata, 2,
    optional: true,
    type: WAAICommonDeprecated.AIRichResponseGridImageMetadata
  )

  field(:messageText, 3, optional: true, type: :string)

  field(:imageMetadata, 4,
    optional: true,
    type: WAAICommonDeprecated.AIRichResponseInlineImageMetadata
  )

  field(:codeMetadata, 5, optional: true, type: WAAICommonDeprecated.AIRichResponseCodeMetadata)
  field(:tableMetadata, 6, optional: true, type: WAAICommonDeprecated.AIRichResponseTableMetadata)

  field(:dynamicMetadata, 7,
    optional: true,
    type: WAAICommonDeprecated.AIRichResponseDynamicMetadata
  )

  field(:latexMetadata, 8, optional: true, type: WAAICommonDeprecated.AIRichResponseLatexMetadata)
  field(:mapMetadata, 9, optional: true, type: WAAICommonDeprecated.AIRichResponseMapMetadata)

  field(:contentItemsMetadata, 10,
    optional: true,
    type: WAAICommonDeprecated.AIRichResponseContentItemsMetadata
  )
end
