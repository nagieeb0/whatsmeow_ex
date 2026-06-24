defmodule WAWebProtobufsWa6.HandshakeMessage.HandshakePqMode do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWa6.HandshakeMessage.HandshakePqMode",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "HandshakePqMode",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "HANDSHAKE_PQ_MODE_UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "XXKEM",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "XXKEM_FS",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WA_CLASSICAL",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WA_PQ",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IKKEM",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IKKEM_FS",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "XXKEM_2",
          number: 7,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IKKEM_2",
          number: 8,
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

  field(:HANDSHAKE_PQ_MODE_UNKNOWN, 0)
  field(:XXKEM, 1)
  field(:XXKEM_FS, 2)
  field(:WA_CLASSICAL, 3)
  field(:WA_PQ, 4)
  field(:IKKEM, 5)
  field(:IKKEM_FS, 6)
  field(:XXKEM_2, 7)
  field(:IKKEM_2, 8)
end

defmodule WAWebProtobufsWa6.ClientPayload.TrafficAnonymization do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWa6.ClientPayload.TrafficAnonymization",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "TrafficAnonymization",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "OFF",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "STANDARD",
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

  field(:OFF, 0)
  field(:STANDARD, 1)
end

defmodule WAWebProtobufsWa6.ClientPayload.AccountType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWa6.ClientPayload.AccountType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "AccountType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DEFAULT",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GUEST",
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
  field(:GUEST, 1)
end

defmodule WAWebProtobufsWa6.ClientPayload.Product do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWa6.ClientPayload.Product",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Product",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WHATSAPP",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MESSENGER",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INTEROP",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INTEROP_MSGR",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WHATSAPP_LID",
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

  field(:WHATSAPP, 0)
  field(:MESSENGER, 1)
  field(:INTEROP, 2)
  field(:INTEROP_MSGR, 3)
  field(:WHATSAPP_LID, 4)
end

defmodule WAWebProtobufsWa6.ClientPayload.ConnectType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWa6.ClientPayload.ConnectType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ConnectType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CELLULAR_UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WIFI_UNKNOWN",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CELLULAR_EDGE",
          number: 100,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CELLULAR_IDEN",
          number: 101,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CELLULAR_UMTS",
          number: 102,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CELLULAR_EVDO",
          number: 103,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CELLULAR_GPRS",
          number: 104,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CELLULAR_HSDPA",
          number: 105,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CELLULAR_HSUPA",
          number: 106,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CELLULAR_HSPA",
          number: 107,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CELLULAR_CDMA",
          number: 108,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CELLULAR_1XRTT",
          number: 109,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CELLULAR_EHRPD",
          number: 110,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CELLULAR_LTE",
          number: 111,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CELLULAR_HSPAP",
          number: 112,
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

  field(:CELLULAR_UNKNOWN, 0)
  field(:WIFI_UNKNOWN, 1)
  field(:CELLULAR_EDGE, 100)
  field(:CELLULAR_IDEN, 101)
  field(:CELLULAR_UMTS, 102)
  field(:CELLULAR_EVDO, 103)
  field(:CELLULAR_GPRS, 104)
  field(:CELLULAR_HSDPA, 105)
  field(:CELLULAR_HSUPA, 106)
  field(:CELLULAR_HSPA, 107)
  field(:CELLULAR_CDMA, 108)
  field(:CELLULAR_1XRTT, 109)
  field(:CELLULAR_EHRPD, 110)
  field(:CELLULAR_LTE, 111)
  field(:CELLULAR_HSPAP, 112)
end

defmodule WAWebProtobufsWa6.ClientPayload.ConnectReason do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWa6.ClientPayload.ConnectReason",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ConnectReason",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PUSH",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "USER_ACTIVATED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SCHEDULED",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ERROR_RECONNECT",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NETWORK_SWITCH",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PING_RECONNECT",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN",
          number: 6,
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

  field(:PUSH, 0)
  field(:USER_ACTIVATED, 1)
  field(:SCHEDULED, 2)
  field(:ERROR_RECONNECT, 3)
  field(:NETWORK_SWITCH, 4)
  field(:PING_RECONNECT, 5)
  field(:UNKNOWN, 6)
end

defmodule WAWebProtobufsWa6.ClientPayload.IOSAppExtension do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWa6.ClientPayload.IOSAppExtension",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "IOSAppExtension",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SHARE_EXTENSION",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SERVICE_EXTENSION",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INTENTS_EXTENSION",
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

  field(:SHARE_EXTENSION, 0)
  field(:SERVICE_EXTENSION, 1)
  field(:INTENTS_EXTENSION, 2)
end

defmodule WAWebProtobufsWa6.ClientPayload.DNSSource.DNSResolutionMethod do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWa6.ClientPayload.DNSSource.DNSResolutionMethod",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "DNSResolutionMethod",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SYSTEM",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GOOGLE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "HARDCODED",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "OVERRIDE",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FALLBACK",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MNS",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MNS_SECONDARY",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SOCKS_PROXY",
          number: 7,
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

  field(:SYSTEM, 0)
  field(:GOOGLE, 1)
  field(:HARDCODED, 2)
  field(:OVERRIDE, 3)
  field(:FALLBACK, 4)
  field(:MNS, 5)
  field(:MNS_SECONDARY, 6)
  field(:SOCKS_PROXY, 7)
end

