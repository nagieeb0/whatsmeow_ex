defmodule WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets.Epoch.EpochStatus do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets.Epoch.EpochStatus",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "EpochStatus",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ES_OPEN",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ES_CLOSE",
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

  field(:ES_OPEN, 1)
  field(:ES_CLOSE, 2)
end

defmodule WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncAttachmentInterventionAction.InterventionType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name:
      "WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncAttachmentInterventionAction.InterventionType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "InterventionType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NUDE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NOT_NUDE",
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
  field(:NUDE, 1)
  field(:NOT_NUDE, 2)
end

defmodule WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncSpectraAction.SpectraActionType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name:
      "WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncSpectraAction.SpectraActionType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "SpectraActionType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TAKEDOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RESTORE",
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

  field(:TAKEDOWN, 0)
  field(:RESTORE, 1)
end

defmodule WAArmadilloApplication.Armadillo.Content.PaymentsTransactionMessage.PaymentStatus do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAArmadilloApplication.Armadillo.Content.PaymentsTransactionMessage.PaymentStatus",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "PaymentStatus",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REQUEST_INITED",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REQUEST_DECLINED",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REQUEST_TRANSFER_INITED",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REQUEST_TRANSFER_COMPLETED",
          number: 7,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REQUEST_TRANSFER_FAILED",
          number: 8,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REQUEST_CANCELED",
          number: 9,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REQUEST_EXPIRED",
          number: 10,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TRANSFER_INITED",
          number: 11,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TRANSFER_PENDING",
          number: 12,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TRANSFER_PENDING_RECIPIENT_VERIFICATION",
          number: 13,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TRANSFER_CANCELED",
          number: 14,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TRANSFER_COMPLETED",
          number: 15,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TRANSFER_NO_RECEIVER_CREDENTIAL_NO_RTS_PENDING_CANCELED",
          number: 16,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TRANSFER_NO_RECEIVER_CREDENTIAL_NO_RTS_PENDING_OTHER",
          number: 17,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TRANSFER_REFUNDED",
          number: 18,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TRANSFER_PARTIAL_REFUND",
          number: 19,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TRANSFER_CHARGED_BACK",
          number: 20,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TRANSFER_EXPIRED",
          number: 21,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TRANSFER_DECLINED",
          number: 22,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TRANSFER_UNAVAILABLE",
          number: 23,
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

  field(:PAYMENT_UNKNOWN, 0)
  field(:REQUEST_INITED, 4)
  field(:REQUEST_DECLINED, 5)
  field(:REQUEST_TRANSFER_INITED, 6)
  field(:REQUEST_TRANSFER_COMPLETED, 7)
  field(:REQUEST_TRANSFER_FAILED, 8)
  field(:REQUEST_CANCELED, 9)
  field(:REQUEST_EXPIRED, 10)
  field(:TRANSFER_INITED, 11)
  field(:TRANSFER_PENDING, 12)
  field(:TRANSFER_PENDING_RECIPIENT_VERIFICATION, 13)
  field(:TRANSFER_CANCELED, 14)
  field(:TRANSFER_COMPLETED, 15)
  field(:TRANSFER_NO_RECEIVER_CREDENTIAL_NO_RTS_PENDING_CANCELED, 16)
  field(:TRANSFER_NO_RECEIVER_CREDENTIAL_NO_RTS_PENDING_OTHER, 17)
  field(:TRANSFER_REFUNDED, 18)
  field(:TRANSFER_PARTIAL_REFUND, 19)
  field(:TRANSFER_CHARGED_BACK, 20)
  field(:TRANSFER_EXPIRED, 21)
  field(:TRANSFER_DECLINED, 22)
  field(:TRANSFER_UNAVAILABLE, 23)
end

defmodule WAArmadilloApplication.Armadillo.Content.ScreenshotAction.ScreenshotType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAArmadilloApplication.Armadillo.Content.ScreenshotAction.ScreenshotType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ScreenshotType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SCREENSHOT_IMAGE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SCREEN_RECORDING",
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

  field(:SCREENSHOT_IMAGE, 1)
  field(:SCREEN_RECORDING, 2)
end

defmodule WAArmadilloApplication.Armadillo.Content.RavenActionNotifMessage.ActionType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAArmadilloApplication.Armadillo.Content.RavenActionNotifMessage.ActionType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ActionType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PLAYED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SCREENSHOT",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FORCE_DISABLE",
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

  field(:PLAYED, 0)
  field(:SCREENSHOT, 1)
  field(:FORCE_DISABLE, 2)
end

defmodule WAArmadilloApplication.Armadillo.Content.RavenMessage.EphemeralType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAArmadilloApplication.Armadillo.Content.RavenMessage.EphemeralType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "EphemeralType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VIEW_ONCE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ALLOW_REPLAY",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "KEEP_IN_CHAT",
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

  field(:VIEW_ONCE, 0)
  field(:ALLOW_REPLAY, 1)
  field(:KEEP_IN_CHAT, 2)
end

defmodule WAArmadilloApplication.Armadillo.Content.CommonSticker.StickerType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAArmadilloApplication.Armadillo.Content.CommonSticker.StickerType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "StickerType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SMALL_LIKE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MEDIUM_LIKE",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LARGE_LIKE",
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

  field(:SMALL_LIKE, 1)
  field(:MEDIUM_LIKE, 2)
  field(:LARGE_LIKE, 3)
end

defmodule WAArmadilloApplication.Armadillo.Metadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.Metadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Metadata",
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

defmodule WAArmadilloApplication.Armadillo.Payload do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.Payload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Payload",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "content",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.Content",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "content",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "applicationData",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.ApplicationData",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "applicationData",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "signal",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.Signal",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "signal",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "subProtocol",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.SubProtocolPayload",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "subProtocol",
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
          name: "payload",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:payload, 0)

  field(:content, 1, optional: true, type: WAArmadilloApplication.Armadillo.Content, oneof: 0)

  field(:applicationData, 2,
    optional: true,
    type: WAArmadilloApplication.Armadillo.ApplicationData,
    oneof: 0
  )

  field(:signal, 3, optional: true, type: WAArmadilloApplication.Armadillo.Signal, oneof: 0)

  field(:subProtocol, 4,
    optional: true,
    type: WAArmadilloApplication.Armadillo.SubProtocolPayload,
    oneof: 0
  )
end

defmodule WAArmadilloApplication.Armadillo.SubProtocolPayload do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.SubProtocolPayload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SubProtocolPayload",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "futureProof",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WACommon.FutureProofBehavior",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "futureProof",
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

  field(:futureProof, 1, optional: true, type: WACommon.FutureProofBehavior, enum: true)
end

defmodule WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets.Epoch do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets.Epoch",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Epoch",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "ID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "anonID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "anonID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "rootKey",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "rootKey",
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
            ".WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets.Epoch.EpochStatus",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "status",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "EpochStatus",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ES_OPEN",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ES_CLOSE",
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

  field(:ID, 1, optional: true, type: :uint64)
  field(:anonID, 2, optional: true, type: :bytes)
  field(:rootKey, 3, optional: true, type: :bytes)

  field(:status, 4,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets.Epoch.EpochStatus,
    enum: true
  )
end

