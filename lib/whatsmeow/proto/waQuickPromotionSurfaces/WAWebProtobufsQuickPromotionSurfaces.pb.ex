defmodule WAWebProtobufsQuickPromotionSurfaces.QP.FilterResult do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsQuickPromotionSurfaces.QP.FilterResult",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "FilterResult",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TRUE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FALSE",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN",
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

  field(:TRUE, 1)
  field(:FALSE, 2)
  field(:UNKNOWN, 3)
end

defmodule WAWebProtobufsQuickPromotionSurfaces.QP.FilterClientNotSupportedConfig do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsQuickPromotionSurfaces.QP.FilterClientNotSupportedConfig",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "FilterClientNotSupportedConfig",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PASS_BY_DEFAULT",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FAIL_BY_DEFAULT",
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

  field(:PASS_BY_DEFAULT, 1)
  field(:FAIL_BY_DEFAULT, 2)
end

defmodule WAWebProtobufsQuickPromotionSurfaces.QP.ClauseType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsQuickPromotionSurfaces.QP.ClauseType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ClauseType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AND",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "OR",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NOR",
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

  field(:AND, 1)
  field(:OR, 2)
  field(:NOR, 3)
end

defmodule WAWebProtobufsQuickPromotionSurfaces.QP.FilterClause do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsQuickPromotionSurfaces.QP.FilterClause",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "FilterClause",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "clauseType",
          extendee: nil,
          number: 1,
          label: :LABEL_REQUIRED,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsQuickPromotionSurfaces.QP.ClauseType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "clauseType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "clauses",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsQuickPromotionSurfaces.QP.FilterClause",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "clauses",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "filters",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsQuickPromotionSurfaces.QP.Filter",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "filters",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
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

  field(:clauseType, 1,
    required: true,
    type: WAWebProtobufsQuickPromotionSurfaces.QP.ClauseType,
    enum: true
  )

  field(:clauses, 2, repeated: true, type: WAWebProtobufsQuickPromotionSurfaces.QP.FilterClause)
  field(:filters, 3, repeated: true, type: WAWebProtobufsQuickPromotionSurfaces.QP.Filter)
end

defmodule WAWebProtobufsQuickPromotionSurfaces.QP.Filter do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsQuickPromotionSurfaces.QP.Filter",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Filter",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "filterName",
          extendee: nil,
          number: 1,
          label: :LABEL_REQUIRED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "filterName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "parameters",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsQuickPromotionSurfaces.QP.FilterParameters",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "parameters",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "filterResult",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsQuickPromotionSurfaces.QP.FilterResult",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "filterResult",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "clientNotSupportedConfig",
          extendee: nil,
          number: 4,
          label: :LABEL_REQUIRED,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsQuickPromotionSurfaces.QP.FilterClientNotSupportedConfig",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "clientNotSupportedConfig",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
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

  field(:filterName, 1, required: true, type: :string)

  field(:parameters, 2,
    repeated: true,
    type: WAWebProtobufsQuickPromotionSurfaces.QP.FilterParameters
  )

  field(:filterResult, 3,
    optional: true,
    type: WAWebProtobufsQuickPromotionSurfaces.QP.FilterResult,
    enum: true
  )

  field(:clientNotSupportedConfig, 4,
    required: true,
    type: WAWebProtobufsQuickPromotionSurfaces.QP.FilterClientNotSupportedConfig,
    enum: true
  )
end

defmodule WAWebProtobufsQuickPromotionSurfaces.QP.FilterParameters do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsQuickPromotionSurfaces.QP.FilterParameters",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "FilterParameters",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "key",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
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

  field(:key, 1, optional: true, type: :string)
  field(:value, 2, optional: true, type: :string)
end

defmodule WAWebProtobufsQuickPromotionSurfaces.QP do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsQuickPromotionSurfaces.QP",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "QP",
      field: [],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "FilterClause",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "clauseType",
              extendee: nil,
              number: 1,
              label: :LABEL_REQUIRED,
              type: :TYPE_ENUM,
              type_name: ".WAWebProtobufsQuickPromotionSurfaces.QP.ClauseType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "clauseType",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "clauses",
              extendee: nil,
              number: 2,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name: ".WAWebProtobufsQuickPromotionSurfaces.QP.FilterClause",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "clauses",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "filters",
              extendee: nil,
              number: 3,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name: ".WAWebProtobufsQuickPromotionSurfaces.QP.Filter",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "filters",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
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
          name: "Filter",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "filterName",
              extendee: nil,
              number: 1,
              label: :LABEL_REQUIRED,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "filterName",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "parameters",
              extendee: nil,
              number: 2,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name: ".WAWebProtobufsQuickPromotionSurfaces.QP.FilterParameters",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "parameters",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "filterResult",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAWebProtobufsQuickPromotionSurfaces.QP.FilterResult",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "filterResult",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "clientNotSupportedConfig",
              extendee: nil,
              number: 4,
              label: :LABEL_REQUIRED,
              type: :TYPE_ENUM,
              type_name: ".WAWebProtobufsQuickPromotionSurfaces.QP.FilterClientNotSupportedConfig",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "clientNotSupportedConfig",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
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
          name: "FilterParameters",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "key",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
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
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "FilterResult",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TRUE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FALSE",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN",
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
          name: "FilterClientNotSupportedConfig",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PASS_BY_DEFAULT",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FAIL_BY_DEFAULT",
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
          name: "ClauseType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AND",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "OR",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NOR",
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
end