defmodule WAWebProtobufsWa6.ClientPayload.WebInfo.WebSubPlatform do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWa6.ClientPayload.WebInfo.WebSubPlatform",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "WebSubPlatform",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WEB_BROWSER",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "APP_STORE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WIN_STORE",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DARWIN",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WIN32",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WIN_HYBRID",
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

  field(:WEB_BROWSER, 0)
  field(:APP_STORE, 1)
  field(:WIN_STORE, 2)
  field(:DARWIN, 3)
  field(:WIN32, 4)
  field(:WIN_HYBRID, 5)
end

defmodule WAWebProtobufsWa6.ClientPayload.UserAgent.DeviceType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWa6.ClientPayload.UserAgent.DeviceType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "DeviceType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PHONE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TABLET",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DESKTOP",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WEARABLE",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VR",
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

  field(:PHONE, 0)
  field(:TABLET, 1)
  field(:DESKTOP, 2)
  field(:WEARABLE, 3)
  field(:VR, 4)
end

defmodule WAWebProtobufsWa6.ClientPayload.UserAgent.DistributionChannel do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWa6.ClientPayload.UserAgent.DistributionChannel",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "DistributionChannel",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "APPSTORE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WEBSITE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TESTFLIGHT",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INTERNAL",
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

  field(:APPSTORE, 0)
  field(:WEBSITE, 1)
  field(:TESTFLIGHT, 2)
  field(:INTERNAL, 3)
end

defmodule WAWebProtobufsWa6.ClientPayload.UserAgent.ReleaseChannel do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWa6.ClientPayload.UserAgent.ReleaseChannel",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ReleaseChannel",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RELEASE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BETA",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ALPHA",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DEBUG",
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

  field(:RELEASE, 0)
  field(:BETA, 1)
  field(:ALPHA, 2)
  field(:DEBUG, 3)
end

defmodule WAWebProtobufsWa6.ClientPayload.UserAgent.Platform do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWa6.ClientPayload.UserAgent.Platform",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Platform",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ANDROID",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IOS",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WINDOWS_PHONE",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLACKBERRY",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLACKBERRYX",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "S40",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "S60",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PYTHON_CLIENT",
          number: 7,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TIZEN",
          number: 8,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ENTERPRISE",
          number: 9,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SMB_ANDROID",
          number: 10,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "KAIOS",
          number: 11,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SMB_IOS",
          number: 12,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WINDOWS",
          number: 13,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WEB",
          number: 14,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PORTAL",
          number: 15,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GREEN_ANDROID",
          number: 16,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GREEN_IPHONE",
          number: 17,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_ANDROID",
          number: 18,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_IPHONE",
          number: 19,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FBLITE_ANDROID",
          number: 20,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MLITE_ANDROID",
          number: 21,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IGLITE_ANDROID",
          number: 22,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAGE",
          number: 23,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MACOS",
          number: 24,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "OCULUS_MSG",
          number: 25,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "OCULUS_CALL",
          number: 26,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MILAN",
          number: 27,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CAPI",
          number: 28,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WEAROS",
          number: 29,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ARDEVICE",
          number: 30,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VRDEVICE",
          number: 31,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_WEB",
          number: 32,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IPAD",
          number: 33,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "TEST",
          number: 34,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SMART_GLASSES",
          number: 35,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_VR",
          number: 36,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AR_WRIST",
          number: 37,
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

  field(:ANDROID, 0)
  field(:IOS, 1)
  field(:WINDOWS_PHONE, 2)
  field(:BLACKBERRY, 3)
  field(:BLACKBERRYX, 4)
  field(:S40, 5)
  field(:S60, 6)
  field(:PYTHON_CLIENT, 7)
  field(:TIZEN, 8)
  field(:ENTERPRISE, 9)
  field(:SMB_ANDROID, 10)
  field(:KAIOS, 11)
  field(:SMB_IOS, 12)
  field(:WINDOWS, 13)
  field(:WEB, 14)
  field(:PORTAL, 15)
  field(:GREEN_ANDROID, 16)
  field(:GREEN_IPHONE, 17)
  field(:BLUE_ANDROID, 18)
  field(:BLUE_IPHONE, 19)
  field(:FBLITE_ANDROID, 20)
  field(:MLITE_ANDROID, 21)
  field(:IGLITE_ANDROID, 22)
  field(:PAGE, 23)
  field(:MACOS, 24)
  field(:OCULUS_MSG, 25)
  field(:OCULUS_CALL, 26)
  field(:MILAN, 27)
  field(:CAPI, 28)
  field(:WEAROS, 29)
  field(:ARDEVICE, 30)
  field(:VRDEVICE, 31)
  field(:BLUE_WEB, 32)
  field(:IPAD, 33)
  field(:TEST, 34)
  field(:SMART_GLASSES, 35)
  field(:BLUE_VR, 36)
  field(:AR_WRIST, 37)
end

defmodule WAWebProtobufsWa6.HandshakeMessage.ClientFinish do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWa6.HandshakeMessage.ClientFinish",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ClientFinish",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "static",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "static",
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
          name: "extendedCiphertext",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "extendedCiphertext",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "paddedBytes",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "paddedBytes",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "simulateXxkemFs",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "simulateXxkemFs",
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

  field(:static, 1, optional: true, type: :bytes)
  field(:payload, 2, optional: true, type: :bytes)
  field(:extendedCiphertext, 3, optional: true, type: :bytes)
  field(:paddedBytes, 4, optional: true, type: :bytes)
  field(:simulateXxkemFs, 5, optional: true, type: :bool)
