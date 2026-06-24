defmodule WAWebProtobufsUserPassword.UserPassword.Transformer do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsUserPassword.UserPassword.Transformer",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Transformer",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NONE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PBKDF2_HMAC_SHA512",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PBKDF2_HMAC_SHA384",
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
  field(:PBKDF2_HMAC_SHA512, 1)
  field(:PBKDF2_HMAC_SHA384, 2)
end

defmodule WAWebProtobufsUserPassword.UserPassword.Encoding do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsUserPassword.UserPassword.Encoding",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Encoding",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UTF8",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UTF8_BROKEN",
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

  field(:UTF8, 0)
  field(:UTF8_BROKEN, 1)
end

defmodule WAWebProtobufsUserPassword.UserPassword.TransformerArg.Value do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsUserPassword.UserPassword.TransformerArg.Value",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Value",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "asBlob",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "asBlob",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "asUnsignedInteger",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "asUnsignedInteger",
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
        %Google.Protobuf.OneofDescriptorProto{name: "value", options: nil, __unknown_fields__: []}
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:value, 0)

  field(:asBlob, 1, optional: true, type: :bytes, oneof: 0)
  field(:asUnsignedInteger, 2, optional: true, type: :uint32, oneof: 0)
end

defmodule WAWebProtobufsUserPassword.UserPassword.TransformerArg do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsUserPassword.UserPassword.TransformerArg",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "TransformerArg",
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
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsUserPassword.UserPassword.TransformerArg.Value",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "value",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Value",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "asBlob",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "asBlob",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "asUnsignedInteger",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "asUnsignedInteger",
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
              name: "value",
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

  field(:key, 1, optional: true, type: :string)

  field(:value, 2,
    optional: true,
    type: WAWebProtobufsUserPassword.UserPassword.TransformerArg.Value
  )
end

defmodule WAWebProtobufsUserPassword.UserPassword do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsUserPassword.UserPassword",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "UserPassword",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "encoding",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsUserPassword.UserPassword.Encoding",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "encoding",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "transformer",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsUserPassword.UserPassword.Transformer",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "transformer",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "transformerArg",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsUserPassword.UserPassword.TransformerArg",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "transformerArg",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "transformedData",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "transformedData",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "TransformerArg",
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
              type: :TYPE_MESSAGE,
              type_name: ".WAWebProtobufsUserPassword.UserPassword.TransformerArg.Value",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "value",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "Value",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "asBlob",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BYTES,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: 0,
                  json_name: "asBlob",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "asUnsignedInteger",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_UINT32,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: 0,
                  json_name: "asUnsignedInteger",
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
                  name: "value",
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
      ],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "Transformer",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NONE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PBKDF2_HMAC_SHA512",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PBKDF2_HMAC_SHA384",
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
          name: "Encoding",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UTF8",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UTF8_BROKEN",
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

  field(:encoding, 1,
    optional: true,
    type: WAWebProtobufsUserPassword.UserPassword.Encoding,
    enum: true
  )

  field(:transformer, 2,
    optional: true,
    type: WAWebProtobufsUserPassword.UserPassword.Transformer,
    enum: true
  )

  field(:transformerArg, 3,
    repeated: true,
    type: WAWebProtobufsUserPassword.UserPassword.TransformerArg
  )

  field(:transformedData, 4, optional: true, type: :bytes)
end
