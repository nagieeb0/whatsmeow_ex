defmodule WAArmadilloTransportEvent.TransportEvent.Event.IcdcAlert.Type do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAArmadilloTransportEvent.TransportEvent.Event.IcdcAlert.Type",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Type",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NONE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DETECTED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CLEARED",
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
  field(:DETECTED, 1)
  field(:CLEARED, 2)
end

defmodule WAArmadilloTransportEvent.TransportEvent.Event.DeviceChange.Type do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAArmadilloTransportEvent.TransportEvent.Event.DeviceChange.Type",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Type",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NONE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ADDED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REMOVED",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REPLACED",
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

  field(:NONE, 0)
  field(:ADDED, 1)
  field(:REMOVED, 2)
  field(:REPLACED, 3)
end

defmodule WAArmadilloTransportEvent.TransportEvent.Placeholder.Type do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAArmadilloTransportEvent.TransportEvent.Placeholder.Type",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Type",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DECRYPTION_FAILURE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNAVAILABLE_MESSAGE",
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

  field(:DECRYPTION_FAILURE, 1)
  field(:UNAVAILABLE_MESSAGE, 2)
end

defmodule WAArmadilloTransportEvent.TransportEvent.Event.IcdcAlert do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloTransportEvent.TransportEvent.Event.IcdcAlert",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "IcdcAlert",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "type",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAArmadilloTransportEvent.TransportEvent.Event.IcdcAlert.Type",
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
          name: "Type",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NONE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DETECTED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CLEARED",
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
    type: WAArmadilloTransportEvent.TransportEvent.Event.IcdcAlert.Type,
    enum: true
  )
end

defmodule WAArmadilloTransportEvent.TransportEvent.Event.DeviceChange do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloTransportEvent.TransportEvent.Event.DeviceChange",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "DeviceChange",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "type",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAArmadilloTransportEvent.TransportEvent.Event.DeviceChange.Type",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "type",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deviceName",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deviceName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "devicePlatform",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "devicePlatform",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deviceModel",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deviceModel",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "Type",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NONE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ADDED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REMOVED",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REPLACED",
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

  field(:type, 1,
    optional: true,
    type: WAArmadilloTransportEvent.TransportEvent.Event.DeviceChange.Type,
    enum: true
  )

  field(:deviceName, 2, optional: true, type: :string)
  field(:devicePlatform, 3, optional: true, type: :string)
  field(:deviceModel, 4, optional: true, type: :string)
end

defmodule WAArmadilloTransportEvent.TransportEvent.Event do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloTransportEvent.TransportEvent.Event",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Event",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "deviceChange",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloTransportEvent.TransportEvent.Event.DeviceChange",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "deviceChange",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "icdcAlert",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloTransportEvent.TransportEvent.Event.IcdcAlert",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "icdcAlert",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "IcdcAlert",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "type",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAArmadilloTransportEvent.TransportEvent.Event.IcdcAlert.Type",
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
              name: "Type",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "NONE",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "DETECTED",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "CLEARED",
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
          name: "DeviceChange",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "type",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAArmadilloTransportEvent.TransportEvent.Event.DeviceChange.Type",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "type",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "deviceName",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "deviceName",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "devicePlatform",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "devicePlatform",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "deviceModel",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "deviceModel",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "Type",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "NONE",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "ADDED",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "REMOVED",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "REPLACED",
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
        %Google.Protobuf.OneofDescriptorProto{name: "event", options: nil, __unknown_fields__: []}
      ],
      reserved_range: [],
      reserved_name: [],
      __unknown_fields__: []
    }
  end

  oneof(:event, 0)

  field(:deviceChange, 1,
    optional: true,
    type: WAArmadilloTransportEvent.TransportEvent.Event.DeviceChange,
    oneof: 0
  )

  field(:icdcAlert, 2,
    optional: true,
    type: WAArmadilloTransportEvent.TransportEvent.Event.IcdcAlert,
    oneof: 0
  )
end

defmodule WAArmadilloTransportEvent.TransportEvent.Placeholder do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloTransportEvent.TransportEvent.Placeholder",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Placeholder",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "type",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAArmadilloTransportEvent.TransportEvent.Placeholder.Type",
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
          name: "Type",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DECRYPTION_FAILURE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNAVAILABLE_MESSAGE",
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
    type: WAArmadilloTransportEvent.TransportEvent.Placeholder.Type,
    enum: true
  )
end

defmodule WAArmadilloTransportEvent.TransportEvent do
  @moduledoc false

  use Protobuf,
    full_name: "WAArmadilloTransportEvent.TransportEvent",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "TransportEvent",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "placeholder",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloTransportEvent.TransportEvent.Placeholder",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "placeholder",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "event",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAArmadilloTransportEvent.TransportEvent.Event",
          default_value: nil,
          options: nil,
          oneof_index: 0,
          json_name: "event",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "Event",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "deviceChange",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloTransportEvent.TransportEvent.Event.DeviceChange",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "deviceChange",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "icdcAlert",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAArmadilloTransportEvent.TransportEvent.Event.IcdcAlert",
              default_value: nil,
              options: nil,
              oneof_index: 0,
              json_name: "icdcAlert",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "IcdcAlert",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "type",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_ENUM,
                  type_name: ".WAArmadilloTransportEvent.TransportEvent.Event.IcdcAlert.Type",
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
                  name: "Type",
                  value: [
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "NONE",
                      number: 0,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "DETECTED",
                      number: 1,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "CLEARED",
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
              name: "DeviceChange",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "type",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_ENUM,
                  type_name: ".WAArmadilloTransportEvent.TransportEvent.Event.DeviceChange.Type",
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "type",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "deviceName",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "deviceName",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "devicePlatform",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "devicePlatform",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "deviceModel",
                  extendee: nil,
                  number: 4,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "deviceModel",
                  proto3_optional: nil,
                  __unknown_fields__: []
                }
              ],
              nested_type: [],
              enum_type: [
                %Google.Protobuf.EnumDescriptorProto{
                  name: "Type",
                  value: [
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "NONE",
                      number: 0,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "ADDED",
                      number: 1,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "REMOVED",
                      number: 2,
                      options: nil,
                      __unknown_fields__: []
                    },
                    %Google.Protobuf.EnumValueDescriptorProto{
                      name: "REPLACED",
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
              name: "event",
              options: nil,
              __unknown_fields__: []
            }
          ],
          reserved_range: [],
          reserved_name: [],
          __unknown_fields__: []
        },
        %Google.Protobuf.DescriptorProto{
          name: "Placeholder",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "type",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAArmadilloTransportEvent.TransportEvent.Placeholder.Type",
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
              name: "Type",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "DECRYPTION_FAILURE",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "UNAVAILABLE_MESSAGE",
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

  field(:placeholder, 1,
    optional: true,
    type: WAArmadilloTransportEvent.TransportEvent.Placeholder,
    oneof: 0
  )

  field(:event, 2, optional: true, type: WAArmadilloTransportEvent.TransportEvent.Event, oneof: 0)
end