end

defmodule WAWebProtobufsWa6.HandshakeMessage.ServerHello do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWa6.HandshakeMessage.ServerHello",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ServerHello",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeral",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeral",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "static",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "static",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "payload",
          extendee: nil,
          number: 3,
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
          name: "extendedStatic",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "extendedStatic",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "paddingBytes",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "paddingBytes",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "extendedCiphertext",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "extendedCiphertext",
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

  field(:ephemeral, 1, optional: true, type: :bytes)
  field(:static, 2, optional: true, type: :bytes)
  field(:payload, 3, optional: true, type: :bytes)
  field(:extendedStatic, 4, optional: true, type: :bytes)
  field(:paddingBytes, 5, optional: true, type: :bytes)
  field(:extendedCiphertext, 6, optional: true, type: :bytes)
end

defmodule WAWebProtobufsWa6.HandshakeMessage.ClientHello do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWa6.HandshakeMessage.ClientHello",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ClientHello",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeral",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeral",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "static",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "static",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "payload",
          extendee: nil,
          number: 3,
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
          name: "useExtended",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "useExtended",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "extendedCiphertext",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "extendedCiphertext",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "paddedBytes",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "paddedBytes",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sendServerHelloPaddedBytes",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sendServerHelloPaddedBytes",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "simulateXxkemFs",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "simulateXxkemFs",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pqMode",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWa6.HandshakeMessage.HandshakePqMode",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pqMode",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "extendedEphemeral",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "extendedEphemeral",
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

  field(:ephemeral, 1, optional: true, type: :bytes)
  field(:static, 2, optional: true, type: :bytes)
  field(:payload, 3, optional: true, type: :bytes)
  field(:useExtended, 4, optional: true, type: :bool)
  field(:extendedCiphertext, 5, optional: true, type: :bytes)
  field(:paddedBytes, 6, optional: true, type: :bytes)
  field(:sendServerHelloPaddedBytes, 7, optional: true, type: :bool)
  field(:simulateXxkemFs, 8, optional: true, type: :bool)

  field(:pqMode, 9,
    optional: true,
    type: WAWebProtobufsWa6.HandshakeMessage.HandshakePqMode,
    enum: true
  )

  field(:extendedEphemeral, 10, optional: true, type: :bytes)
end

defmodule WAWebProtobufsWa6.HandshakeMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWa6.HandshakeMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "HandshakeMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "clientHello",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWa6.HandshakeMessage.ClientHello",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "clientHello",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "serverHello",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWa6.HandshakeMessage.ServerHello",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "serverHello",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "clientFinish",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWa6.HandshakeMessage.ClientFinish",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "clientFinish",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "ClientFinish",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "static",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "static",
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
              name: "extendedCiphertext",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "extendedCiphertext",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "paddedBytes",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "paddedBytes",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "simulateXxkemFs",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "simulateXxkemFs",
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
          name: "ServerHello",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "ephemeral",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "ephemeral",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "static",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "static",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "payload",
              extendee: nil,
              number: 3,
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
              name: "extendedStatic",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "extendedStatic",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "paddingBytes",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "paddingBytes",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "extendedCiphertext",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "extendedCiphertext",
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
          name: "ClientHello",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "ephemeral",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "ephemeral",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "static",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "static",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "payload",
              extendee: nil,
              number: 3,
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
              name: "useExtended",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "useExtended",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "extendedCiphertext",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "extendedCiphertext",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "paddedBytes",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "paddedBytes",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "sendServerHelloPaddedBytes",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "sendServerHelloPaddedBytes",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "simulateXxkemFs",
              extendee: nil,
              number: 8,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "simulateXxkemFs",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "pqMode",
              extendee: nil,
              number: 9,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAWebProtobufsWa6.HandshakeMessage.HandshakePqMode",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "pqMode",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "extendedEphemeral",
              extendee: nil,
              number: 10,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "extendedEphemeral",
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
          name: "HandshakePqMode",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "HANDSHAKE_PQ_MODE_UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "XXKEM",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "XXKEM_FS",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WA_CLASSICAL",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WA_PQ",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IKKEM",
              number: 5,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IKKEM_FS",
              number: 6,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "XXKEM_2",
              number: 7,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IKKEM_2",
              number: 8,
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

  field(:clientHello, 2, optional: true, type: WAWebProtobufsWa6.HandshakeMessage.ClientHello)
  field(:serverHello, 3, optional: true, type: WAWebProtobufsWa6.HandshakeMessage.ServerHello)
  field(:clientFinish, 4, optional: true, type: WAWebProtobufsWa6.HandshakeMessage.ClientFinish)
end

defmodule WAWebProtobufsWa6.ClientPayload.DNSSource do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWa6.ClientPayload.DNSSource",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "DNSSource",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "dnsMethod",
          extendee: nil,
          number: 15,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWa6.ClientPayload.DNSSource.DNSResolutionMethod",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "dnsMethod",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "appCached",
          extendee: nil,
          number: 16,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "appCached",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "DNSResolutionMethod",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SYSTEM",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GOOGLE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "HARDCODED",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "OVERRIDE",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FALLBACK",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MNS",
              number: 5,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MNS_SECONDARY",
              number: 6,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SOCKS_PROXY",
              number: 7,
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

  field(:dnsMethod, 15,
    optional: true,
    type: WAWebProtobufsWa6.ClientPayload.DNSSource.DNSResolutionMethod,
    enum: true
  )

  field(:appCached, 16, optional: true, type: :bool)
