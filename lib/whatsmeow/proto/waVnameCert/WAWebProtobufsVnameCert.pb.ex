defmodule WAWebProtobufsVnameCert.BizAccountLinkInfo.AccountType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsVnameCert.BizAccountLinkInfo.AccountType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "AccountType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ENTERPRISE",
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

  field(:ENTERPRISE, 0)
end

defmodule WAWebProtobufsVnameCert.BizAccountLinkInfo.HostStorageType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsVnameCert.BizAccountLinkInfo.HostStorageType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "HostStorageType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ON_PREMISE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FACEBOOK",
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

  field(:ON_PREMISE, 0)
  field(:FACEBOOK, 1)
end

defmodule WAWebProtobufsVnameCert.BizIdentityInfo.ActualActorsType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsVnameCert.BizIdentityInfo.ActualActorsType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ActualActorsType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SELF",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BSP",
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

  field(:SELF, 0)
  field(:BSP, 1)
end

defmodule WAWebProtobufsVnameCert.BizIdentityInfo.HostStorageType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsVnameCert.BizIdentityInfo.HostStorageType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "HostStorageType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ON_PREMISE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FACEBOOK",
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

  field(:ON_PREMISE, 0)
  field(:FACEBOOK, 1)
end

defmodule WAWebProtobufsVnameCert.BizIdentityInfo.VerifiedLevelValue do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsVnameCert.BizIdentityInfo.VerifiedLevelValue",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "VerifiedLevelValue",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LOW",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "HIGH",
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
  field(:LOW, 1)
  field(:HIGH, 2)
end

defmodule WAWebProtobufsVnameCert.BizAccountLinkInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsVnameCert.BizAccountLinkInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BizAccountLinkInfo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "whatsappBizAcctFbid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "whatsappBizAcctFbid",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "whatsappAcctNumber",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "whatsappAcctNumber",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "issueTime",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "issueTime",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "hostStorage",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsVnameCert.BizAccountLinkInfo.HostStorageType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "hostStorage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "accountType",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsVnameCert.BizAccountLinkInfo.AccountType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "accountType",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "AccountType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ENTERPRISE",
              number: 0,
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
          name: "HostStorageType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ON_PREMISE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FACEBOOK",
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

  field(:whatsappBizAcctFbid, 1, optional: true, type: :uint64)
  field(:whatsappAcctNumber, 2, optional: true, type: :string)
  field(:issueTime, 3, optional: true, type: :uint64)

  field(:hostStorage, 4,
    optional: true,
    type: WAWebProtobufsVnameCert.BizAccountLinkInfo.HostStorageType,
    enum: true
  )

  field(:accountType, 5,
    optional: true,
    type: WAWebProtobufsVnameCert.BizAccountLinkInfo.AccountType,
    enum: true
  )
end

defmodule WAWebProtobufsVnameCert.BizIdentityInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsVnameCert.BizIdentityInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BizIdentityInfo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "vlevel",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsVnameCert.BizIdentityInfo.VerifiedLevelValue",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "vlevel",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "vnameCert",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsVnameCert.VerifiedNameCertificate",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "vnameCert",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "signed",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "signed",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "revoked",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "revoked",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "hostStorage",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsVnameCert.BizIdentityInfo.HostStorageType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "hostStorage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "actualActors",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsVnameCert.BizIdentityInfo.ActualActorsType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "actualActors",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "privacyModeTS",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "privacyModeTS",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "featureControls",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "featureControls",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "ActualActorsType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SELF",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BSP",
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
          name: "HostStorageType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ON_PREMISE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FACEBOOK",
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
          name: "VerifiedLevelValue",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "LOW",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "HIGH",
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

  field(:vlevel, 1,
    optional: true,
    type: WAWebProtobufsVnameCert.BizIdentityInfo.VerifiedLevelValue,
    enum: true
  )

  field(:vnameCert, 2, optional: true, type: WAWebProtobufsVnameCert.VerifiedNameCertificate)
  field(:signed, 3, optional: true, type: :bool)
  field(:revoked, 4, optional: true, type: :bool)

  field(:hostStorage, 5,
    optional: true,
    type: WAWebProtobufsVnameCert.BizIdentityInfo.HostStorageType,
    enum: true
  )

  field(:actualActors, 6,
    optional: true,
    type: WAWebProtobufsVnameCert.BizIdentityInfo.ActualActorsType,
    enum: true
  )

  field(:privacyModeTS, 7, optional: true, type: :uint64)
  field(:featureControls, 8, optional: true, type: :uint64)
end

defmodule WAWebProtobufsVnameCert.LocalizedName do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsVnameCert.LocalizedName",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "LocalizedName",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "lg",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lg",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lc",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lc",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "verifiedName",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "verifiedName",
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

  field(:lg, 1, optional: true, type: :string)
  field(:lc, 2, optional: true, type: :string)
  field(:verifiedName, 3, optional: true, type: :string)
end

defmodule WAWebProtobufsVnameCert.VerifiedNameCertificate.Details do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsVnameCert.VerifiedNameCertificate.Details",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Details",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "serial",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "serial",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "issuer",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "issuer",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "verifiedName",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "verifiedName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "localizedNames",
          extendee: nil,
          number: 8,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsVnameCert.LocalizedName",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "localizedNames",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "issueTime",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "issueTime",
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

  field(:serial, 1, optional: true, type: :uint64)
  field(:issuer, 2, optional: true, type: :string)
  field(:verifiedName, 4, optional: true, type: :string)
  field(:localizedNames, 8, repeated: true, type: WAWebProtobufsVnameCert.LocalizedName)
  field(:issueTime, 10, optional: true, type: :uint64)
end

defmodule WAWebProtobufsVnameCert.VerifiedNameCertificate do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsVnameCert.VerifiedNameCertificate",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "VerifiedNameCertificate",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "details",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "details",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "signature",
          extendee: nil,
          number: 2,
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
          name: "serverSignature",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "serverSignature",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Details",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "serial",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "serial",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "issuer",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "issuer",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "verifiedName",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "verifiedName",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "localizedNames",
              extendee: nil,
              number: 8,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name: ".WAWebProtobufsVnameCert.LocalizedName",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "localizedNames",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "issueTime",
              extendee: nil,
              number: 10,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "issueTime",
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

  field(:details, 1, optional: true, type: :bytes)
  field(:signature, 2, optional: true, type: :bytes)
  field(:serverSignature, 3, optional: true, type: :bytes)
end

defmodule WAWebProtobufsVnameCert.BizAccountPayload do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsVnameCert.BizAccountPayload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BizAccountPayload",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "vnameCert",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsVnameCert.VerifiedNameCertificate",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "vnameCert",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "bizAcctLinkInfo",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "bizAcctLinkInfo",
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

  field(:vnameCert, 1, optional: true, type: WAWebProtobufsVnameCert.VerifiedNameCertificate)
  field(:bizAcctLinkInfo, 2, optional: true, type: :bytes)
end