defmodule WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "EncryptedBackupsSecrets",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "backupID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "backupID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "serverDataID",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "serverDataID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "epoch",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets.Epoch",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "epoch",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "tempOcmfClientState",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "tempOcmfClientState",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mailboxRootKey",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mailboxRootKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "obliviousValidationToken",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "obliviousValidationToken",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Epoch",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "ID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "ID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "anonID",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "anonID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "rootKey",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "rootKey",
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
                ".WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets.Epoch.EpochStatus",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "status",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "EpochStatus",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "ES_OPEN",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "ES_CLOSE",
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

  field(:backupID, 1, optional: true, type: :uint64)
  field(:serverDataID, 2, optional: true, type: :uint64)

  field(:epoch, 3,
    repeated: true,
    type: WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets.Epoch
  )

  field(:tempOcmfClientState, 4, optional: true, type: :bytes)
  field(:mailboxRootKey, 5, optional: true, type: :bytes)
  field(:obliviousValidationToken, 6, optional: true, type: :bytes)
end

defmodule WAArmadilloApplication.Armadillo.Signal do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.Signal",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Signal",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "encryptedBackupsSecrets",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "encryptedBackupsSecrets",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "EncryptedBackupsSecrets",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "backupID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "backupID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "serverDataID",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "serverDataID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "epoch",
              extendee: nil,
              number: 3,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets.Epoch",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "epoch",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "tempOcmfClientState",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "tempOcmfClientState",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "mailboxRootKey",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "mailboxRootKey",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "obliviousValidationToken",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "obliviousValidationToken",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "Epoch",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "ID",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_UINT64,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "ID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "anonID",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BYTES,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "anonID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "rootKey",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BYTES,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "rootKey",
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
                    ".WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets.Epoch.EpochStatus",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "status",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [],
              enum_type: [
                %Google.Protobuf.EnumDescriptorProto{
                  name: "EpochStatus",
                  value: [
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "ES_OPEN",
                      number: 1,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "ES_CLOSE",
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
      oneof_decl: [
        %Google.Protobuf.OneofDescriptorProto{
          name: "signal",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:signal, 0)

  field(:encryptedBackupsSecrets, 1,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets,
    oneof: 0
  )
end

defmodule WAArmadilloApplication.Armadillo.ApplicationData.MessageHistoryDocumentMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.ApplicationData.MessageHistoryDocumentMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MessageHistoryDocumentMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "document",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "document",
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

  field(:document, 1, optional: true, type: WACommon.SubProtocol)
end

defmodule WAArmadilloApplication.Armadillo.ApplicationData.AIBotResponseMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.ApplicationData.AIBotResponseMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AIBotResponseMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "summonToken",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "summonToken",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageText",
          extendee: nil,
          number: 2,
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
          name: "serializedExtras",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "serializedExtras",
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

  field(:summonToken, 1, optional: true, type: :string)
  field(:messageText, 2, optional: true, type: :string)
  field(:serializedExtras, 3, optional: true, type: :string)
end

defmodule WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncAttachmentInterventionAction do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncAttachmentInterventionAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SyncAttachmentInterventionAction",
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
          name: "interventionType",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncAttachmentInterventionAction.InterventionType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "interventionType",
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
              name: "UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NUDE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NOT_NUDE",
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

  field(:messageKey, 1, optional: true, type: WACommon.MessageKey)

  field(:interventionType, 2,
    optional: true,
    type:
      WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncAttachmentInterventionAction.InterventionType,
    enum: true
  )
end

defmodule WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncSpectraAction do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncSpectraAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SyncSpectraAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "key",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "key",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "actionType",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncSpectraAction.SpectraActionType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "actionType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "takedownActionID",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "takedownActionID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "config",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "config",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "SpectraActionType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TAKEDOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RESTORE",
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

  field(:key, 1, optional: true, type: WACommon.MessageKey)

  field(:actionType, 2,
    optional: true,
    type:
      WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncSpectraAction.SpectraActionType,
    enum: true
  )

  field(:takedownActionID, 3, optional: true, type: :int64)
  field(:config, 4, optional: true, type: :string)
end

defmodule WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncMessageAction.ActionMessageDelete do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncMessageAction.ActionMessageDelete",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ActionMessageDelete",
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

defmodule WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncMessageAction do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncMessageAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SyncMessageAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageDelete",
          extendee: nil,
          number: 101,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncMessageAction.ActionMessageDelete",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "messageDelete",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "key",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "key",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "ActionMessageDelete",
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
      ],
      enum_type: [],
      extension_range: [],
      extension: [],
      options: nil,
      oneof_decl: [
        %Google.Protobuf.OneofDescriptorProto{
          name: "action",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:action, 0)

  field(:messageDelete, 101,
    optional: true,
    type:
      WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncMessageAction.ActionMessageDelete,
    oneof: 0
  )

  field(:key, 1, optional: true, type: WACommon.MessageKey)
end

defmodule WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatRead do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatRead",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ActionChatRead",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageRange",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageRange",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "read",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "read",
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

  field(:messageRange, 1,
    optional: true,
    type: WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange
  )

  field(:read, 2, optional: true, type: :bool)
end

defmodule WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatDelete do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatDelete",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ActionChatDelete",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageRange",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageRange",
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

  field(:messageRange, 1,
    optional: true,
    type: WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange
  )
end

defmodule WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatArchive do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatArchive",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ActionChatArchive",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageRange",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageRange",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "archived",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "archived",
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

  field(:messageRange, 1,
    optional: true,
    type: WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange
  )

  field(:archived, 2, optional: true, type: :bool)
end

defmodule WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SyncChatAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatArchive",
          extendee: nil,
          number: 101,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatArchive",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "chatArchive",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatDelete",
          extendee: nil,
          number: 102,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatDelete",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "chatDelete",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatRead",
          extendee: nil,
          number: 103,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatRead",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "chatRead",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "chatID",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "ActionChatRead",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "messageRange",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "messageRange",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "read",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "read",
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
          name: "ActionChatDelete",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "messageRange",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "messageRange",
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
          name: "ActionChatArchive",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "messageRange",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "messageRange",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "archived",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "archived",
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
      oneof_decl: [
        %Google.Protobuf.OneofDescriptorProto{
          name: "action",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:action, 0)

  field(:chatArchive, 101,
    optional: true,
    type:
      WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatArchive,
    oneof: 0
  )

  field(:chatDelete, 102,
    optional: true,
    type:
      WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatDelete,
    oneof: 0
  )

  field(:chatRead, 103,
    optional: true,
    type:
      WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatRead,
    oneof: 0
  )

  field(:chatID, 1, optional: true, type: :string)
end

defmodule WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessage do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SyncActionMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "key",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "key",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "timestamp",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "timestamp",
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

  field(:key, 1, optional: true, type: WACommon.MessageKey)
  field(:timestamp, 2, optional: true, type: :int64)
end

defmodule WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange do
  @moduledoc false

  use Protobuf,
    full_name:
      "WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "SyncActionMessageRange",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "lastMessageTimestamp",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lastMessageTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lastSystemMessageTimestamp",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lastSystemMessageTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messages",
          extendee: nil,
          number: 3,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messages",
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

  field(:lastMessageTimestamp, 1, optional: true, type: :int64)
  field(:lastSystemMessageTimestamp, 2, optional: true, type: :int64)

  field(:messages, 3,
    repeated: true,
    type: WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessage
  )
end

defmodule WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MetadataSyncAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "chatAction",
          extendee: nil,
          number: 101,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "chatAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageAction",
          extendee: nil,
          number: 102,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncMessageAction",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "messageAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "spectraAction",
          extendee: nil,
          number: 103,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncSpectraAction",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "spectraAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "attachmentInterventionAction",
          extendee: nil,
          number: 104,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncAttachmentInterventionAction",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "attachmentInterventionAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "actionTimestamp",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "actionTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "SyncAttachmentInterventionAction",
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
              name: "interventionType",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncAttachmentInterventionAction.InterventionType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "interventionType",
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
                  name: "UNKNOWN",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "NUDE",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "NOT_NUDE",
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
          name: "SyncSpectraAction",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "key",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.MessageKey",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "key",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "actionType",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncSpectraAction.SpectraActionType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "actionType",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "takedownActionID",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "takedownActionID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "config",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "config",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "SpectraActionType",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TAKEDOWN",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "RESTORE",
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
        },
        %Google.Protobuf.DescriptorProto{
          name: "SyncMessageAction",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "messageDelete",
              extendee: nil,
              number: 101,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncMessageAction.ActionMessageDelete",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "messageDelete",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "key",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.MessageKey",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "key",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "ActionMessageDelete",
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
          ],
          enum_type: [],
          extension_range: [],
          extension: [],
          options: nil,
          oneof_decl: [
            %Google.Protobuf.OneofDescriptorProto{
              name: "action",
              options: nil,
              __unknown_fields__: []
            }
          ],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "SyncChatAction",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "chatArchive",
              extendee: nil,
              number: 101,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatArchive",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "chatArchive",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "chatDelete",
              extendee: nil,
              number: 102,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatDelete",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "chatDelete",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "chatRead",
              extendee: nil,
              number: 103,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatRead",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "chatRead",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "chatID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "chatID",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "ActionChatRead",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "messageRange",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "messageRange",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "read",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BOOL,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "read",
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
              name: "ActionChatDelete",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "messageRange",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "messageRange",
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
              name: "ActionChatArchive",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "messageRange",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "messageRange",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "archived",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BOOL,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "archived",
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
          oneof_decl: [
            %Google.Protobuf.OneofDescriptorProto{
              name: "action",
              options: nil,
              __unknown_fields__: []
            }
          ],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "SyncActionMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "key",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.MessageKey",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "key",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "timestamp",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "timestamp",
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
          name: "SyncActionMessageRange",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "lastMessageTimestamp",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "lastMessageTimestamp",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "lastSystemMessageTimestamp",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "lastSystemMessageTimestamp",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "messages",
              extendee: nil,
              number: 3,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessage",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "messages",
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
      oneof_decl: [
        %Google.Protobuf.OneofDescriptorProto{
          name: "actionType",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:actionType, 0)

  field(:chatAction, 101,
    optional: true,
    type: WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction,
    oneof: 0
  )

  field(:messageAction, 102,
    optional: true,
    type: WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncMessageAction,
    oneof: 0
  )

  field(:spectraAction, 103,
    optional: true,
    type: WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncSpectraAction,
    oneof: 0
  )

  field(:attachmentInterventionAction, 104,
    optional: true,
    type:
      WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncAttachmentInterventionAction,
    oneof: 0
  )

  field(:actionTimestamp, 1, optional: true, type: :int64)
end

defmodule WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncNotification do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncNotification",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MetadataSyncNotification",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "actions",
          extendee: nil,
          number: 2,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "actions",
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

  field(:actions, 2,
    repeated: true,
    type: WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction
  )
end

defmodule WAArmadilloApplication.Armadillo.ApplicationData do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.ApplicationData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ApplicationData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "metadataSync",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncNotification",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "metadataSync",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "aiBotResponse",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.ApplicationData.AIBotResponseMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "aiBotResponse",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageHistoryDocumentMessage",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name:
            ".WAArmadilloApplication.Armadillo.ApplicationData.MessageHistoryDocumentMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "messageHistoryDocumentMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "MessageHistoryDocumentMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "document",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "document",
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
          name: "AIBotResponseMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "summonToken",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "summonToken",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "messageText",
              extendee: nil,
              number: 2,
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
              name: "serializedExtras",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "serializedExtras",
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
          name: "MetadataSyncAction",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "chatAction",
              extendee: nil,
              number: 101,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "chatAction",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "messageAction",
              extendee: nil,
              number: 102,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncMessageAction",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "messageAction",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "spectraAction",
              extendee: nil,
              number: 103,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncSpectraAction",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "spectraAction",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "attachmentInterventionAction",
              extendee: nil,
              number: 104,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncAttachmentInterventionAction",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "attachmentInterventionAction",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "actionTimestamp",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "actionTimestamp",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "SyncAttachmentInterventionAction",
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
                  name: "interventionType",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_ENUM,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncAttachmentInterventionAction.InterventionType",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "interventionType",
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
                      name: "UNKNOWN",
                      number: 0,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "NUDE",
                      number: 1,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "NOT_NUDE",
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
              name: "SyncSpectraAction",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "key",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WACommon.MessageKey",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "key",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "actionType",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_ENUM,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncSpectraAction.SpectraActionType",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "actionType",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "takedownActionID",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_INT64,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "takedownActionID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "config",
                  extendee: nil,
                  number: 4,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "config",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [],
              enum_type: [
                %Google.Protobuf.EnumDescriptorProto{
                  name: "SpectraActionType",
                  value: [
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "TAKEDOWN",
                      number: 0,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "RESTORE",
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
            },
            %Google.Protobuf.DescriptorProto{
              name: "SyncMessageAction",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "messageDelete",
                  extendee: nil,
                  number: 101,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncMessageAction.ActionMessageDelete",
                  default_value: nil,
                  options: nil,
                  oneof_index: 0,
                  json_name: "messageDelete",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "key",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WACommon.MessageKey",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "key",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [
                %Google.Protobuf.DescriptorProto{
                  name: "ActionMessageDelete",
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
              ],
              enum_type: [],
              extension_range: [],
              extension: [],
              options: nil,
              oneof_decl: [
                %Google.Protobuf.OneofDescriptorProto{
                  name: "action",
                  options: nil,
                  __unknown_fields__: []
                }
              ],
              reserved_range: [],
              reserved_name: [],
              __unknown_fields__: []
            },
            %Google.Protobuf.DescriptorProto{
              name: "SyncChatAction",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "chatArchive",
                  extendee: nil,
                  number: 101,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatArchive",
                  default_value: nil,
                  options: nil,
                  oneof_index: 0,
                  json_name: "chatArchive",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "chatDelete",
                  extendee: nil,
                  number: 102,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatDelete",
                  default_value: nil,
                  options: nil,
                  oneof_index: 0,
                  json_name: "chatDelete",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "chatRead",
                  extendee: nil,
                  number: 103,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatRead",
                  default_value: nil,
                  options: nil,
                  oneof_index: 0,
                  json_name: "chatRead",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "chatID",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "chatID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [
                %Google.Protobuf.DescriptorProto{
                  name: "ActionChatRead",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "messageRange",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_MESSAGE,
                      type_name:
                        ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange",
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "messageRange",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "read",
                      extendee: nil,
                      number: 2,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_BOOL,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "read",
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
                  name: "ActionChatDelete",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "messageRange",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_MESSAGE,
                      type_name:
                        ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange",
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "messageRange",
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
                  name: "ActionChatArchive",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "messageRange",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_MESSAGE,
                      type_name:
                        ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange",
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "messageRange",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "archived",
                      extendee: nil,
                      number: 2,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_BOOL,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "archived",
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
              oneof_decl: [
                %Google.Protobuf.OneofDescriptorProto{
                  name: "action",
                  options: nil,
                  __unknown_fields__: []
                }
              ],
              reserved_range: [],
              reserved_name: [],
              __unknown_fields__: []
            },
            %Google.Protobuf.DescriptorProto{
              name: "SyncActionMessage",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "key",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WACommon.MessageKey",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "key",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "timestamp",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_INT64,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "timestamp",
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
              name: "SyncActionMessageRange",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "lastMessageTimestamp",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_INT64,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "lastMessageTimestamp",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "lastSystemMessageTimestamp",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_INT64,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "lastSystemMessageTimestamp",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "messages",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_REPEATED,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessage",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "messages",
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
          oneof_decl: [
            %Google.Protobuf.OneofDescriptorProto{
              name: "actionType",
              options: nil,
              __unknown_fields__: []
            }
          ],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "MetadataSyncNotification",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "actions",
              extendee: nil,
              number: 2,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "actions",
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
      oneof_decl: [
        %Google.Protobuf.OneofDescriptorProto{
          name: "applicationData",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:applicationData, 0)

  field(:metadataSync, 1,
    optional: true,
    type: WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncNotification,
    oneof: 0
  )

  field(:aiBotResponse, 2,
    optional: true,
    type: WAArmadilloApplication.Armadillo.ApplicationData.AIBotResponseMessage,
    oneof: 0
  )

  field(:messageHistoryDocumentMessage, 3,
    optional: true,
    type: WAArmadilloApplication.Armadillo.ApplicationData.MessageHistoryDocumentMessage,
    oneof: 0
  )
end

defmodule WAArmadilloApplication.Armadillo.Content.PaymentsTransactionMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.Content.PaymentsTransactionMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PaymentsTransactionMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "transactionID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "transactionID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "amount",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "amount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "currency",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "currency",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "paymentStatus",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name:
            ".WAArmadilloApplication.Armadillo.Content.PaymentsTransactionMessage.PaymentStatus",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "paymentStatus",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "extendedContentMessage",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloXMA.ExtendedContentMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "extendedContentMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "PaymentStatus",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAYMENT_UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REQUEST_INITED",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REQUEST_DECLINED",
              number: 5,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REQUEST_TRANSFER_INITED",
              number: 6,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REQUEST_TRANSFER_COMPLETED",
              number: 7,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REQUEST_TRANSFER_FAILED",
              number: 8,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REQUEST_CANCELED",
              number: 9,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REQUEST_EXPIRED",
              number: 10,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TRANSFER_INITED",
              number: 11,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TRANSFER_PENDING",
              number: 12,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TRANSFER_PENDING_RECIPIENT_VERIFICATION",
              number: 13,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TRANSFER_CANCELED",
              number: 14,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TRANSFER_COMPLETED",
              number: 15,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TRANSFER_NO_RECEIVER_CREDENTIAL_NO_RTS_PENDING_CANCELED",
              number: 16,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TRANSFER_NO_RECEIVER_CREDENTIAL_NO_RTS_PENDING_OTHER",
              number: 17,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TRANSFER_REFUNDED",
              number: 18,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TRANSFER_PARTIAL_REFUND",
              number: 19,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TRANSFER_CHARGED_BACK",
              number: 20,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TRANSFER_EXPIRED",
              number: 21,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TRANSFER_DECLINED",
              number: 22,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TRANSFER_UNAVAILABLE",
              number: 23,
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

  field(:transactionID, 1, optional: true, type: :uint64)
  field(:amount, 2, optional: true, type: :string)
  field(:currency, 3, optional: true, type: :string)

  field(:paymentStatus, 4,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Content.PaymentsTransactionMessage.PaymentStatus,
    enum: true
  )

  field(:extendedContentMessage, 5, optional: true, type: WAArmadilloXMA.ExtendedContentMessage)
end

defmodule WAArmadilloApplication.Armadillo.Content.NetworkVerificationMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.Content.NetworkVerificationMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "NetworkVerificationMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "codeText",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "codeText",
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

  field(:codeText, 1, optional: true, type: :string)
end

defmodule WAArmadilloApplication.Armadillo.Content.NoteReplyMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.Content.NoteReplyMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "NoteReplyMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "textContent",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageText",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "textContent",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "stickerContent",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "stickerContent",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "videoContent",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "videoContent",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "noteID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "noteID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "noteText",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageText",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "noteText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "noteTimestampMS",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "noteTimestampMS",
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
          name: "noteReplyContent",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:noteReplyContent, 0)

  field(:textContent, 4, optional: true, type: WACommon.MessageText, oneof: 0)
  field(:stickerContent, 5, optional: true, type: WACommon.SubProtocol, oneof: 0)
  field(:videoContent, 6, optional: true, type: WACommon.SubProtocol, oneof: 0)
  field(:noteID, 1, optional: true, type: :string)
  field(:noteText, 2, optional: true, type: WACommon.MessageText)
  field(:noteTimestampMS, 3, optional: true, type: :int64)
end

defmodule WAArmadilloApplication.Armadillo.Content.BumpExistingMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.Content.BumpExistingMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "BumpExistingMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "key",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "key",
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

  field(:key, 1, optional: true, type: WACommon.MessageKey)
end

defmodule WAArmadilloApplication.Armadillo.Content.ImageGalleryMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.Content.ImageGalleryMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ImageGalleryMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "images",
          extendee: nil,
          number: 1,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "images",
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

  field(:images, 1, repeated: true, type: WACommon.SubProtocol)
end

defmodule WAArmadilloApplication.Armadillo.Content.ScreenshotAction do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.Content.ScreenshotAction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ScreenshotAction",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "screenshotType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAArmadilloApplication.Armadillo.Content.ScreenshotAction.ScreenshotType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "screenshotType",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "ScreenshotType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SCREENSHOT_IMAGE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SCREEN_RECORDING",
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

  field(:screenshotType, 1,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Content.ScreenshotAction.ScreenshotType,
    enum: true
  )
end

defmodule WAArmadilloApplication.Armadillo.Content.ExtendedContentMessageWithSear do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.Content.ExtendedContentMessageWithSear",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ExtendedContentMessageWithSear",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "searID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "searID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "payload",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "payload",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "nativeURL",
          extendee: nil,
          number: 3,
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
          name: "searAssociatedMessage",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "searAssociatedMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "searSentWithMessageID",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "searSentWithMessageID",
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

  field(:searID, 1, optional: true, type: :string)
  field(:payload, 2, optional: true, type: :bytes)
  field(:nativeURL, 3, optional: true, type: :string)
  field(:searAssociatedMessage, 4, optional: true, type: WACommon.SubProtocol)
  field(:searSentWithMessageID, 5, optional: true, type: :string)
end

defmodule WAArmadilloApplication.Armadillo.Content.RavenActionNotifMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.Content.RavenActionNotifMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "RavenActionNotifMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "key",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "key",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "actionTimestamp",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "actionTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "actionType",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAArmadilloApplication.Armadillo.Content.RavenActionNotifMessage.ActionType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "actionType",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "ActionType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PLAYED",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SCREENSHOT",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FORCE_DISABLE",
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

  field(:key, 1, optional: true, type: WACommon.MessageKey)
  field(:actionTimestamp, 2, optional: true, type: :int64)

  field(:actionType, 3,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Content.RavenActionNotifMessage.ActionType,
    enum: true
  )
end

defmodule WAArmadilloApplication.Armadillo.Content.RavenMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.Content.RavenMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "RavenMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "imageMessage",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "imageMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "videoMessage",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.SubProtocol",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "videoMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAArmadilloApplication.Armadillo.Content.RavenMessage.EphemeralType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeralType",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "EphemeralType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VIEW_ONCE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ALLOW_REPLAY",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "KEEP_IN_CHAT",
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
        %Google.Protobuf.OneofDescriptorProto{
          name: "mediaContent",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:mediaContent, 0)

  field(:imageMessage, 2, optional: true, type: WACommon.SubProtocol, oneof: 0)
  field(:videoMessage, 3, optional: true, type: WACommon.SubProtocol, oneof: 0)

  field(:ephemeralType, 1,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Content.RavenMessage.EphemeralType,
    enum: true
  )
end

defmodule WAArmadilloApplication.Armadillo.Content.CommonSticker do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.Content.CommonSticker",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "CommonSticker",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "stickerType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAArmadilloApplication.Armadillo.Content.CommonSticker.StickerType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "stickerType",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "StickerType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SMALL_LIKE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MEDIUM_LIKE",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "LARGE_LIKE",
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

  field(:stickerType, 1,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Content.CommonSticker.StickerType,
    enum: true
  )
end

defmodule WAArmadilloApplication.Armadillo.Content do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo.Content",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Content",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "commonSticker",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.Content.CommonSticker",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "commonSticker",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "screenshotAction",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.Content.ScreenshotAction",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "screenshotAction",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "extendedContentMessage",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloXMA.ExtendedContentMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "extendedContentMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ravenMessage",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.Content.RavenMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "ravenMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ravenActionNotifMessage",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.Content.RavenActionNotifMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "ravenActionNotifMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "extendedMessageContentWithSear",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.Content.ExtendedContentMessageWithSear",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "extendedMessageContentWithSear",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "imageGalleryMessage",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.Content.ImageGalleryMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "imageGalleryMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "paymentsTransactionMessage",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.Content.PaymentsTransactionMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "paymentsTransactionMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "bumpExistingMessage",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.Content.BumpExistingMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "bumpExistingMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "noteReplyMessage",
          extendee: nil,
          number: 13,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.Content.NoteReplyMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "noteReplyMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ravenMessageMsgr",
          extendee: nil,
          number: 14,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.Content.RavenMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "ravenMessageMsgr",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "networkVerificationMessage",
          extendee: nil,
          number: 15,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.Content.NetworkVerificationMessage",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "networkVerificationMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "PaymentsTransactionMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "transactionID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "transactionID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "amount",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "amount",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "currency",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "currency",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "paymentStatus",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAArmadilloApplication.Armadillo.Content.PaymentsTransactionMessage.PaymentStatus",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "paymentStatus",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "extendedContentMessage",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloXMA.ExtendedContentMessage",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "extendedContentMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "PaymentStatus",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "PAYMENT_UNKNOWN",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "REQUEST_INITED",
                  number: 4,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "REQUEST_DECLINED",
                  number: 5,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "REQUEST_TRANSFER_INITED",
                  number: 6,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "REQUEST_TRANSFER_COMPLETED",
                  number: 7,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "REQUEST_TRANSFER_FAILED",
                  number: 8,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "REQUEST_CANCELED",
                  number: 9,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "REQUEST_EXPIRED",
                  number: 10,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TRANSFER_INITED",
                  number: 11,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TRANSFER_PENDING",
                  number: 12,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TRANSFER_PENDING_RECIPIENT_VERIFICATION",
                  number: 13,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TRANSFER_CANCELED",
                  number: 14,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TRANSFER_COMPLETED",
                  number: 15,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TRANSFER_NO_RECEIVER_CREDENTIAL_NO_RTS_PENDING_CANCELED",
                  number: 16,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TRANSFER_NO_RECEIVER_CREDENTIAL_NO_RTS_PENDING_OTHER",
                  number: 17,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TRANSFER_REFUNDED",
                  number: 18,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TRANSFER_PARTIAL_REFUND",
                  number: 19,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TRANSFER_CHARGED_BACK",
                  number: 20,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TRANSFER_EXPIRED",
                  number: 21,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TRANSFER_DECLINED",
                  number: 22,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TRANSFER_UNAVAILABLE",
                  number: 23,
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
          name: "NetworkVerificationMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "codeText",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "codeText",
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
          name: "NoteReplyMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "textContent",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.MessageText",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "textContent",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "stickerContent",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "stickerContent",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "videoContent",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "videoContent",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "noteID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "noteID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "noteText",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.MessageText",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "noteText",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "noteTimestampMS",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "noteTimestampMS",
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
              name: "noteReplyContent",
              options: nil,
              __unknown_fields__: []
            }
          ],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "BumpExistingMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "key",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.MessageKey",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "key",
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
          name: "ImageGalleryMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "images",
              extendee: nil,
              number: 1,
              label: :LABEL_REPEATED,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "images",
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
          name: "ScreenshotAction",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "screenshotType",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAArmadilloApplication.Armadillo.Content.ScreenshotAction.ScreenshotType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "screenshotType",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "ScreenshotType",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "SCREENSHOT_IMAGE",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "SCREEN_RECORDING",
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
          name: "ExtendedContentMessageWithSear",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "searID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "searID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "payload",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "payload",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "nativeURL",
              extendee: nil,
              number: 3,
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
              name: "searAssociatedMessage",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "searAssociatedMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "searSentWithMessageID",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "searSentWithMessageID",
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
          name: "RavenActionNotifMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "key",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.MessageKey",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "key",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "actionTimestamp",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_INT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "actionTimestamp",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "actionType",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name:
                ".WAArmadilloApplication.Armadillo.Content.RavenActionNotifMessage.ActionType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "actionType",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "ActionType",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "PLAYED",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "SCREENSHOT",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "FORCE_DISABLE",
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
          name: "RavenMessage",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "imageMessage",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "imageMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "videoMessage",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WACommon.SubProtocol",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "videoMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "ephemeralType",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAArmadilloApplication.Armadillo.Content.RavenMessage.EphemeralType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "ephemeralType",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "EphemeralType",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "VIEW_ONCE",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "ALLOW_REPLAY",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "KEEP_IN_CHAT",
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
            %Google.Protobuf.OneofDescriptorProto{
              name: "mediaContent",
              options: nil,
              __unknown_fields__: []
            }
          ],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "CommonSticker",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "stickerType",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAArmadilloApplication.Armadillo.Content.CommonSticker.StickerType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "stickerType",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "StickerType",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "SMALL_LIKE",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "MEDIUM_LIKE",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "LARGE_LIKE",
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
      oneof_decl: [
        %Google.Protobuf.OneofDescriptorProto{
          name: "content",
          options: nil,
          __unknown_fields__: []
        }
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:content, 0)

  field(:commonSticker, 1,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Content.CommonSticker,
    oneof: 0
  )

  field(:screenshotAction, 3,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Content.ScreenshotAction,
    oneof: 0
  )

  field(:extendedContentMessage, 4,
    optional: true,
    type: WAArmadilloXMA.ExtendedContentMessage,
    oneof: 0
  )

  field(:ravenMessage, 5,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Content.RavenMessage,
    oneof: 0
  )

  field(:ravenActionNotifMessage, 6,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Content.RavenActionNotifMessage,
    oneof: 0
  )

  field(:extendedMessageContentWithSear, 7,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Content.ExtendedContentMessageWithSear,
    oneof: 0
  )

  field(:imageGalleryMessage, 8,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Content.ImageGalleryMessage,
    oneof: 0
  )

  field(:paymentsTransactionMessage, 10,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Content.PaymentsTransactionMessage,
    oneof: 0
  )

  field(:bumpExistingMessage, 11,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Content.BumpExistingMessage,
    oneof: 0
  )

  field(:noteReplyMessage, 13,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Content.NoteReplyMessage,
    oneof: 0
  )

  field(:ravenMessageMsgr, 14,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Content.RavenMessage,
    oneof: 0
  )

  field(:networkVerificationMessage, 15,
    optional: true,
    type: WAArmadilloApplication.Armadillo.Content.NetworkVerificationMessage,
    oneof: 0
  )
end

defmodule WAArmadilloApplication.Armadillo do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloApplication.Armadillo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Armadillo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "payload",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.Payload",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "payload",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "metadata",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloApplication.Armadillo.Metadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "metadata",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Metadata",
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
          name: "Payload",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "content",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.Content",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "content",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "applicationData",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.ApplicationData",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "applicationData",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "signal",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.Signal",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "signal",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "subProtocol",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.SubProtocolPayload",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "subProtocol",
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
              name: "payload",
              options: nil,
              __unknown_fields__: []
            }
          ],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "SubProtocolPayload",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "futureProof",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WACommon.FutureProofBehavior",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "futureProof",
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
          name: "Signal",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "encryptedBackupsSecrets",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "encryptedBackupsSecrets",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "EncryptedBackupsSecrets",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "backupID",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_UINT64,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "backupID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "serverDataID",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_UINT64,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "serverDataID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "epoch",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_REPEATED,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets.Epoch",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "epoch",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "tempOcmfClientState",
                  extendee: nil,
                  number: 4,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BYTES,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "tempOcmfClientState",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "mailboxRootKey",
                  extendee: nil,
                  number: 5,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BYTES,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "mailboxRootKey",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "obliviousValidationToken",
                  extendee: nil,
                  number: 6,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BYTES,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "obliviousValidationToken",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [
                %Google.Protobuf.DescriptorProto{
                  name: "Epoch",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "ID",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_UINT64,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "ID",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "anonID",
                      extendee: nil,
                      number: 2,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_BYTES,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "anonID",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "rootKey",
                      extendee: nil,
                      number: 3,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_BYTES,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "rootKey",
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
                        ".WAArmadilloApplication.Armadillo.Signal.EncryptedBackupsSecrets.Epoch.EpochStatus",
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "status",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    }
                  ],
                  nested_type: [],
                  enum_type: [
                    %Google.Protobuf.EnumDescriptorProto{
                      name: "EpochStatus",
                      value: [
                        %Google.Protobuf.EnumValueDescriptorProto{
                          name: "ES_OPEN",
                          number: 1,
                          options: nil,
                          __unknown_fields__: []
                        },
                        %Google.Protobuf.EnumValueDescriptorProto{
                          name: "ES_CLOSE",
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
          oneof_decl: [
            %Google.Protobuf.OneofDescriptorProto{
              name: "signal",
              options: nil,
              __unknown_fields__: []
            }
          ],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "ApplicationData",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "metadataSync",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncNotification",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "metadataSync",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "aiBotResponse",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.ApplicationData.AIBotResponseMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "aiBotResponse",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "messageHistoryDocumentMessage",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name:
                ".WAArmadilloApplication.Armadillo.ApplicationData.MessageHistoryDocumentMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "messageHistoryDocumentMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "MessageHistoryDocumentMessage",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "document",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WACommon.SubProtocol",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "document",
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
              name: "AIBotResponseMessage",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "summonToken",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "summonToken",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "messageText",
                  extendee: nil,
                  number: 2,
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
                  name: "serializedExtras",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "serializedExtras",
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
              name: "MetadataSyncAction",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "chatAction",
                  extendee: nil,
                  number: 101,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction",
                  default_value: nil,
                  options: nil,
                  oneof_index: 0,
                  json_name: "chatAction",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "messageAction",
                  extendee: nil,
                  number: 102,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncMessageAction",
                  default_value: nil,
                  options: nil,
                  oneof_index: 0,
                  json_name: "messageAction",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "spectraAction",
                  extendee: nil,
                  number: 103,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncSpectraAction",
                  default_value: nil,
                  options: nil,
                  oneof_index: 0,
                  json_name: "spectraAction",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "attachmentInterventionAction",
                  extendee: nil,
                  number: 104,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncAttachmentInterventionAction",
                  default_value: nil,
                  options: nil,
                  oneof_index: 0,
                  json_name: "attachmentInterventionAction",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "actionTimestamp",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_INT64,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "actionTimestamp",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [
                %Google.Protobuf.DescriptorProto{
                  name: "SyncAttachmentInterventionAction",
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
                      name: "interventionType",
                      extendee: nil,
                      number: 2,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_ENUM,
                      type_name:
                        ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncAttachmentInterventionAction.InterventionType",
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "interventionType",
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
                          name: "UNKNOWN",
                          number: 0,
                          options: nil,
                          __unknown_fields__: []
                        },
                        %Google.Protobuf.EnumValueDescriptorProto{
                          name: "NUDE",
                          number: 1,
                          options: nil,
                          __unknown_fields__: []
                        },
                        %Google.Protobuf.EnumValueDescriptorProto{
                          name: "NOT_NUDE",
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
                  name: "SyncSpectraAction",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "key",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_MESSAGE,
                      type_name: ".WACommon.MessageKey",
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "key",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "actionType",
                      extendee: nil,
                      number: 2,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_ENUM,
                      type_name:
                        ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncSpectraAction.SpectraActionType",
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "actionType",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "takedownActionID",
                      extendee: nil,
                      number: 3,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_INT64,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "takedownActionID",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "config",
                      extendee: nil,
                      number: 4,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_STRING,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "config",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    }
                  ],
                  nested_type: [],
                  enum_type: [
                    %Google.Protobuf.EnumDescriptorProto{
                      name: "SpectraActionType",
                      value: [
                        %Google.Protobuf.EnumValueDescriptorProto{
                          name: "TAKEDOWN",
                          number: 0,
                          options: nil,
                          __unknown_fields__: []
                        },
                        %Google.Protobuf.EnumValueDescriptorProto{
                          name: "RESTORE",
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
                },
                %Google.Protobuf.DescriptorProto{
                  name: "SyncMessageAction",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "messageDelete",
                      extendee: nil,
                      number: 101,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_MESSAGE,
                      type_name:
                        ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncMessageAction.ActionMessageDelete",
                      default_value: nil,
                      options: nil,
                      oneof_index: 0,
                      json_name: "messageDelete",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "key",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_MESSAGE,
                      type_name: ".WACommon.MessageKey",
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "key",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    }
                  ],
                  nested_type: [
                    %Google.Protobuf.DescriptorProto{
                      name: "ActionMessageDelete",
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
                  ],
                  enum_type: [],
                  extension_range: [],
                  extension: [],
                  options: nil,
                  oneof_decl: [
                    %Google.Protobuf.OneofDescriptorProto{
                      name: "action",
                      options: nil,
                      __unknown_fields__: []
                    }
                  ],
                  reserved_range: [],
                  reserved_name: [],
                  __unknown_fields__: []
                },
                %Google.Protobuf.DescriptorProto{
                  name: "SyncChatAction",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "chatArchive",
                      extendee: nil,
                      number: 101,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_MESSAGE,
                      type_name:
                        ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatArchive",
                      default_value: nil,
                      options: nil,
                      oneof_index: 0,
                      json_name: "chatArchive",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "chatDelete",
                      extendee: nil,
                      number: 102,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_MESSAGE,
                      type_name:
                        ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatDelete",
                      default_value: nil,
                      options: nil,
                      oneof_index: 0,
                      json_name: "chatDelete",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "chatRead",
                      extendee: nil,
                      number: 103,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_MESSAGE,
                      type_name:
                        ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncChatAction.ActionChatRead",
                      default_value: nil,
                      options: nil,
                      oneof_index: 0,
                      json_name: "chatRead",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "chatID",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_STRING,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "chatID",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    }
                  ],
                  nested_type: [
                    %Google.Protobuf.DescriptorProto{
                      name: "ActionChatRead",
                      field: [
                        %Google.Protobuf.FieldDescriptorProto{
                          name: "messageRange",
                          extendee: nil,
                          number: 1,
                          label: :LABEL_OPTIONAL,
                          type: :TYPE_MESSAGE,
                          type_name:
                            ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange",
                          default_value: nil,
                          options: nil,
                          oneof_index: nil,
                          json_name: "messageRange",
                          proto3_optional: nil,
                          __unknown_fields__: []
                        },
                        %Google.Protobuf.FieldDescriptorProto{
                          name: "read",
                          extendee: nil,
                          number: 2,
                          label: :LABEL_OPTIONAL,
                          type: :TYPE_BOOL,
                          type_name: nil,
                          default_value: nil,
                          options: nil,
                          oneof_index: nil,
                          json_name: "read",
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
                      name: "ActionChatDelete",
                      field: [
                        %Google.Protobuf.FieldDescriptorProto{
                          name: "messageRange",
                          extendee: nil,
                          number: 1,
                          label: :LABEL_OPTIONAL,
                          type: :TYPE_MESSAGE,
                          type_name:
                            ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange",
                          default_value: nil,
                          options: nil,
                          oneof_index: nil,
                          json_name: "messageRange",
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
                      name: "ActionChatArchive",
                      field: [
                        %Google.Protobuf.FieldDescriptorProto{
                          name: "messageRange",
                          extendee: nil,
                          number: 1,
                          label: :LABEL_OPTIONAL,
                          type: :TYPE_MESSAGE,
                          type_name:
                            ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessageRange",
                          default_value: nil,
                          options: nil,
                          oneof_index: nil,
                          json_name: "messageRange",
                          proto3_optional: nil,
                          __unknown_fields__: []
                        },
                        %Google.Protobuf.FieldDescriptorProto{
                          name: "archived",
                          extendee: nil,
                          number: 2,
                          label: :LABEL_OPTIONAL,
                          type: :TYPE_BOOL,
                          type_name: nil,
                          default_value: nil,
                          options: nil,
                          oneof_index: nil,
                          json_name: "archived",
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
                  oneof_decl: [
                    %Google.Protobuf.OneofDescriptorProto{
                      name: "action",
                      options: nil,
                      __unknown_fields__: []
                    }
                  ],
                  reserved_range: [],
                  reserved_name: [],
                  __unknown_fields__: []
                },
                %Google.Protobuf.DescriptorProto{
                  name: "SyncActionMessage",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "key",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_MESSAGE,
                      type_name: ".WACommon.MessageKey",
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "key",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "timestamp",
                      extendee: nil,
                      number: 2,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_INT64,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "timestamp",
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
                  name: "SyncActionMessageRange",
                  field: [
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "lastMessageTimestamp",
                      extendee: nil,
                      number: 1,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_INT64,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "lastMessageTimestamp",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "lastSystemMessageTimestamp",
                      extendee: nil,
                      number: 2,
                      label: :LABEL_OPTIONAL,
                      type: :TYPE_INT64,
                      type_name: nil,
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "lastSystemMessageTimestamp",
                      proto3_optional: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.FieldDescriptorProto{
                      name: "messages",
                      extendee: nil,
                      number: 3,
                      label: :LABEL_REPEATED,
                      type: :TYPE_MESSAGE,
                      type_name:
                        ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction.SyncActionMessage",
                      default_value: nil,
                      options: nil,
                      oneof_index: nil,
                      json_name: "messages",
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
              oneof_decl: [
                %Google.Protobuf.OneofDescriptorProto{
                  name: "actionType",
                  options: nil,
                  __unknown_fields__: []
                }
              ],
              reserved_range: [],
              reserved_name: [],
              __unknown_fields__: []
            },
            %Google.Protobuf.DescriptorProto{
              name: "MetadataSyncNotification",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "actions",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_REPEATED,
                  type: :TYPE_MESSAGE,
                  type_name: ".WAArmadilloApplication.Armadillo.ApplicationData.MetadataSyncAction",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "actions",
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
          oneof_decl: [
            %Google.Protobuf.OneofDescriptorProto{
              name: "applicationData",
              options: nil,
              __unknown_fields__: []
            }
          ],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "Content",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "commonSticker",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.Content.CommonSticker",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "commonSticker",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "screenshotAction",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.Content.ScreenshotAction",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "screenshotAction",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "extendedContentMessage",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloXMA.ExtendedContentMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "extendedContentMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "ravenMessage",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.Content.RavenMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "ravenMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "ravenActionNotifMessage",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.Content.RavenActionNotifMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "ravenActionNotifMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "extendedMessageContentWithSear",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.Content.ExtendedContentMessageWithSear",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "extendedMessageContentWithSear",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "imageGalleryMessage",
              extendee: nil,
              number: 8,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.Content.ImageGalleryMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "imageGalleryMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "paymentsTransactionMessage",
              extendee: nil,
              number: 10,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.Content.PaymentsTransactionMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "paymentsTransactionMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "bumpExistingMessage",
              extendee: nil,
              number: 11,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.Content.BumpExistingMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "bumpExistingMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "noteReplyMessage",
              extendee: nil,
              number: 13,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.Content.NoteReplyMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "noteReplyMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "ravenMessageMsgr",
              extendee: nil,
              number: 14,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.Content.RavenMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "ravenMessageMsgr",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "networkVerificationMessage",
              extendee: nil,
              number: 15,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloApplication.Armadillo.Content.NetworkVerificationMessage",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "networkVerificationMessage",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "PaymentsTransactionMessage",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "transactionID",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_UINT64,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "transactionID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "amount",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "amount",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "currency",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "currency",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "paymentStatus",
                  extendee: nil,
                  number: 4,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_ENUM,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.Content.PaymentsTransactionMessage.PaymentStatus",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "paymentStatus",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "extendedContentMessage",
                  extendee: nil,
                  number: 5,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WAArmadilloXMA.ExtendedContentMessage",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "extendedContentMessage",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [],
              enum_type: [
                %Google.Protobuf.EnumDescriptorProto{
                  name: "PaymentStatus",
                  value: [
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "PAYMENT_UNKNOWN",
                      number: 0,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "REQUEST_INITED",
                      number: 4,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "REQUEST_DECLINED",
                      number: 5,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "REQUEST_TRANSFER_INITED",
                      number: 6,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "REQUEST_TRANSFER_COMPLETED",
                      number: 7,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "REQUEST_TRANSFER_FAILED",
                      number: 8,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "REQUEST_CANCELED",
                      number: 9,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "REQUEST_EXPIRED",
                      number: 10,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "TRANSFER_INITED",
                      number: 11,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "TRANSFER_PENDING",
                      number: 12,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "TRANSFER_PENDING_RECIPIENT_VERIFICATION",
                      number: 13,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "TRANSFER_CANCELED",
                      number: 14,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "TRANSFER_COMPLETED",
                      number: 15,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "TRANSFER_NO_RECEIVER_CREDENTIAL_NO_RTS_PENDING_CANCELED",
                      number: 16,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "TRANSFER_NO_RECEIVER_CREDENTIAL_NO_RTS_PENDING_OTHER",
                      number: 17,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "TRANSFER_REFUNDED",
                      number: 18,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "TRANSFER_PARTIAL_REFUND",
                      number: 19,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "TRANSFER_CHARGED_BACK",
                      number: 20,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "TRANSFER_EXPIRED",
                      number: 21,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "TRANSFER_DECLINED",
                      number: 22,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "TRANSFER_UNAVAILABLE",
                      number: 23,
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
              name: "NetworkVerificationMessage",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "codeText",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "codeText",
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
              name: "NoteReplyMessage",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "textContent",
                  extendee: nil,
                  number: 4,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WACommon.MessageText",
                  default_value: nil,
                  options: nil,
                  oneof_index: 0,
                  json_name: "textContent",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "stickerContent",
                  extendee: nil,
                  number: 5,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WACommon.SubProtocol",
                  default_value: nil,
                  options: nil,
                  oneof_index: 0,
                  json_name: "stickerContent",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "videoContent",
                  extendee: nil,
                  number: 6,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WACommon.SubProtocol",
                  default_value: nil,
                  options: nil,
                  oneof_index: 0,
                  json_name: "videoContent",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "noteID",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "noteID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "noteText",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WACommon.MessageText",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "noteText",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "noteTimestampMS",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_INT64,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "noteTimestampMS",
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
                  name: "noteReplyContent",
                  options: nil,
                  __unknown_fields__: []
                }
              ],
              reserved_range: [],
              reserved_name: [],
              __unknown_fields__: []
            },
            %Google.Protobuf.DescriptorProto{
              name: "BumpExistingMessage",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "key",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WACommon.MessageKey",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "key",
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
              name: "ImageGalleryMessage",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "images",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_REPEATED,
                  type: :TYPE_MESSAGE,
                  type_name: ".WACommon.SubProtocol",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "images",
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
              name: "ScreenshotAction",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "screenshotType",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_ENUM,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.Content.ScreenshotAction.ScreenshotType",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "screenshotType",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [],
              enum_type: [
                %Google.Protobuf.EnumDescriptorProto{
                  name: "ScreenshotType",
                  value: [
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "SCREENSHOT_IMAGE",
                      number: 1,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "SCREEN_RECORDING",
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
              name: "ExtendedContentMessageWithSear",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "searID",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "searID",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "payload",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BYTES,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "payload",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "nativeURL",
                  extendee: nil,
                  number: 3,
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
                  name: "searAssociatedMessage",
                  extendee: nil,
                  number: 4,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WACommon.SubProtocol",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "searAssociatedMessage",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "searSentWithMessageID",
                  extendee: nil,
                  number: 5,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "searSentWithMessageID",
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
              name: "RavenActionNotifMessage",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "key",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WACommon.MessageKey",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "key",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "actionTimestamp",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_INT64,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "actionTimestamp",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "actionType",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_ENUM,
                  type_name:
                    ".WAArmadilloApplication.Armadillo.Content.RavenActionNotifMessage.ActionType",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "actionType",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [],
              enum_type: [
                %Google.Protobuf.EnumDescriptorProto{
                  name: "ActionType",
                  value: [
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "PLAYED",
                      number: 0,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "SCREENSHOT",
                      number: 1,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "FORCE_DISABLE",
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
              name: "RavenMessage",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "imageMessage",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WACommon.SubProtocol",
                  default_value: nil,
                  options: nil,
                  oneof_index: 0,
                  json_name: "imageMessage",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "videoMessage",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_MESSAGE,
                  type_name: ".WACommon.SubProtocol",
                  default_value: nil,
                  options: nil,
                  oneof_index: 0,
                  json_name: "videoMessage",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "ephemeralType",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_ENUM,
                  type_name: ".WAArmadilloApplication.Armadillo.Content.RavenMessage.EphemeralType",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "ephemeralType",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [],
              enum_type: [
                %Google.Protobuf.EnumDescriptorProto{
                  name: "EphemeralType",
                  value: [
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "VIEW_ONCE",
                      number: 0,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "ALLOW_REPLAY",
                      number: 1,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "KEEP_IN_CHAT",
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
                %Google.Protobuf.OneofDescriptorProto{
                  name: "mediaContent",
                  options: nil,
                  __unknown_fields__: []
                }
              ],
              reserved_range: [],
              reserved_name: [],
              __unknown_fields__: []
            },
            %Google.Protobuf.DescriptorProto{
              name: "CommonSticker",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "stickerType",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_ENUM,
                  type_name: ".WAArmadilloApplication.Armadillo.Content.CommonSticker.StickerType",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "stickerType",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [],
              enum_type: [
                %Google.Protobuf.EnumDescriptorProto{
                  name: "StickerType",
                  value: [
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "SMALL_LIKE",
                      number: 1,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "MEDIUM_LIKE",
                      number: 2,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "LARGE_LIKE",
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
          oneof_decl: [
            %Google.Protobuf.OneofDescriptorProto{
              name: "content",
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

  field(:payload, 1, optional: true, type: WAArmadilloApplication.Armadillo.Payload)
  field(:metadata, 2, optional: true, type: WAArmadilloApplication.Armadillo.Metadata)
end