end

defmodule WAWebProtobufsWa6.ClientPayload.WebInfo.WebdPayload do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWa6.ClientPayload.WebInfo.WebdPayload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "WebdPayload",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "usesParticipantInKey",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "usesParticipantInKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "supportsStarredMessages",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "supportsStarredMessages",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "supportsDocumentMessages",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "supportsDocumentMessages",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "supportsURLMessages",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "supportsURLMessages",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "supportsMediaRetry",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "supportsMediaRetry",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "supportsE2EImage",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "supportsE2EImage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "supportsE2EVideo",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "supportsE2EVideo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "supportsE2EAudio",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "supportsE2EAudio",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "supportsE2EDocument",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "supportsE2EDocument",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "documentTypes",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "documentTypes",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "features",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "features",
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

  field(:usesParticipantInKey, 1, optional: true, type: :bool)
  field(:supportsStarredMessages, 2, optional: true, type: :bool)
  field(:supportsDocumentMessages, 3, optional: true, type: :bool)
  field(:supportsURLMessages, 4, optional: true, type: :bool)
  field(:supportsMediaRetry, 5, optional: true, type: :bool)
  field(:supportsE2EImage, 6, optional: true, type: :bool)
  field(:supportsE2EVideo, 7, optional: true, type: :bool)
  field(:supportsE2EAudio, 8, optional: true, type: :bool)
  field(:supportsE2EDocument, 9, optional: true, type: :bool)
  field(:documentTypes, 10, optional: true, type: :string)
  field(:features, 11, optional: true, type: :bytes)
end

defmodule WAWebProtobufsWa6.ClientPayload.WebInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWa6.ClientPayload.WebInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "WebInfo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "refToken",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "refToken",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "version",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "version",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "webdPayload",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWa6.ClientPayload.WebInfo.WebdPayload",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "webdPayload",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "webSubPlatform",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWa6.ClientPayload.WebInfo.WebSubPlatform",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "webSubPlatform",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "browser",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "browser",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "browserVersion",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "browserVersion",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "WebdPayload",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "usesParticipantInKey",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "usesParticipantInKey",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "supportsStarredMessages",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "supportsStarredMessages",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "supportsDocumentMessages",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "supportsDocumentMessages",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "supportsURLMessages",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "supportsURLMessages",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "supportsMediaRetry",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "supportsMediaRetry",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "supportsE2EImage",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "supportsE2EImage",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "supportsE2EVideo",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "supportsE2EVideo",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "supportsE2EAudio",
              extendee: nil,
              number: 8,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "supportsE2EAudio",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "supportsE2EDocument",
              extendee: nil,
              number: 9,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "supportsE2EDocument",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "documentTypes",
              extendee: nil,
              number: 10,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "documentTypes",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "features",
              extendee: nil,
              number: 11,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "features",
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
          name: "WebSubPlatform",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WEB_BROWSER",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "APP_STORE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WIN_STORE",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DARWIN",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WIN32",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WIN_HYBRID",
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

  field(:refToken, 1, optional: true, type: :string)
  field(:version, 2, optional: true, type: :string)
  field(:webdPayload, 3, optional: true, type: WAWebProtobufsWa6.ClientPayload.WebInfo.WebdPayload)

  field(:webSubPlatform, 4,
    optional: true,
    type: WAWebProtobufsWa6.ClientPayload.WebInfo.WebSubPlatform,
    enum: true
  )

  field(:browser, 5, optional: true, type: :string)
  field(:browserVersion, 6, optional: true, type: :string)
end

defmodule WAWebProtobufsWa6.ClientPayload.UserAgent.AppVersion do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWa6.ClientPayload.UserAgent.AppVersion",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "AppVersion",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "primary",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "primary",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "secondary",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "secondary",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "tertiary",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "tertiary",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "quaternary",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "quaternary",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "quinary",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "quinary",
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

  field(:primary, 1, optional: true, type: :uint32)
  field(:secondary, 2, optional: true, type: :uint32)
  field(:tertiary, 3, optional: true, type: :uint32)
  field(:quaternary, 4, optional: true, type: :uint32)
  field(:quinary, 5, optional: true, type: :uint32)
end

defmodule WAWebProtobufsWa6.ClientPayload.UserAgent do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWa6.ClientPayload.UserAgent",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "UserAgent",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "platform",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWa6.ClientPayload.UserAgent.Platform",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "platform",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "appVersion",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWa6.ClientPayload.UserAgent.AppVersion",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "appVersion",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mcc",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mcc",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mnc",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mnc",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "osVersion",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "osVersion",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "manufacturer",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "manufacturer",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "device",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "device",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "osBuildNumber",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "osBuildNumber",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "phoneID",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "phoneID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "releaseChannel",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWa6.ClientPayload.UserAgent.ReleaseChannel",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "releaseChannel",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "localeLanguageIso6391",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "localeLanguageIso6391",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "localeCountryIso31661Alpha2",
          extendee: nil,
          number: 12,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "localeCountryIso31661Alpha2",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deviceBoard",
          extendee: nil,
          number: 13,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deviceBoard",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deviceExpID",
          extendee: nil,
          number: 14,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deviceExpID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deviceType",
          extendee: nil,
          number: 15,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWa6.ClientPayload.UserAgent.DeviceType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deviceType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deviceModelType",
          extendee: nil,
          number: 16,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deviceModelType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "distributionChannel",
          extendee: nil,
          number: 17,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWa6.ClientPayload.UserAgent.DistributionChannel",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "distributionChannel",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "AppVersion",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "primary",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "primary",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "secondary",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "secondary",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "tertiary",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "tertiary",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "quaternary",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "quaternary",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "quinary",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT32,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "quinary",
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
          name: "DeviceType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PHONE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TABLET",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DESKTOP",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WEARABLE",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VR",
              number: 4,
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
          name: "DistributionChannel",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "APPSTORE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WEBSITE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TESTFLIGHT",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INTERNAL",
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
          name: "ReleaseChannel",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RELEASE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BETA",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ALPHA",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DEBUG",
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
          name: "Platform",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ANDROID",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IOS",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WINDOWS_PHONE",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLACKBERRY",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLACKBERRYX",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "S40",
              number: 5,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "S60",
              number: 6,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PYTHON_CLIENT",
              number: 7,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TIZEN",
              number: 8,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ENTERPRISE",
              number: 9,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SMB_ANDROID",
              number: 10,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "KAIOS",
              number: 11,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SMB_IOS",
              number: 12,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WINDOWS",
              number: 13,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WEB",
              number: 14,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PORTAL",
              number: 15,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GREEN_ANDROID",
              number: 16,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GREEN_IPHONE",
              number: 17,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_ANDROID",
              number: 18,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_IPHONE",
              number: 19,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FBLITE_ANDROID",
              number: 20,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MLITE_ANDROID",
              number: 21,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IGLITE_ANDROID",
              number: 22,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAGE",
              number: 23,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MACOS",
              number: 24,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "OCULUS_MSG",
              number: 25,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "OCULUS_CALL",
              number: 26,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MILAN",
              number: 27,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CAPI",
              number: 28,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WEAROS",
              number: 29,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ARDEVICE",
              number: 30,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VRDEVICE",
              number: 31,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_WEB",
              number: 32,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IPAD",
              number: 33,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "TEST",
              number: 34,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SMART_GLASSES",
              number: 35,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_VR",
              number: 36,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AR_WRIST",
              number: 37,
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

  field(:platform, 1,
    optional: true,
    type: WAWebProtobufsWa6.ClientPayload.UserAgent.Platform,
    enum: true
  )

  field(:appVersion, 2, optional: true, type: WAWebProtobufsWa6.ClientPayload.UserAgent.AppVersion)
  field(:mcc, 3, optional: true, type: :string)
  field(:mnc, 4, optional: true, type: :string)
  field(:osVersion, 5, optional: true, type: :string)
  field(:manufacturer, 6, optional: true, type: :string)
  field(:device, 7, optional: true, type: :string)
  field(:osBuildNumber, 8, optional: true, type: :string)
  field(:phoneID, 9, optional: true, type: :string)

  field(:releaseChannel, 10,
    optional: true,
    type: WAWebProtobufsWa6.ClientPayload.UserAgent.ReleaseChannel,
    enum: true
  )

  field(:localeLanguageIso6391, 11, optional: true, type: :string)
  field(:localeCountryIso31661Alpha2, 12, optional: true, type: :string)
  field(:deviceBoard, 13, optional: true, type: :string)
  field(:deviceExpID, 14, optional: true, type: :string)

  field(:deviceType, 15,
    optional: true,
    type: WAWebProtobufsWa6.ClientPayload.UserAgent.DeviceType,
    enum: true
  )

  field(:deviceModelType, 16, optional: true, type: :string)

  field(:distributionChannel, 17,
    optional: true,
    type: WAWebProtobufsWa6.ClientPayload.UserAgent.DistributionChannel,
    enum: true
  )
end

defmodule WAWebProtobufsWa6.ClientPayload.InteropData do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWa6.ClientPayload.InteropData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "InteropData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "accountID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "accountID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "token",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "token",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "enableReadReceipts",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "enableReadReceipts",
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

  field(:accountID, 1, optional: true, type: :uint64)
  field(:token, 2, optional: true, type: :bytes)
  field(:enableReadReceipts, 3, optional: true, type: :bool)
end

defmodule WAWebProtobufsWa6.ClientPayload.DevicePairingRegistrationData do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWa6.ClientPayload.DevicePairingRegistrationData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "DevicePairingRegistrationData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "eRegid",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "eRegid",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "eKeytype",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "eKeytype",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "eIdent",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "eIdent",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "eSkeyID",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "eSkeyID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "eSkeyVal",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "eSkeyVal",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "eSkeySig",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "eSkeySig",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "buildHash",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "buildHash",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deviceProps",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deviceProps",
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

  field(:eRegid, 1, optional: true, type: :bytes)
  field(:eKeytype, 2, optional: true, type: :bytes)
  field(:eIdent, 3, optional: true, type: :bytes)
  field(:eSkeyID, 4, optional: true, type: :bytes)
  field(:eSkeyVal, 5, optional: true, type: :bytes)
  field(:eSkeySig, 6, optional: true, type: :bytes)
  field(:buildHash, 7, optional: true, type: :bytes)
  field(:deviceProps, 8, optional: true, type: :bytes)
end

defmodule WAWebProtobufsWa6.ClientPayload do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWa6.ClientPayload",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ClientPayload",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "username",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "username",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "passive",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "passive",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "userAgent",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWa6.ClientPayload.UserAgent",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "userAgent",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "webInfo",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWa6.ClientPayload.WebInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "webInfo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pushName",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pushName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "sessionID",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_SFIXED32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "sessionID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "shortConnect",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "shortConnect",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "connectType",
          extendee: nil,
          number: 12,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWa6.ClientPayload.ConnectType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "connectType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "connectReason",
          extendee: nil,
          number: 13,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWa6.ClientPayload.ConnectReason",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "connectReason",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "shards",
          extendee: nil,
          number: 14,
          label: :LABEL_REPEATED,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "shards",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "dnsSource",
          extendee: nil,
          number: 15,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWa6.ClientPayload.DNSSource",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "dnsSource",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "connectAttemptCount",
          extendee: nil,
          number: 16,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "connectAttemptCount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "device",
          extendee: nil,
          number: 18,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "device",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "devicePairingData",
          extendee: nil,
          number: 19,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWa6.ClientPayload.DevicePairingRegistrationData",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "devicePairingData",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "product",
          extendee: nil,
          number: 20,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWa6.ClientPayload.Product",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "product",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fbCat",
          extendee: nil,
          number: 21,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fbCat",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fbUserAgent",
          extendee: nil,
          number: 22,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fbUserAgent",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "oc",
          extendee: nil,
          number: 23,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "oc",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lc",
          extendee: nil,
          number: 24,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lc",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "iosAppExtension",
          extendee: nil,
          number: 30,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWa6.ClientPayload.IOSAppExtension",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "iosAppExtension",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fbAppID",
          extendee: nil,
          number: 31,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fbAppID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "fbDeviceID",
          extendee: nil,
          number: 32,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "fbDeviceID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pull",
          extendee: nil,
          number: 33,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pull",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "paddingBytes",
          extendee: nil,
          number: 34,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "paddingBytes",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "yearClass",
          extendee: nil,
          number: 36,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "yearClass",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "memClass",
          extendee: nil,
          number: 37,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "memClass",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "interopData",
          extendee: nil,
          number: 38,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWa6.ClientPayload.InteropData",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "interopData",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "trafficAnonymization",
          extendee: nil,
          number: 40,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWa6.ClientPayload.TrafficAnonymization",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "trafficAnonymization",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "lidDbMigrated",
          extendee: nil,
          number: 41,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "lidDbMigrated",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "accountType",
          extendee: nil,
          number: 42,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWa6.ClientPayload.AccountType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "accountType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "connectionSequenceInfo",
          extendee: nil,
          number: 43,
          label: :LABEL_OPTIONAL,
          type: :TYPE_SFIXED32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "connectionSequenceInfo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "paaLink",
          extendee: nil,
          number: 44,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "paaLink",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "preacksCount",
          extendee: nil,
          number: 45,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "preacksCount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "processingQueueSize",
          extendee: nil,
          number: 46,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "processingQueueSize",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pairedPeripherals",
          extendee: nil,
          number: 47,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pairedPeripherals",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "testIsolationID",
          extendee: nil,
          number: 48,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "testIsolationID",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [
        %Google.Protobuf.DescriptorProto{
          name: "DNSSource",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "dnsMethod",
              extendee: nil,
              number: 15,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAWebProtobufsWa6.ClientPayload.DNSSource.DNSResolutionMethod",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "dnsMethod",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "appCached",
              extendee: nil,
              number: 16,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "appCached",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [],
          enum_type: [
            %Google.Protobuf.EnumDescriptorProto{
              name: "DNSResolutionMethod",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "SYSTEM",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "GOOGLE",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "HARDCODED",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "OVERRIDE",
                  number: 3,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "FALLBACK",
                  number: 4,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "MNS",
                  number: 5,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "MNS_SECONDARY",
                  number: 6,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "SOCKS_PROXY",
                  number: 7,
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
          name: "WebInfo",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "refToken",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "refToken",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "version",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "version",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "webdPayload",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAWebProtobufsWa6.ClientPayload.WebInfo.WebdPayload",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "webdPayload",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "webSubPlatform",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAWebProtobufsWa6.ClientPayload.WebInfo.WebSubPlatform",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "webSubPlatform",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "browser",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "browser",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "browserVersion",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "browserVersion",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "WebdPayload",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "usesParticipantInKey",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BOOL,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "usesParticipantInKey",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "supportsStarredMessages",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BOOL,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "supportsStarredMessages",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "supportsDocumentMessages",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BOOL,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "supportsDocumentMessages",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "supportsURLMessages",
                  extendee: nil,
                  number: 4,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BOOL,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "supportsURLMessages",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "supportsMediaRetry",
                  extendee: nil,
                  number: 5,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BOOL,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "supportsMediaRetry",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "supportsE2EImage",
                  extendee: nil,
                  number: 6,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BOOL,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "supportsE2EImage",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "supportsE2EVideo",
                  extendee: nil,
                  number: 7,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BOOL,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "supportsE2EVideo",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "supportsE2EAudio",
                  extendee: nil,
                  number: 8,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BOOL,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "supportsE2EAudio",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "supportsE2EDocument",
                  extendee: nil,
                  number: 9,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BOOL,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "supportsE2EDocument",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "documentTypes",
                  extendee: nil,
                  number: 10,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_STRING,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "documentTypes",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "features",
                  extendee: nil,
                  number: 11,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_BYTES,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "features",
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
              name: "WebSubPlatform",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "WEB_BROWSER",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "APP_STORE",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "WIN_STORE",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "DARWIN",
                  number: 3,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "WIN32",
                  number: 4,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "WIN_HYBRID",
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
        },
        %Google.Protobuf.DescriptorProto{
          name: "UserAgent",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "platform",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAWebProtobufsWa6.ClientPayload.UserAgent.Platform",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "platform",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "appVersion",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_MESSAGE,
              type_name: ".WAWebProtobufsWa6.ClientPayload.UserAgent.AppVersion",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "appVersion",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "mcc",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "mcc",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "mnc",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "mnc",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "osVersion",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "osVersion",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "manufacturer",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "manufacturer",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "device",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "device",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "osBuildNumber",
              extendee: nil,
              number: 8,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "osBuildNumber",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "phoneID",
              extendee: nil,
              number: 9,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "phoneID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "releaseChannel",
              extendee: nil,
              number: 10,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAWebProtobufsWa6.ClientPayload.UserAgent.ReleaseChannel",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "releaseChannel",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "localeLanguageIso6391",
              extendee: nil,
              number: 11,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "localeLanguageIso6391",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "localeCountryIso31661Alpha2",
              extendee: nil,
              number: 12,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "localeCountryIso31661Alpha2",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "deviceBoard",
              extendee: nil,
              number: 13,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "deviceBoard",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "deviceExpID",
              extendee: nil,
              number: 14,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "deviceExpID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "deviceType",
              extendee: nil,
              number: 15,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAWebProtobufsWa6.ClientPayload.UserAgent.DeviceType",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "deviceType",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "deviceModelType",
              extendee: nil,
              number: 16,
              label: :LABEL_OPTIONAL,
              type: :TYPE_STRING,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "deviceModelType",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "distributionChannel",
              extendee: nil,
              number: 17,
              label: :LABEL_OPTIONAL,
              type: :TYPE_ENUM,
              type_name: ".WAWebProtobufsWa6.ClientPayload.UserAgent.DistributionChannel",
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "distributionChannel",
              proto3_optional: nil,
              __unknown_fields__: []
            }
          ],
          nested_type: [
            %Google.Protobuf.DescriptorProto{
              name: "AppVersion",
              field: [
                %Google.Protobuf.FieldDescriptorProto{
                  name: "primary",
                  extendee: nil,
                  number: 1,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_UINT32,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "primary",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "secondary",
                  extendee: nil,
                  number: 2,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_UINT32,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "secondary",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "tertiary",
                  extendee: nil,
                  number: 3,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_UINT32,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "tertiary",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "quaternary",
                  extendee: nil,
                  number: 4,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_UINT32,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "quaternary",
                  proto3_optional: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.FieldDescriptorProto{
                  name: "quinary",
                  extendee: nil,
                  number: 5,
                  label: :LABEL_OPTIONAL,
                  type: :TYPE_UINT32,
                  type_name: nil,
                  default_value: nil,
                  options: nil,
                  oneof_index: nil,
                  json_name: "quinary",
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
              name: "DeviceType",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "PHONE",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TABLET",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "DESKTOP",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "WEARABLE",
                  number: 3,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "VR",
                  number: 4,
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
              name: "DistributionChannel",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "APPSTORE",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "WEBSITE",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TESTFLIGHT",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "INTERNAL",
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
              name: "ReleaseChannel",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "RELEASE",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "BETA",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "ALPHA",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "DEBUG",
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
              name: "Platform",
              value: [
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "ANDROID",
                  number: 0,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "IOS",
                  number: 1,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "WINDOWS_PHONE",
                  number: 2,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "BLACKBERRY",
                  number: 3,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "BLACKBERRYX",
                  number: 4,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "S40",
                  number: 5,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "S60",
                  number: 6,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "PYTHON_CLIENT",
                  number: 7,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TIZEN",
                  number: 8,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "ENTERPRISE",
                  number: 9,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "SMB_ANDROID",
                  number: 10,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "KAIOS",
                  number: 11,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "SMB_IOS",
                  number: 12,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "WINDOWS",
                  number: 13,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "WEB",
                  number: 14,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "PORTAL",
                  number: 15,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "GREEN_ANDROID",
                  number: 16,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "GREEN_IPHONE",
                  number: 17,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "BLUE_ANDROID",
                  number: 18,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "BLUE_IPHONE",
                  number: 19,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "FBLITE_ANDROID",
                  number: 20,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "MLITE_ANDROID",
                  number: 21,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "IGLITE_ANDROID",
                  number: 22,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "PAGE",
                  number: 23,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "MACOS",
                  number: 24,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "OCULUS_MSG",
                  number: 25,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "OCULUS_CALL",
                  number: 26,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "MILAN",
                  number: 27,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "CAPI",
                  number: 28,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "WEAROS",
                  number: 29,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "ARDEVICE",
                  number: 30,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "VRDEVICE",
                  number: 31,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "BLUE_WEB",
                  number: 32,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "IPAD",
                  number: 33,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "TEST",
                  number: 34,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "SMART_GLASSES",
                  number: 35,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "BLUE_VR",
                  number: 36,
                  options: nil,
                  __unknown_fields__: []
                },
                %Google.Protobuf.EnumValueDescriptorProto{
                  name: "AR_WRIST",
                  number: 37,
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
          name: "InteropData",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "accountID",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_UINT64,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "accountID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "token",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "token",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "enableReadReceipts",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BOOL,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "enableReadReceipts",
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
          name: "DevicePairingRegistrationData",
          field: [
            %Google.Protobuf.FieldDescriptorProto{
              name: "eRegid",
              extendee: nil,
              number: 1,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "eRegid",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "eKeytype",
              extendee: nil,
              number: 2,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "eKeytype",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "eIdent",
              extendee: nil,
              number: 3,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "eIdent",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "eSkeyID",
              extendee: nil,
              number: 4,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "eSkeyID",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "eSkeyVal",
              extendee: nil,
              number: 5,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "eSkeyVal",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "eSkeySig",
              extendee: nil,
              number: 6,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "eSkeySig",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "buildHash",
              extendee: nil,
              number: 7,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "buildHash",
              proto3_optional: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.FieldDescriptorProto{
              name: "deviceProps",
              extendee: nil,
              number: 8,
              label: :LABEL_OPTIONAL,
              type: :TYPE_BYTES,
              type_name: nil,
              default_value: nil,
              options: nil,
              oneof_index: nil,
              json_name: "deviceProps",
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
          name: "TrafficAnonymization",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "OFF",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "STANDARD",
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
          name: "AccountType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DEFAULT",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GUEST",
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
          name: "Product",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WHATSAPP",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MESSENGER",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INTEROP",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INTEROP_MSGR",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WHATSAPP_LID",
              number: 4,
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
          name: "ConnectType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CELLULAR_UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WIFI_UNKNOWN",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CELLULAR_EDGE",
              number: 100,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CELLULAR_IDEN",
              number: 101,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CELLULAR_UMTS",
              number: 102,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CELLULAR_EVDO",
              number: 103,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CELLULAR_GPRS",
              number: 104,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CELLULAR_HSDPA",
              number: 105,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CELLULAR_HSUPA",
              number: 106,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CELLULAR_HSPA",
              number: 107,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CELLULAR_CDMA",
              number: 108,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CELLULAR_1XRTT",
              number: 109,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CELLULAR_EHRPD",
              number: 110,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CELLULAR_LTE",
              number: 111,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CELLULAR_HSPAP",
              number: 112,
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
          name: "ConnectReason",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PUSH",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "USER_ACTIVATED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SCHEDULED",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ERROR_RECONNECT",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NETWORK_SWITCH",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PING_RECONNECT",
              number: 5,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN",
              number: 6,
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
          name: "IOSAppExtension",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SHARE_EXTENSION",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SERVICE_EXTENSION",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INTENTS_EXTENSION",
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

  field(:username, 1, optional: true, type: :uint64)
  field(:passive, 3, optional: true, type: :bool)
  field(:userAgent, 5, optional: true, type: WAWebProtobufsWa6.ClientPayload.UserAgent)
  field(:webInfo, 6, optional: true, type: WAWebProtobufsWa6.ClientPayload.WebInfo)
  field(:pushName, 7, optional: true, type: :string)
  field(:sessionID, 9, optional: true, type: :sfixed32)
  field(:shortConnect, 10, optional: true, type: :bool)

  field(:connectType, 12,
    optional: true,
    type: WAWebProtobufsWa6.ClientPayload.ConnectType,
    enum: true
  )

  field(:connectReason, 13,
    optional: true,
    type: WAWebProtobufsWa6.ClientPayload.ConnectReason,
    enum: true
  )

  field(:shards, 14, repeated: true, type: :int32)
  field(:dnsSource, 15, optional: true, type: WAWebProtobufsWa6.ClientPayload.DNSSource)
  field(:connectAttemptCount, 16, optional: true, type: :uint32)
  field(:device, 18, optional: true, type: :uint32)

  field(:devicePairingData, 19,
    optional: true,
    type: WAWebProtobufsWa6.ClientPayload.DevicePairingRegistrationData
  )

  field(:product, 20, optional: true, type: WAWebProtobufsWa6.ClientPayload.Product, enum: true)
  field(:fbCat, 21, optional: true, type: :bytes)
  field(:fbUserAgent, 22, optional: true, type: :bytes)
  field(:oc, 23, optional: true, type: :bool)
  field(:lc, 24, optional: true, type: :int32)

  field(:iosAppExtension, 30,
    optional: true,
    type: WAWebProtobufsWa6.ClientPayload.IOSAppExtension,
    enum: true
  )

  field(:fbAppID, 31, optional: true, type: :uint64)
  field(:fbDeviceID, 32, optional: true, type: :bytes)
  field(:pull, 33, optional: true, type: :bool)
  field(:paddingBytes, 34, optional: true, type: :bytes)
  field(:yearClass, 36, optional: true, type: :int32)
  field(:memClass, 37, optional: true, type: :int32)
  field(:interopData, 38, optional: true, type: WAWebProtobufsWa6.ClientPayload.InteropData)

  field(:trafficAnonymization, 40,
    optional: true,
    type: WAWebProtobufsWa6.ClientPayload.TrafficAnonymization,
    enum: true
  )

  field(:lidDbMigrated, 41, optional: true, type: :bool)

  field(:accountType, 42,
    optional: true,
    type: WAWebProtobufsWa6.ClientPayload.AccountType,
    enum: true
  )

  field(:connectionSequenceInfo, 43, optional: true, type: :sfixed32)
  field(:paaLink, 44, optional: true, type: :bool)
  field(:preacksCount, 45, optional: true, type: :int32)
  field(:processingQueueSize, 46, optional: true, type: :int32)
  field(:pairedPeripherals, 47, repeated: true, type: :string)
  field(:testIsolationID, 48, optional: true, type: :bytes)
end
