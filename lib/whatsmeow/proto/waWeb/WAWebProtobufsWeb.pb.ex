defmodule WAWebProtobufsWeb.WebMessageInfo.BizPrivacyStatus do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWeb.WebMessageInfo.BizPrivacyStatus",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "BizPrivacyStatus",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "E2EE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FB",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BSP",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BSP_AND_FB",
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

  field(:E2EE, 0)
  field(:FB, 2)
  field(:BSP, 1)
  field(:BSP_AND_FB, 3)
end

defmodule WAWebProtobufsWeb.WebMessageInfo.StubType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWeb.WebMessageInfo.StubType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "StubType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REVOKE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CIPHERTEXT",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FUTUREPROOF",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NON_VERIFIED_TRANSITION",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNVERIFIED_TRANSITION",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VERIFIED_TRANSITION",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VERIFIED_LOW_UNKNOWN",
          number: 7,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VERIFIED_HIGH",
          number: 8,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VERIFIED_INITIAL_UNKNOWN",
          number: 9,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VERIFIED_INITIAL_LOW",
          number: 10,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VERIFIED_INITIAL_HIGH",
          number: 11,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VERIFIED_TRANSITION_ANY_TO_NONE",
          number: 12,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VERIFIED_TRANSITION_ANY_TO_HIGH",
          number: 13,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VERIFIED_TRANSITION_HIGH_TO_LOW",
          number: 14,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VERIFIED_TRANSITION_HIGH_TO_UNKNOWN",
          number: 15,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VERIFIED_TRANSITION_UNKNOWN_TO_LOW",
          number: 16,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VERIFIED_TRANSITION_LOW_TO_UNKNOWN",
          number: 17,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VERIFIED_TRANSITION_NONE_TO_LOW",
          number: 18,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VERIFIED_TRANSITION_NONE_TO_UNKNOWN",
          number: 19,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_CREATE",
          number: 20,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_CHANGE_SUBJECT",
          number: 21,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_CHANGE_ICON",
          number: 22,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_CHANGE_INVITE_LINK",
          number: 23,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_CHANGE_DESCRIPTION",
          number: 24,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_CHANGE_RESTRICT",
          number: 25,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_CHANGE_ANNOUNCE",
          number: 26,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_PARTICIPANT_ADD",
          number: 27,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_PARTICIPANT_REMOVE",
          number: 28,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_PARTICIPANT_PROMOTE",
          number: 29,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_PARTICIPANT_DEMOTE",
          number: 30,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_PARTICIPANT_INVITE",
          number: 31,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_PARTICIPANT_LEAVE",
          number: 32,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_PARTICIPANT_CHANGE_NUMBER",
          number: 33,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BROADCAST_CREATE",
          number: 34,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BROADCAST_ADD",
          number: 35,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BROADCAST_REMOVE",
          number: 36,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GENERIC_NOTIFICATION",
          number: 37,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "E2E_IDENTITY_CHANGED",
          number: 38,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "E2E_ENCRYPTED",
          number: 39,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CALL_MISSED_VOICE",
          number: 40,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CALL_MISSED_VIDEO",
          number: 41,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INDIVIDUAL_CHANGE_NUMBER",
          number: 42,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_DELETE",
          number: 43,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_ANNOUNCE_MODE_MESSAGE_BOUNCE",
          number: 44,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CALL_MISSED_GROUP_VOICE",
          number: 45,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CALL_MISSED_GROUP_VIDEO",
          number: 46,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_CIPHERTEXT",
          number: 47,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_FUTUREPROOF",
          number: 48,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_TRANSACTION_STATUS_UPDATE_FAILED",
          number: 49,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_TRANSACTION_STATUS_UPDATE_REFUNDED",
          number: 50,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_TRANSACTION_STATUS_UPDATE_REFUND_FAILED",
          number: 51,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_TRANSACTION_STATUS_RECEIVER_PENDING_SETUP",
          number: 52,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_TRANSACTION_STATUS_RECEIVER_SUCCESS_AFTER_HICCUP",
          number: 53,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_ACTION_ACCOUNT_SETUP_REMINDER",
          number: 54,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_ACTION_SEND_PAYMENT_REMINDER",
          number: 55,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_ACTION_SEND_PAYMENT_INVITATION",
          number: 56,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_ACTION_REQUEST_DECLINED",
          number: 57,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_ACTION_REQUEST_EXPIRED",
          number: 58,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_ACTION_REQUEST_CANCELLED",
          number: 59,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_VERIFIED_TRANSITION_TOP_TO_BOTTOM",
          number: 60,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_VERIFIED_TRANSITION_BOTTOM_TO_TOP",
          number: 61,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_INTRO_TOP",
          number: 62,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_INTRO_BOTTOM",
          number: 63,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_NAME_CHANGE",
          number: 64,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_MOVE_TO_CONSUMER_APP",
          number: 65,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_TWO_TIER_MIGRATION_TOP",
          number: 66,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_TWO_TIER_MIGRATION_BOTTOM",
          number: 67,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "OVERSIZED",
          number: 68,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_CHANGE_NO_FREQUENTLY_FORWARDED",
          number: 69,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_V4_ADD_INVITE_SENT",
          number: 70,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_PARTICIPANT_ADD_REQUEST_JOIN",
          number: 71,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CHANGE_EPHEMERAL_SETTING",
          number: 72,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "E2E_DEVICE_CHANGED",
          number: 73,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "VIEWED_ONCE",
          number: 74,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "E2E_ENCRYPTED_NOW",
          number: 75,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_BSP_FB_TO_BSP_PREMISE",
          number: 76,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_BSP_FB_TO_SELF_FB",
          number: 77,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_BSP_FB_TO_SELF_PREMISE",
          number: 78,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_BSP_FB_UNVERIFIED",
          number: 79,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_BSP_FB_UNVERIFIED_TO_SELF_PREMISE_VERIFIED",
          number: 80,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_BSP_FB_VERIFIED",
          number: 81,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_BSP_FB_VERIFIED_TO_SELF_PREMISE_UNVERIFIED",
          number: 82,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_BSP_PREMISE_TO_SELF_PREMISE",
          number: 83,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_BSP_PREMISE_UNVERIFIED",
          number: 84,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_BSP_PREMISE_UNVERIFIED_TO_SELF_PREMISE_VERIFIED",
          number: 85,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_BSP_PREMISE_VERIFIED",
          number: 86,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_BSP_PREMISE_VERIFIED_TO_SELF_PREMISE_UNVERIFIED",
          number: 87,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_CONSUMER_TO_BSP_FB_UNVERIFIED",
          number: 88,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_CONSUMER_TO_BSP_PREMISE_UNVERIFIED",
          number: 89,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_CONSUMER_TO_SELF_FB_UNVERIFIED",
          number: 90,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_CONSUMER_TO_SELF_PREMISE_UNVERIFIED",
          number: 91,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_SELF_FB_TO_BSP_PREMISE",
          number: 92,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_SELF_FB_TO_SELF_PREMISE",
          number: 93,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_SELF_FB_UNVERIFIED",
          number: 94,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_SELF_FB_UNVERIFIED_TO_SELF_PREMISE_VERIFIED",
          number: 95,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_SELF_FB_VERIFIED",
          number: 96,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_SELF_FB_VERIFIED_TO_SELF_PREMISE_UNVERIFIED",
          number: 97,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_SELF_PREMISE_TO_BSP_PREMISE",
          number: 98,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_SELF_PREMISE_UNVERIFIED",
          number: 99,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_SELF_PREMISE_VERIFIED",
          number: 100,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_TO_BSP_FB",
          number: 101,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_TO_CONSUMER",
          number: 102,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_TO_SELF_FB",
          number: 103,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_UNVERIFIED_TO_BSP_FB_VERIFIED",
          number: 104,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_UNVERIFIED_TO_BSP_PREMISE_VERIFIED",
          number: 105,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_UNVERIFIED_TO_SELF_FB_VERIFIED",
          number: 106,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_UNVERIFIED_TO_VERIFIED",
          number: 107,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_VERIFIED_TO_BSP_FB_UNVERIFIED",
          number: 108,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_VERIFIED_TO_BSP_PREMISE_UNVERIFIED",
          number: 109,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_VERIFIED_TO_SELF_FB_UNVERIFIED",
          number: 110,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_VERIFIED_TO_UNVERIFIED",
          number: 111,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_BSP_FB_UNVERIFIED_TO_BSP_PREMISE_VERIFIED",
          number: 112,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_BSP_FB_UNVERIFIED_TO_SELF_FB_VERIFIED",
          number: 113,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_BSP_FB_VERIFIED_TO_BSP_PREMISE_UNVERIFIED",
          number: 114,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_BSP_FB_VERIFIED_TO_SELF_FB_UNVERIFIED",
          number: 115,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_SELF_FB_UNVERIFIED_TO_BSP_PREMISE_VERIFIED",
          number: 116,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLUE_MSG_SELF_FB_VERIFIED_TO_BSP_PREMISE_UNVERIFIED",
          number: 117,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "E2E_IDENTITY_UNAVAILABLE",
          number: 118,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_CREATING",
          number: 119,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_CREATE_FAILED",
          number: 120,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_BOUNCED",
          number: 121,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BLOCK_CONTACT",
          number: 122,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "EPHEMERAL_SETTING_NOT_APPLIED",
          number: 123,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SYNC_FAILED",
          number: 124,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SYNCING",
          number: 125,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_PRIVACY_MODE_INIT_FB",
          number: 126,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_PRIVACY_MODE_INIT_BSP",
          number: 127,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_PRIVACY_MODE_TO_FB",
          number: 128,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_PRIVACY_MODE_TO_BSP",
          number: 129,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DISAPPEARING_MODE",
          number: 130,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "E2E_DEVICE_FETCH_FAILED",
          number: 131,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ADMIN_REVOKE",
          number: 132,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_INVITE_LINK_GROWTH_LOCKED",
          number: 133,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_LINK_PARENT_GROUP",
          number: 134,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_LINK_SIBLING_GROUP",
          number: 135,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_LINK_SUB_GROUP",
          number: 136,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_UNLINK_PARENT_GROUP",
          number: 137,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_UNLINK_SIBLING_GROUP",
          number: 138,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_UNLINK_SUB_GROUP",
          number: 139,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_PARTICIPANT_ACCEPT",
          number: 140,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_PARTICIPANT_LINKED_GROUP_JOIN",
          number: 141,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_CREATE",
          number: 142,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "EPHEMERAL_KEEP_IN_CHAT",
          number: 143,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_MEMBERSHIP_JOIN_APPROVAL_REQUEST",
          number: 144,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_MEMBERSHIP_JOIN_APPROVAL_MODE",
          number: 145,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INTEGRITY_UNLINK_PARENT_GROUP",
          number: 146,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_PARTICIPANT_PROMOTE",
          number: 147,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_PARTICIPANT_DEMOTE",
          number: 148,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_PARENT_GROUP_DELETED",
          number: 149,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_LINK_PARENT_GROUP_MEMBERSHIP_APPROVAL",
          number: 150,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_PARTICIPANT_JOINED_GROUP_AND_PARENT_GROUP",
          number: 151,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MASKED_THREAD_CREATED",
          number: 152,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "MASKED_THREAD_UNMASKED",
          number: 153,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_CHAT_ASSIGNMENT",
          number: 154,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CHAT_PSA",
          number: 155,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CHAT_POLL_CREATION_MESSAGE",
          number: 156,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CAG_MASKED_THREAD_CREATED",
          number: 157,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_PARENT_GROUP_SUBJECT_CHANGED",
          number: 158,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CAG_INVITE_AUTO_ADD",
          number: 159,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_CHAT_ASSIGNMENT_UNASSIGN",
          number: 160,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CAG_INVITE_AUTO_JOINED",
          number: 161,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SCHEDULED_CALL_START_MESSAGE",
          number: 162,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_INVITE_RICH",
          number: 163,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_INVITE_AUTO_ADD_RICH",
          number: 164,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SUB_GROUP_INVITE_RICH",
          number: 165,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SUB_GROUP_PARTICIPANT_ADD_RICH",
          number: 166,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_LINK_PARENT_GROUP_RICH",
          number: 167,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_PARTICIPANT_ADD_RICH",
          number: 168,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SILENCED_UNKNOWN_CALLER_AUDIO",
          number: 169,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SILENCED_UNKNOWN_CALLER_VIDEO",
          number: 170,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_MEMBER_ADD_MODE",
          number: 171,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_MEMBERSHIP_JOIN_APPROVAL_REQUEST_NON_ADMIN_ADD",
          number: 172,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_CHANGE_DESCRIPTION",
          number: 173,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SENDER_INVITE",
          number: 174,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "RECEIVER_INVITE",
          number: 175,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_ALLOW_MEMBER_ADDED_GROUPS",
          number: 176,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PINNED_MESSAGE_IN_CHAT",
          number: 177,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_INVITE_SETUP_INVITER",
          number: 178,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_INVITE_SETUP_INVITEE_RECEIVE_ONLY",
          number: 179,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAYMENT_INVITE_SETUP_INVITEE_SEND_AND_RECEIVE",
          number: 180,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "LINKED_GROUP_CALL_START",
          number: 181,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REPORT_TO_ADMIN_ENABLED_STATUS",
          number: 182,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "EMPTY_SUBGROUP_CREATE",
          number: 183,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SCHEDULED_CALL_CANCEL",
          number: 184,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SUBGROUP_ADMIN_TRIGGERED_AUTO_ADD_RICH",
          number: 185,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_CHANGE_RECENT_HISTORY_SHARING",
          number: 186,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PAID_MESSAGE_SERVER_CAMPAIGN_ID",
          number: 187,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GENERAL_CHAT_CREATE",
          number: 188,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GENERAL_CHAT_ADD",
          number: 189,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GENERAL_CHAT_AUTO_ADD_DISABLED",
          number: 190,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SUGGESTED_SUBGROUP_ANNOUNCE",
          number: 191,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_BOT_1P_MESSAGING_ENABLED",
          number: 192,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CHANGE_USERNAME",
          number: 193,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_COEX_PRIVACY_INIT_SELF",
          number: 194,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_COEX_PRIVACY_TRANSITION_SELF",
          number: 195,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SUPPORT_AI_EDUCATION",
          number: 196,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_BOT_3P_MESSAGING_ENABLED",
          number: 197,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REMINDER_SETUP_MESSAGE",
          number: 198,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REMINDER_SENT_MESSAGE",
          number: 199,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REMINDER_CANCEL_MESSAGE",
          number: 200,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_COEX_PRIVACY_INIT",
          number: 201,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_COEX_PRIVACY_TRANSITION",
          number: 202,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_DEACTIVATED",
          number: 203,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_DEACTIVATE_SIBLING_GROUP",
          number: 204,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "EVENT_UPDATED",
          number: 205,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "EVENT_CANCELED",
          number: 206,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_OWNER_UPDATED",
          number: 207,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMMUNITY_SUB_GROUP_VISIBILITY_HIDDEN",
          number: 208,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CAPI_GROUP_NE2EE_SYSTEM_MESSAGE",
          number: 209,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "STATUS_MENTION",
          number: 210,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "USER_CONTROLS_SYSTEM_MESSAGE",
          number: 211,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SUPPORT_SYSTEM_MESSAGE",
          number: 212,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CHANGE_LID",
          number: 213,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_CUSTOMER_3PD_DATA_SHARING_OPT_IN_MESSAGE",
          number: 214,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_CUSTOMER_3PD_DATA_SHARING_OPT_OUT_MESSAGE",
          number: 215,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CHANGE_LIMIT_SHARING",
          number: 216,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_MEMBER_LINK_MODE",
          number: 217,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "BIZ_AUTOMATICALLY_LABELED_CHAT_SYSTEM_MESSAGE",
          number: 218,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PHONE_NUMBER_HIDING_CHAT_DEPRECATED_MESSAGE",
          number: 219,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "QUARANTINED_MESSAGE",
          number: 220,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_MEMBER_SHARE_GROUP_HISTORY_MODE",
          number: 221,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_OPEN_BOT_ADDED",
          number: 222,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "GROUP_TEE_BOT_ADDED",
          number: 223,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CONTACT_INFO",
          number: 224,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SCHEDULED_MESSAGE_CREATED",
          number: 225,
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
  field(:REVOKE, 1)
  field(:CIPHERTEXT, 2)
  field(:FUTUREPROOF, 3)
  field(:NON_VERIFIED_TRANSITION, 4)
  field(:UNVERIFIED_TRANSITION, 5)
  field(:VERIFIED_TRANSITION, 6)
  field(:VERIFIED_LOW_UNKNOWN, 7)
  field(:VERIFIED_HIGH, 8)
  field(:VERIFIED_INITIAL_UNKNOWN, 9)
  field(:VERIFIED_INITIAL_LOW, 10)
  field(:VERIFIED_INITIAL_HIGH, 11)
  field(:VERIFIED_TRANSITION_ANY_TO_NONE, 12)
  field(:VERIFIED_TRANSITION_ANY_TO_HIGH, 13)
  field(:VERIFIED_TRANSITION_HIGH_TO_LOW, 14)
  field(:VERIFIED_TRANSITION_HIGH_TO_UNKNOWN, 15)
  field(:VERIFIED_TRANSITION_UNKNOWN_TO_LOW, 16)
  field(:VERIFIED_TRANSITION_LOW_TO_UNKNOWN, 17)
  field(:VERIFIED_TRANSITION_NONE_TO_LOW, 18)
  field(:VERIFIED_TRANSITION_NONE_TO_UNKNOWN, 19)
  field(:GROUP_CREATE, 20)
  field(:GROUP_CHANGE_SUBJECT, 21)
  field(:GROUP_CHANGE_ICON, 22)
  field(:GROUP_CHANGE_INVITE_LINK, 23)
  field(:GROUP_CHANGE_DESCRIPTION, 24)
  field(:GROUP_CHANGE_RESTRICT, 25)
  field(:GROUP_CHANGE_ANNOUNCE, 26)
  field(:GROUP_PARTICIPANT_ADD, 27)
  field(:GROUP_PARTICIPANT_REMOVE, 28)
  field(:GROUP_PARTICIPANT_PROMOTE, 29)
  field(:GROUP_PARTICIPANT_DEMOTE, 30)
  field(:GROUP_PARTICIPANT_INVITE, 31)
  field(:GROUP_PARTICIPANT_LEAVE, 32)
  field(:GROUP_PARTICIPANT_CHANGE_NUMBER, 33)
  field(:BROADCAST_CREATE, 34)
  field(:BROADCAST_ADD, 35)
  field(:BROADCAST_REMOVE, 36)
  field(:GENERIC_NOTIFICATION, 37)
  field(:E2E_IDENTITY_CHANGED, 38)
  field(:E2E_ENCRYPTED, 39)
  field(:CALL_MISSED_VOICE, 40)
  field(:CALL_MISSED_VIDEO, 41)
  field(:INDIVIDUAL_CHANGE_NUMBER, 42)
  field(:GROUP_DELETE, 43)
  field(:GROUP_ANNOUNCE_MODE_MESSAGE_BOUNCE, 44)
  field(:CALL_MISSED_GROUP_VOICE, 45)
  field(:CALL_MISSED_GROUP_VIDEO, 46)
  field(:PAYMENT_CIPHERTEXT, 47)
  field(:PAYMENT_FUTUREPROOF, 48)
  field(:PAYMENT_TRANSACTION_STATUS_UPDATE_FAILED, 49)
  field(:PAYMENT_TRANSACTION_STATUS_UPDATE_REFUNDED, 50)
  field(:PAYMENT_TRANSACTION_STATUS_UPDATE_REFUND_FAILED, 51)
  field(:PAYMENT_TRANSACTION_STATUS_RECEIVER_PENDING_SETUP, 52)
  field(:PAYMENT_TRANSACTION_STATUS_RECEIVER_SUCCESS_AFTER_HICCUP, 53)
  field(:PAYMENT_ACTION_ACCOUNT_SETUP_REMINDER, 54)
  field(:PAYMENT_ACTION_SEND_PAYMENT_REMINDER, 55)
  field(:PAYMENT_ACTION_SEND_PAYMENT_INVITATION, 56)
  field(:PAYMENT_ACTION_REQUEST_DECLINED, 57)
  field(:PAYMENT_ACTION_REQUEST_EXPIRED, 58)
  field(:PAYMENT_ACTION_REQUEST_CANCELLED, 59)
  field(:BIZ_VERIFIED_TRANSITION_TOP_TO_BOTTOM, 60)
  field(:BIZ_VERIFIED_TRANSITION_BOTTOM_TO_TOP, 61)
  field(:BIZ_INTRO_TOP, 62)
  field(:BIZ_INTRO_BOTTOM, 63)
  field(:BIZ_NAME_CHANGE, 64)
  field(:BIZ_MOVE_TO_CONSUMER_APP, 65)
  field(:BIZ_TWO_TIER_MIGRATION_TOP, 66)
  field(:BIZ_TWO_TIER_MIGRATION_BOTTOM, 67)
  field(:OVERSIZED, 68)
  field(:GROUP_CHANGE_NO_FREQUENTLY_FORWARDED, 69)
  field(:GROUP_V4_ADD_INVITE_SENT, 70)
  field(:GROUP_PARTICIPANT_ADD_REQUEST_JOIN, 71)
  field(:CHANGE_EPHEMERAL_SETTING, 72)
  field(:E2E_DEVICE_CHANGED, 73)
  field(:VIEWED_ONCE, 74)
  field(:E2E_ENCRYPTED_NOW, 75)
  field(:BLUE_MSG_BSP_FB_TO_BSP_PREMISE, 76)
  field(:BLUE_MSG_BSP_FB_TO_SELF_FB, 77)
  field(:BLUE_MSG_BSP_FB_TO_SELF_PREMISE, 78)
  field(:BLUE_MSG_BSP_FB_UNVERIFIED, 79)
  field(:BLUE_MSG_BSP_FB_UNVERIFIED_TO_SELF_PREMISE_VERIFIED, 80)
  field(:BLUE_MSG_BSP_FB_VERIFIED, 81)
  field(:BLUE_MSG_BSP_FB_VERIFIED_TO_SELF_PREMISE_UNVERIFIED, 82)
  field(:BLUE_MSG_BSP_PREMISE_TO_SELF_PREMISE, 83)
  field(:BLUE_MSG_BSP_PREMISE_UNVERIFIED, 84)
  field(:BLUE_MSG_BSP_PREMISE_UNVERIFIED_TO_SELF_PREMISE_VERIFIED, 85)
  field(:BLUE_MSG_BSP_PREMISE_VERIFIED, 86)
  field(:BLUE_MSG_BSP_PREMISE_VERIFIED_TO_SELF_PREMISE_UNVERIFIED, 87)
  field(:BLUE_MSG_CONSUMER_TO_BSP_FB_UNVERIFIED, 88)
  field(:BLUE_MSG_CONSUMER_TO_BSP_PREMISE_UNVERIFIED, 89)
  field(:BLUE_MSG_CONSUMER_TO_SELF_FB_UNVERIFIED, 90)
  field(:BLUE_MSG_CONSUMER_TO_SELF_PREMISE_UNVERIFIED, 91)
  field(:BLUE_MSG_SELF_FB_TO_BSP_PREMISE, 92)
  field(:BLUE_MSG_SELF_FB_TO_SELF_PREMISE, 93)
  field(:BLUE_MSG_SELF_FB_UNVERIFIED, 94)
  field(:BLUE_MSG_SELF_FB_UNVERIFIED_TO_SELF_PREMISE_VERIFIED, 95)
  field(:BLUE_MSG_SELF_FB_VERIFIED, 96)
  field(:BLUE_MSG_SELF_FB_VERIFIED_TO_SELF_PREMISE_UNVERIFIED, 97)
  field(:BLUE_MSG_SELF_PREMISE_TO_BSP_PREMISE, 98)
  field(:BLUE_MSG_SELF_PREMISE_UNVERIFIED, 99)
  field(:BLUE_MSG_SELF_PREMISE_VERIFIED, 100)
  field(:BLUE_MSG_TO_BSP_FB, 101)
  field(:BLUE_MSG_TO_CONSUMER, 102)
  field(:BLUE_MSG_TO_SELF_FB, 103)
  field(:BLUE_MSG_UNVERIFIED_TO_BSP_FB_VERIFIED, 104)
  field(:BLUE_MSG_UNVERIFIED_TO_BSP_PREMISE_VERIFIED, 105)
  field(:BLUE_MSG_UNVERIFIED_TO_SELF_FB_VERIFIED, 106)
  field(:BLUE_MSG_UNVERIFIED_TO_VERIFIED, 107)
  field(:BLUE_MSG_VERIFIED_TO_BSP_FB_UNVERIFIED, 108)
  field(:BLUE_MSG_VERIFIED_TO_BSP_PREMISE_UNVERIFIED, 109)
  field(:BLUE_MSG_VERIFIED_TO_SELF_FB_UNVERIFIED, 110)
  field(:BLUE_MSG_VERIFIED_TO_UNVERIFIED, 111)
  field(:BLUE_MSG_BSP_FB_UNVERIFIED_TO_BSP_PREMISE_VERIFIED, 112)
  field(:BLUE_MSG_BSP_FB_UNVERIFIED_TO_SELF_FB_VERIFIED, 113)
  field(:BLUE_MSG_BSP_FB_VERIFIED_TO_BSP_PREMISE_UNVERIFIED, 114)
  field(:BLUE_MSG_BSP_FB_VERIFIED_TO_SELF_FB_UNVERIFIED, 115)
  field(:BLUE_MSG_SELF_FB_UNVERIFIED_TO_BSP_PREMISE_VERIFIED, 116)
  field(:BLUE_MSG_SELF_FB_VERIFIED_TO_BSP_PREMISE_UNVERIFIED, 117)
  field(:E2E_IDENTITY_UNAVAILABLE, 118)
  field(:GROUP_CREATING, 119)
  field(:GROUP_CREATE_FAILED, 120)
  field(:GROUP_BOUNCED, 121)
  field(:BLOCK_CONTACT, 122)
  field(:EPHEMERAL_SETTING_NOT_APPLIED, 123)
  field(:SYNC_FAILED, 124)
  field(:SYNCING, 125)
  field(:BIZ_PRIVACY_MODE_INIT_FB, 126)
  field(:BIZ_PRIVACY_MODE_INIT_BSP, 127)
  field(:BIZ_PRIVACY_MODE_TO_FB, 128)
  field(:BIZ_PRIVACY_MODE_TO_BSP, 129)
  field(:DISAPPEARING_MODE, 130)
  field(:E2E_DEVICE_FETCH_FAILED, 131)
  field(:ADMIN_REVOKE, 132)
  field(:GROUP_INVITE_LINK_GROWTH_LOCKED, 133)
  field(:COMMUNITY_LINK_PARENT_GROUP, 134)
  field(:COMMUNITY_LINK_SIBLING_GROUP, 135)
  field(:COMMUNITY_LINK_SUB_GROUP, 136)
  field(:COMMUNITY_UNLINK_PARENT_GROUP, 137)
  field(:COMMUNITY_UNLINK_SIBLING_GROUP, 138)
  field(:COMMUNITY_UNLINK_SUB_GROUP, 139)
  field(:GROUP_PARTICIPANT_ACCEPT, 140)
  field(:GROUP_PARTICIPANT_LINKED_GROUP_JOIN, 141)
  field(:COMMUNITY_CREATE, 142)
  field(:EPHEMERAL_KEEP_IN_CHAT, 143)
  field(:GROUP_MEMBERSHIP_JOIN_APPROVAL_REQUEST, 144)
  field(:GROUP_MEMBERSHIP_JOIN_APPROVAL_MODE, 145)
  field(:INTEGRITY_UNLINK_PARENT_GROUP, 146)
  field(:COMMUNITY_PARTICIPANT_PROMOTE, 147)
  field(:COMMUNITY_PARTICIPANT_DEMOTE, 148)
  field(:COMMUNITY_PARENT_GROUP_DELETED, 149)
  field(:COMMUNITY_LINK_PARENT_GROUP_MEMBERSHIP_APPROVAL, 150)
  field(:GROUP_PARTICIPANT_JOINED_GROUP_AND_PARENT_GROUP, 151)
  field(:MASKED_THREAD_CREATED, 152)
  field(:MASKED_THREAD_UNMASKED, 153)
  field(:BIZ_CHAT_ASSIGNMENT, 154)
  field(:CHAT_PSA, 155)
  field(:CHAT_POLL_CREATION_MESSAGE, 156)
  field(:CAG_MASKED_THREAD_CREATED, 157)
  field(:COMMUNITY_PARENT_GROUP_SUBJECT_CHANGED, 158)
  field(:CAG_INVITE_AUTO_ADD, 159)
  field(:BIZ_CHAT_ASSIGNMENT_UNASSIGN, 160)
  field(:CAG_INVITE_AUTO_JOINED, 161)
  field(:SCHEDULED_CALL_START_MESSAGE, 162)
  field(:COMMUNITY_INVITE_RICH, 163)
  field(:COMMUNITY_INVITE_AUTO_ADD_RICH, 164)
  field(:SUB_GROUP_INVITE_RICH, 165)
  field(:SUB_GROUP_PARTICIPANT_ADD_RICH, 166)
  field(:COMMUNITY_LINK_PARENT_GROUP_RICH, 167)
  field(:COMMUNITY_PARTICIPANT_ADD_RICH, 168)
  field(:SILENCED_UNKNOWN_CALLER_AUDIO, 169)
  field(:SILENCED_UNKNOWN_CALLER_VIDEO, 170)
  field(:GROUP_MEMBER_ADD_MODE, 171)
  field(:GROUP_MEMBERSHIP_JOIN_APPROVAL_REQUEST_NON_ADMIN_ADD, 172)
  field(:COMMUNITY_CHANGE_DESCRIPTION, 173)
  field(:SENDER_INVITE, 174)
  field(:RECEIVER_INVITE, 175)
  field(:COMMUNITY_ALLOW_MEMBER_ADDED_GROUPS, 176)
  field(:PINNED_MESSAGE_IN_CHAT, 177)
  field(:PAYMENT_INVITE_SETUP_INVITER, 178)
  field(:PAYMENT_INVITE_SETUP_INVITEE_RECEIVE_ONLY, 179)
  field(:PAYMENT_INVITE_SETUP_INVITEE_SEND_AND_RECEIVE, 180)
  field(:LINKED_GROUP_CALL_START, 181)
  field(:REPORT_TO_ADMIN_ENABLED_STATUS, 182)
  field(:EMPTY_SUBGROUP_CREATE, 183)
  field(:SCHEDULED_CALL_CANCEL, 184)
  field(:SUBGROUP_ADMIN_TRIGGERED_AUTO_ADD_RICH, 185)
  field(:GROUP_CHANGE_RECENT_HISTORY_SHARING, 186)
  field(:PAID_MESSAGE_SERVER_CAMPAIGN_ID, 187)
  field(:GENERAL_CHAT_CREATE, 188)
  field(:GENERAL_CHAT_ADD, 189)
  field(:GENERAL_CHAT_AUTO_ADD_DISABLED, 190)
  field(:SUGGESTED_SUBGROUP_ANNOUNCE, 191)
  field(:BIZ_BOT_1P_MESSAGING_ENABLED, 192)
  field(:CHANGE_USERNAME, 193)
  field(:BIZ_COEX_PRIVACY_INIT_SELF, 194)
  field(:BIZ_COEX_PRIVACY_TRANSITION_SELF, 195)
  field(:SUPPORT_AI_EDUCATION, 196)
  field(:BIZ_BOT_3P_MESSAGING_ENABLED, 197)
  field(:REMINDER_SETUP_MESSAGE, 198)
  field(:REMINDER_SENT_MESSAGE, 199)
  field(:REMINDER_CANCEL_MESSAGE, 200)
  field(:BIZ_COEX_PRIVACY_INIT, 201)
  field(:BIZ_COEX_PRIVACY_TRANSITION, 202)
  field(:GROUP_DEACTIVATED, 203)
  field(:COMMUNITY_DEACTIVATE_SIBLING_GROUP, 204)
  field(:EVENT_UPDATED, 205)
  field(:EVENT_CANCELED, 206)
  field(:COMMUNITY_OWNER_UPDATED, 207)
  field(:COMMUNITY_SUB_GROUP_VISIBILITY_HIDDEN, 208)
  field(:CAPI_GROUP_NE2EE_SYSTEM_MESSAGE, 209)
  field(:STATUS_MENTION, 210)
  field(:USER_CONTROLS_SYSTEM_MESSAGE, 211)
  field(:SUPPORT_SYSTEM_MESSAGE, 212)
  field(:CHANGE_LID, 213)
  field(:BIZ_CUSTOMER_3PD_DATA_SHARING_OPT_IN_MESSAGE, 214)
  field(:BIZ_CUSTOMER_3PD_DATA_SHARING_OPT_OUT_MESSAGE, 215)
  field(:CHANGE_LIMIT_SHARING, 216)
  field(:GROUP_MEMBER_LINK_MODE, 217)
  field(:BIZ_AUTOMATICALLY_LABELED_CHAT_SYSTEM_MESSAGE, 218)
  field(:PHONE_NUMBER_HIDING_CHAT_DEPRECATED_MESSAGE, 219)
  field(:QUARANTINED_MESSAGE, 220)
  field(:GROUP_MEMBER_SHARE_GROUP_HISTORY_MODE, 221)
  field(:GROUP_OPEN_BOT_ADDED, 222)
  field(:GROUP_TEE_BOT_ADDED, 223)
  field(:CONTACT_INFO, 224)
  field(:SCHEDULED_MESSAGE_CREATED, 225)
end

defmodule WAWebProtobufsWeb.WebMessageInfo.Status do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWeb.WebMessageInfo.Status",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Status",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "ERROR",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PENDING",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SERVER_ACK",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DELIVERY_ACK",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "READ",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PLAYED",
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

  field(:ERROR, 0)
  field(:PENDING, 1)
  field(:SERVER_ACK, 2)
  field(:DELIVERY_ACK, 3)
  field(:READ, 4)
  field(:PLAYED, 5)
end

defmodule WAWebProtobufsWeb.PaymentInfo.TxnStatus do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWeb.PaymentInfo.TxnStatus",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "TxnStatus",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PENDING_SETUP",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PENDING_RECEIVER_SETUP",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INIT",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SUCCESS",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMPLETED",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FAILED",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FAILED_RISK",
          number: 7,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FAILED_PROCESSING",
          number: 8,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FAILED_RECEIVER_PROCESSING",
          number: 9,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FAILED_DA",
          number: 10,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FAILED_DA_FINAL",
          number: 11,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REFUNDED_TXN",
          number: 12,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REFUND_FAILED",
          number: 13,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REFUND_FAILED_PROCESSING",
          number: 14,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REFUND_FAILED_DA",
          number: 15,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "EXPIRED_TXN",
          number: 16,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AUTH_CANCELED",
          number: 17,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AUTH_CANCEL_FAILED_PROCESSING",
          number: 18,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "AUTH_CANCEL_FAILED",
          number: 19,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COLLECT_INIT",
          number: 20,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COLLECT_SUCCESS",
          number: 21,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COLLECT_FAILED",
          number: 22,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COLLECT_FAILED_RISK",
          number: 23,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COLLECT_REJECTED",
          number: 24,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COLLECT_EXPIRED",
          number: 25,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COLLECT_CANCELED",
          number: 26,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COLLECT_CANCELLING",
          number: 27,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "IN_REVIEW",
          number: 28,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REVERSAL_SUCCESS",
          number: 29,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REVERSAL_PENDING",
          number: 30,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REFUND_PENDING",
          number: 31,
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
  field(:PENDING_SETUP, 1)
  field(:PENDING_RECEIVER_SETUP, 2)
  field(:INIT, 3)
  field(:SUCCESS, 4)
  field(:COMPLETED, 5)
  field(:FAILED, 6)
  field(:FAILED_RISK, 7)
  field(:FAILED_PROCESSING, 8)
  field(:FAILED_RECEIVER_PROCESSING, 9)
  field(:FAILED_DA, 10)
  field(:FAILED_DA_FINAL, 11)
  field(:REFUNDED_TXN, 12)
  field(:REFUND_FAILED, 13)
  field(:REFUND_FAILED_PROCESSING, 14)
  field(:REFUND_FAILED_DA, 15)
  field(:EXPIRED_TXN, 16)
  field(:AUTH_CANCELED, 17)
  field(:AUTH_CANCEL_FAILED_PROCESSING, 18)
  field(:AUTH_CANCEL_FAILED, 19)
  field(:COLLECT_INIT, 20)
  field(:COLLECT_SUCCESS, 21)
  field(:COLLECT_FAILED, 22)
  field(:COLLECT_FAILED_RISK, 23)
  field(:COLLECT_REJECTED, 24)
  field(:COLLECT_EXPIRED, 25)
  field(:COLLECT_CANCELED, 26)
  field(:COLLECT_CANCELLING, 27)
  field(:IN_REVIEW, 28)
  field(:REVERSAL_SUCCESS, 29)
  field(:REVERSAL_PENDING, 30)
  field(:REFUND_PENDING, 31)
end

defmodule WAWebProtobufsWeb.PaymentInfo.Status do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWeb.PaymentInfo.Status",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Status",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN_STATUS",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PROCESSING",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "SENT",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NEED_TO_ACCEPT",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COMPLETE",
          number: 4,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "COULD_NOT_COMPLETE",
          number: 5,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REFUNDED",
          number: 6,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "EXPIRED",
          number: 7,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REJECTED",
          number: 8,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "CANCELLED",
          number: 9,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WAITING_FOR_PAYER",
          number: 10,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "WAITING",
          number: 11,
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

  field(:UNKNOWN_STATUS, 0)
  field(:PROCESSING, 1)
  field(:SENT, 2)
  field(:NEED_TO_ACCEPT, 3)
  field(:COMPLETE, 4)
  field(:COULD_NOT_COMPLETE, 5)
  field(:REFUNDED, 6)
  field(:EXPIRED, 7)
  field(:REJECTED, 8)
  field(:CANCELLED, 9)
  field(:WAITING_FOR_PAYER, 10)
  field(:WAITING, 11)
end

defmodule WAWebProtobufsWeb.PaymentInfo.Currency do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWeb.PaymentInfo.Currency",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Currency",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN_CURRENCY",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INR",
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

  field(:UNKNOWN_CURRENCY, 0)
  field(:INR, 1)
end

defmodule WAWebProtobufsWeb.WebFeatures.Flag do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWeb.WebFeatures.Flag",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Flag",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NOT_STARTED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "FORCE_UPGRADE",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "DEVELOPMENT",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PRODUCTION",
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

  field(:NOT_STARTED, 0)
  field(:FORCE_UPGRADE, 1)
  field(:DEVELOPMENT, 2)
  field(:PRODUCTION, 3)
end

defmodule WAWebProtobufsWeb.PinInChat.Type do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWeb.PinInChat.Type",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "Type",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNKNOWN_TYPE",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PIN_FOR_ALL",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNPIN_FOR_ALL",
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

  field(:UNKNOWN_TYPE, 0)
  field(:PIN_FOR_ALL, 1)
  field(:UNPIN_FOR_ALL, 2)
end

defmodule WAWebProtobufsWeb.MessageAddOn.MessageAddOnType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWeb.MessageAddOn.MessageAddOnType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "MessageAddOnType",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "UNDEFINED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "REACTION",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "EVENT_RESPONSE",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "POLL_UPDATE",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "PIN_IN_CHAT",
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

  field(:UNDEFINED, 0)
  field(:REACTION, 1)
  field(:EVENT_RESPONSE, 2)
  field(:POLL_UPDATE, 3)
  field(:PIN_IN_CHAT, 4)
end

defmodule WAWebProtobufsWeb.GroupHistoryBundleInfo.ProcessState do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WAWebProtobufsWeb.GroupHistoryBundleInfo.ProcessState",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.EnumDescriptorProto{
      name: "ProcessState",
      value: [
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "NOT_INJECTED",
          number: 0,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INJECTED",
          number: 1,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INJECTED_PARTIAL",
          number: 2,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INJECTION_FAILED",
          number: 3,
          options: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.EnumValueDescriptorProto{
          name: "INJECTION_FAILED_NO_RETRY",
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

  field(:NOT_INJECTED, 0)
  field(:INJECTED, 1)
  field(:INJECTED_PARTIAL, 2)
  field(:INJECTION_FAILED, 3)
  field(:INJECTION_FAILED_NO_RETRY, 4)
end

defmodule WAWebProtobufsWeb.WebMessageInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.WebMessageInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "WebMessageInfo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "key",
          extendee: nil,
          number: 1,
          label: :LABEL_REQUIRED,
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
          name: "message",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsE2E.Message",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "message",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageTimestamp",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "status",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebMessageInfo.Status",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "status",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "participant",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "participant",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageC2STimestamp",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageC2STimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ignore",
          extendee: nil,
          number: 16,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ignore",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "starred",
          extendee: nil,
          number: 17,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "starred",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "broadcast",
          extendee: nil,
          number: 18,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "broadcast",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pushName",
          extendee: nil,
          number: 19,
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
          name: "mediaCiphertextSHA256",
          extendee: nil,
          number: 20,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaCiphertextSHA256",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "multicast",
          extendee: nil,
          number: 21,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "multicast",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "urlText",
          extendee: nil,
          number: 22,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "urlText",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "urlNumber",
          extendee: nil,
          number: 23,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "urlNumber",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageStubType",
          extendee: nil,
          number: 24,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebMessageInfo.StubType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageStubType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "clearMedia",
          extendee: nil,
          number: 25,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "clearMedia",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageStubParameters",
          extendee: nil,
          number: 26,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageStubParameters",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "duration",
          extendee: nil,
          number: 27,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "duration",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "labels",
          extendee: nil,
          number: 28,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "labels",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "paymentInfo",
          extendee: nil,
          number: 29,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.PaymentInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "paymentInfo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "finalLiveLocation",
          extendee: nil,
          number: 30,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsE2E.LiveLocationMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "finalLiveLocation",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "quotedPaymentInfo",
          extendee: nil,
          number: 31,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.PaymentInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "quotedPaymentInfo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralStartTimestamp",
          extendee: nil,
          number: 32,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeralStartTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralDuration",
          extendee: nil,
          number: 33,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeralDuration",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralOffToOn",
          extendee: nil,
          number: 34,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeralOffToOn",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralOutOfSync",
          extendee: nil,
          number: 35,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeralOutOfSync",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "bizPrivacyStatus",
          extendee: nil,
          number: 36,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebMessageInfo.BizPrivacyStatus",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "bizPrivacyStatus",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "verifiedBizName",
          extendee: nil,
          number: 37,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "verifiedBizName",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaData",
          extendee: nil,
          number: 38,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.MediaData",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaData",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "photoChange",
          extendee: nil,
          number: 39,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.PhotoChange",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "photoChange",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "userReceipt",
          extendee: nil,
          number: 40,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.UserReceipt",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "userReceipt",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "reactions",
          extendee: nil,
          number: 41,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.Reaction",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "reactions",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "quotedStickerData",
          extendee: nil,
          number: 42,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.MediaData",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "quotedStickerData",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "futureproofData",
          extendee: nil,
          number: 43,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "futureproofData",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "statusPsa",
          extendee: nil,
          number: 44,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.StatusPSA",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "statusPsa",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pollUpdates",
          extendee: nil,
          number: 45,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.PollUpdate",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pollUpdates",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pollAdditionalMetadata",
          extendee: nil,
          number: 46,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.PollAdditionalMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pollAdditionalMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "agentID",
          extendee: nil,
          number: 47,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "agentID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "statusAlreadyViewed",
          extendee: nil,
          number: 48,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "statusAlreadyViewed",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageSecret",
          extendee: nil,
          number: 49,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageSecret",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "keepInChat",
          extendee: nil,
          number: 50,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.KeepInChat",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "keepInChat",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "originalSelfAuthorUserJIDString",
          extendee: nil,
          number: 51,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "originalSelfAuthorUserJIDString",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "revokeMessageTimestamp",
          extendee: nil,
          number: 52,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "revokeMessageTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pinInChat",
          extendee: nil,
          number: 54,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.PinInChat",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pinInChat",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "premiumMessageInfo",
          extendee: nil,
          number: 55,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.PremiumMessageInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "premiumMessageInfo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "is1PBizBotMessage",
          extendee: nil,
          number: 56,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "is1PBizBotMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isGroupHistoryMessage",
          extendee: nil,
          number: 57,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isGroupHistoryMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botMessageInvokerJID",
          extendee: nil,
          number: 58,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botMessageInvokerJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "commentMetadata",
          extendee: nil,
          number: 59,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.CommentMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "commentMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "eventResponses",
          extendee: nil,
          number: 61,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.EventResponse",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "eventResponses",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "reportingTokenInfo",
          extendee: nil,
          number: 62,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.ReportingTokenInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "reportingTokenInfo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "newsletterServerID",
          extendee: nil,
          number: 63,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "newsletterServerID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "eventAdditionalMetadata",
          extendee: nil,
          number: 64,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.EventAdditionalMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "eventAdditionalMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isMentionedInStatus",
          extendee: nil,
          number: 65,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isMentionedInStatus",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "statusMentions",
          extendee: nil,
          number: 66,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "statusMentions",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "targetMessageID",
          extendee: nil,
          number: 67,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "targetMessageID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageAddOns",
          extendee: nil,
          number: 68,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.MessageAddOn",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageAddOns",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "statusMentionMessageInfo",
          extendee: nil,
          number: 69,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.StatusMentionMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "statusMentionMessageInfo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "isSupportAiMessage",
          extendee: nil,
          number: 70,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isSupportAiMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "statusMentionSources",
          extendee: nil,
          number: 71,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "statusMentionSources",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "supportAiCitations",
          extendee: nil,
          number: 72,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.Citation",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "supportAiCitations",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "botTargetID",
          extendee: nil,
          number: 73,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "botTargetID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupHistoryIndividualMessageInfo",
          extendee: nil,
          number: 74,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.GroupHistoryIndividualMessageInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "groupHistoryIndividualMessageInfo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupHistoryBundleInfo",
          extendee: nil,
          number: 75,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.GroupHistoryBundleInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "groupHistoryBundleInfo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "interactiveMessageAdditionalMetadata",
          extendee: nil,
          number: 76,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.InteractiveMessageAdditionalMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "interactiveMessageAdditionalMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "quarantinedMessage",
          extendee: nil,
          number: 77,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.QuarantinedMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "quarantinedMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "nonJIDMentions",
          extendee: nil,
          number: 78,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "nonJIDMentions",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "hsmTag",
          extendee: nil,
          number: 79,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "hsmTag",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralExpirationTimestamp",
          extendee: nil,
          number: 80,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeralExpirationTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "scheduledMessageMetadata",
          extendee: nil,
          number: 81,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.ScheduledMessageMetadata",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "scheduledMessageMetadata",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "decisionID",
          extendee: nil,
          number: 82,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "decisionID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "decisionSources",
          extendee: nil,
          number: 83,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "decisionSources",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "BizPrivacyStatus",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "E2EE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FB",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BSP",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BSP_AND_FB",
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
          name: "StubType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REVOKE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CIPHERTEXT",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FUTUREPROOF",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NON_VERIFIED_TRANSITION",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNVERIFIED_TRANSITION",
              number: 5,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VERIFIED_TRANSITION",
              number: 6,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VERIFIED_LOW_UNKNOWN",
              number: 7,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VERIFIED_HIGH",
              number: 8,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VERIFIED_INITIAL_UNKNOWN",
              number: 9,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VERIFIED_INITIAL_LOW",
              number: 10,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VERIFIED_INITIAL_HIGH",
              number: 11,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VERIFIED_TRANSITION_ANY_TO_NONE",
              number: 12,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VERIFIED_TRANSITION_ANY_TO_HIGH",
              number: 13,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VERIFIED_TRANSITION_HIGH_TO_LOW",
              number: 14,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VERIFIED_TRANSITION_HIGH_TO_UNKNOWN",
              number: 15,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VERIFIED_TRANSITION_UNKNOWN_TO_LOW",
              number: 16,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VERIFIED_TRANSITION_LOW_TO_UNKNOWN",
              number: 17,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VERIFIED_TRANSITION_NONE_TO_LOW",
              number: 18,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VERIFIED_TRANSITION_NONE_TO_UNKNOWN",
              number: 19,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_CREATE",
              number: 20,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_CHANGE_SUBJECT",
              number: 21,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_CHANGE_ICON",
              number: 22,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_CHANGE_INVITE_LINK",
              number: 23,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_CHANGE_DESCRIPTION",
              number: 24,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_CHANGE_RESTRICT",
              number: 25,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_CHANGE_ANNOUNCE",
              number: 26,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_PARTICIPANT_ADD",
              number: 27,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_PARTICIPANT_REMOVE",
              number: 28,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_PARTICIPANT_PROMOTE",
              number: 29,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_PARTICIPANT_DEMOTE",
              number: 30,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_PARTICIPANT_INVITE",
              number: 31,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_PARTICIPANT_LEAVE",
              number: 32,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_PARTICIPANT_CHANGE_NUMBER",
              number: 33,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BROADCAST_CREATE",
              number: 34,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BROADCAST_ADD",
              number: 35,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BROADCAST_REMOVE",
              number: 36,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GENERIC_NOTIFICATION",
              number: 37,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "E2E_IDENTITY_CHANGED",
              number: 38,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "E2E_ENCRYPTED",
              number: 39,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CALL_MISSED_VOICE",
              number: 40,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CALL_MISSED_VIDEO",
              number: 41,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INDIVIDUAL_CHANGE_NUMBER",
              number: 42,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_DELETE",
              number: 43,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_ANNOUNCE_MODE_MESSAGE_BOUNCE",
              number: 44,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CALL_MISSED_GROUP_VOICE",
              number: 45,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CALL_MISSED_GROUP_VIDEO",
              number: 46,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAYMENT_CIPHERTEXT",
              number: 47,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAYMENT_FUTUREPROOF",
              number: 48,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAYMENT_TRANSACTION_STATUS_UPDATE_FAILED",
              number: 49,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAYMENT_TRANSACTION_STATUS_UPDATE_REFUNDED",
              number: 50,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAYMENT_TRANSACTION_STATUS_UPDATE_REFUND_FAILED",
              number: 51,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAYMENT_TRANSACTION_STATUS_RECEIVER_PENDING_SETUP",
              number: 52,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAYMENT_TRANSACTION_STATUS_RECEIVER_SUCCESS_AFTER_HICCUP",
              number: 53,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAYMENT_ACTION_ACCOUNT_SETUP_REMINDER",
              number: 54,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAYMENT_ACTION_SEND_PAYMENT_REMINDER",
              number: 55,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAYMENT_ACTION_SEND_PAYMENT_INVITATION",
              number: 56,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAYMENT_ACTION_REQUEST_DECLINED",
              number: 57,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAYMENT_ACTION_REQUEST_EXPIRED",
              number: 58,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAYMENT_ACTION_REQUEST_CANCELLED",
              number: 59,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_VERIFIED_TRANSITION_TOP_TO_BOTTOM",
              number: 60,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_VERIFIED_TRANSITION_BOTTOM_TO_TOP",
              number: 61,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_INTRO_TOP",
              number: 62,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_INTRO_BOTTOM",
              number: 63,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_NAME_CHANGE",
              number: 64,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_MOVE_TO_CONSUMER_APP",
              number: 65,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_TWO_TIER_MIGRATION_TOP",
              number: 66,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_TWO_TIER_MIGRATION_BOTTOM",
              number: 67,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "OVERSIZED",
              number: 68,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_CHANGE_NO_FREQUENTLY_FORWARDED",
              number: 69,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_V4_ADD_INVITE_SENT",
              number: 70,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_PARTICIPANT_ADD_REQUEST_JOIN",
              number: 71,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CHANGE_EPHEMERAL_SETTING",
              number: 72,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "E2E_DEVICE_CHANGED",
              number: 73,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "VIEWED_ONCE",
              number: 74,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "E2E_ENCRYPTED_NOW",
              number: 75,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_BSP_FB_TO_BSP_PREMISE",
              number: 76,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_BSP_FB_TO_SELF_FB",
              number: 77,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_BSP_FB_TO_SELF_PREMISE",
              number: 78,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_BSP_FB_UNVERIFIED",
              number: 79,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_BSP_FB_UNVERIFIED_TO_SELF_PREMISE_VERIFIED",
              number: 80,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_BSP_FB_VERIFIED",
              number: 81,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_BSP_FB_VERIFIED_TO_SELF_PREMISE_UNVERIFIED",
              number: 82,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_BSP_PREMISE_TO_SELF_PREMISE",
              number: 83,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_BSP_PREMISE_UNVERIFIED",
              number: 84,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_BSP_PREMISE_UNVERIFIED_TO_SELF_PREMISE_VERIFIED",
              number: 85,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_BSP_PREMISE_VERIFIED",
              number: 86,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_BSP_PREMISE_VERIFIED_TO_SELF_PREMISE_UNVERIFIED",
              number: 87,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_CONSUMER_TO_BSP_FB_UNVERIFIED",
              number: 88,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_CONSUMER_TO_BSP_PREMISE_UNVERIFIED",
              number: 89,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_CONSUMER_TO_SELF_FB_UNVERIFIED",
              number: 90,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_CONSUMER_TO_SELF_PREMISE_UNVERIFIED",
              number: 91,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_SELF_FB_TO_BSP_PREMISE",
              number: 92,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_SELF_FB_TO_SELF_PREMISE",
              number: 93,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_SELF_FB_UNVERIFIED",
              number: 94,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_SELF_FB_UNVERIFIED_TO_SELF_PREMISE_VERIFIED",
              number: 95,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_SELF_FB_VERIFIED",
              number: 96,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_SELF_FB_VERIFIED_TO_SELF_PREMISE_UNVERIFIED",
              number: 97,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_SELF_PREMISE_TO_BSP_PREMISE",
              number: 98,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_SELF_PREMISE_UNVERIFIED",
              number: 99,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_SELF_PREMISE_VERIFIED",
              number: 100,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_TO_BSP_FB",
              number: 101,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_TO_CONSUMER",
              number: 102,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_TO_SELF_FB",
              number: 103,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_UNVERIFIED_TO_BSP_FB_VERIFIED",
              number: 104,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_UNVERIFIED_TO_BSP_PREMISE_VERIFIED",
              number: 105,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_UNVERIFIED_TO_SELF_FB_VERIFIED",
              number: 106,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_UNVERIFIED_TO_VERIFIED",
              number: 107,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_VERIFIED_TO_BSP_FB_UNVERIFIED",
              number: 108,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_VERIFIED_TO_BSP_PREMISE_UNVERIFIED",
              number: 109,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_VERIFIED_TO_SELF_FB_UNVERIFIED",
              number: 110,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_VERIFIED_TO_UNVERIFIED",
              number: 111,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_BSP_FB_UNVERIFIED_TO_BSP_PREMISE_VERIFIED",
              number: 112,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_BSP_FB_UNVERIFIED_TO_SELF_FB_VERIFIED",
              number: 113,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_BSP_FB_VERIFIED_TO_BSP_PREMISE_UNVERIFIED",
              number: 114,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_BSP_FB_VERIFIED_TO_SELF_FB_UNVERIFIED",
              number: 115,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_SELF_FB_UNVERIFIED_TO_BSP_PREMISE_VERIFIED",
              number: 116,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLUE_MSG_SELF_FB_VERIFIED_TO_BSP_PREMISE_UNVERIFIED",
              number: 117,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "E2E_IDENTITY_UNAVAILABLE",
              number: 118,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_CREATING",
              number: 119,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_CREATE_FAILED",
              number: 120,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_BOUNCED",
              number: 121,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BLOCK_CONTACT",
              number: 122,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "EPHEMERAL_SETTING_NOT_APPLIED",
              number: 123,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SYNC_FAILED",
              number: 124,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SYNCING",
              number: 125,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_PRIVACY_MODE_INIT_FB",
              number: 126,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_PRIVACY_MODE_INIT_BSP",
              number: 127,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_PRIVACY_MODE_TO_FB",
              number: 128,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_PRIVACY_MODE_TO_BSP",
              number: 129,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DISAPPEARING_MODE",
              number: 130,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "E2E_DEVICE_FETCH_FAILED",
              number: 131,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ADMIN_REVOKE",
              number: 132,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_INVITE_LINK_GROWTH_LOCKED",
              number: 133,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_LINK_PARENT_GROUP",
              number: 134,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_LINK_SIBLING_GROUP",
              number: 135,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_LINK_SUB_GROUP",
              number: 136,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_UNLINK_PARENT_GROUP",
              number: 137,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_UNLINK_SIBLING_GROUP",
              number: 138,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_UNLINK_SUB_GROUP",
              number: 139,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_PARTICIPANT_ACCEPT",
              number: 140,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_PARTICIPANT_LINKED_GROUP_JOIN",
              number: 141,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_CREATE",
              number: 142,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "EPHEMERAL_KEEP_IN_CHAT",
              number: 143,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_MEMBERSHIP_JOIN_APPROVAL_REQUEST",
              number: 144,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_MEMBERSHIP_JOIN_APPROVAL_MODE",
              number: 145,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INTEGRITY_UNLINK_PARENT_GROUP",
              number: 146,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_PARTICIPANT_PROMOTE",
              number: 147,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_PARTICIPANT_DEMOTE",
              number: 148,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_PARENT_GROUP_DELETED",
              number: 149,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_LINK_PARENT_GROUP_MEMBERSHIP_APPROVAL",
              number: 150,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_PARTICIPANT_JOINED_GROUP_AND_PARENT_GROUP",
              number: 151,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MASKED_THREAD_CREATED",
              number: 152,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "MASKED_THREAD_UNMASKED",
              number: 153,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_CHAT_ASSIGNMENT",
              number: 154,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CHAT_PSA",
              number: 155,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CHAT_POLL_CREATION_MESSAGE",
              number: 156,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CAG_MASKED_THREAD_CREATED",
              number: 157,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_PARENT_GROUP_SUBJECT_CHANGED",
              number: 158,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CAG_INVITE_AUTO_ADD",
              number: 159,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_CHAT_ASSIGNMENT_UNASSIGN",
              number: 160,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CAG_INVITE_AUTO_JOINED",
              number: 161,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SCHEDULED_CALL_START_MESSAGE",
              number: 162,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_INVITE_RICH",
              number: 163,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_INVITE_AUTO_ADD_RICH",
              number: 164,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SUB_GROUP_INVITE_RICH",
              number: 165,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SUB_GROUP_PARTICIPANT_ADD_RICH",
              number: 166,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_LINK_PARENT_GROUP_RICH",
              number: 167,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_PARTICIPANT_ADD_RICH",
              number: 168,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SILENCED_UNKNOWN_CALLER_AUDIO",
              number: 169,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SILENCED_UNKNOWN_CALLER_VIDEO",
              number: 170,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_MEMBER_ADD_MODE",
              number: 171,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_MEMBERSHIP_JOIN_APPROVAL_REQUEST_NON_ADMIN_ADD",
              number: 172,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_CHANGE_DESCRIPTION",
              number: 173,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SENDER_INVITE",
              number: 174,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "RECEIVER_INVITE",
              number: 175,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_ALLOW_MEMBER_ADDED_GROUPS",
              number: 176,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PINNED_MESSAGE_IN_CHAT",
              number: 177,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAYMENT_INVITE_SETUP_INVITER",
              number: 178,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAYMENT_INVITE_SETUP_INVITEE_RECEIVE_ONLY",
              number: 179,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAYMENT_INVITE_SETUP_INVITEE_SEND_AND_RECEIVE",
              number: 180,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "LINKED_GROUP_CALL_START",
              number: 181,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REPORT_TO_ADMIN_ENABLED_STATUS",
              number: 182,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "EMPTY_SUBGROUP_CREATE",
              number: 183,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SCHEDULED_CALL_CANCEL",
              number: 184,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SUBGROUP_ADMIN_TRIGGERED_AUTO_ADD_RICH",
              number: 185,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_CHANGE_RECENT_HISTORY_SHARING",
              number: 186,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PAID_MESSAGE_SERVER_CAMPAIGN_ID",
              number: 187,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GENERAL_CHAT_CREATE",
              number: 188,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GENERAL_CHAT_ADD",
              number: 189,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GENERAL_CHAT_AUTO_ADD_DISABLED",
              number: 190,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SUGGESTED_SUBGROUP_ANNOUNCE",
              number: 191,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_BOT_1P_MESSAGING_ENABLED",
              number: 192,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CHANGE_USERNAME",
              number: 193,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_COEX_PRIVACY_INIT_SELF",
              number: 194,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_COEX_PRIVACY_TRANSITION_SELF",
              number: 195,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SUPPORT_AI_EDUCATION",
              number: 196,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_BOT_3P_MESSAGING_ENABLED",
              number: 197,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REMINDER_SETUP_MESSAGE",
              number: 198,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REMINDER_SENT_MESSAGE",
              number: 199,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REMINDER_CANCEL_MESSAGE",
              number: 200,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_COEX_PRIVACY_INIT",
              number: 201,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_COEX_PRIVACY_TRANSITION",
              number: 202,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_DEACTIVATED",
              number: 203,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_DEACTIVATE_SIBLING_GROUP",
              number: 204,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "EVENT_UPDATED",
              number: 205,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "EVENT_CANCELED",
              number: 206,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_OWNER_UPDATED",
              number: 207,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMMUNITY_SUB_GROUP_VISIBILITY_HIDDEN",
              number: 208,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CAPI_GROUP_NE2EE_SYSTEM_MESSAGE",
              number: 209,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "STATUS_MENTION",
              number: 210,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "USER_CONTROLS_SYSTEM_MESSAGE",
              number: 211,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SUPPORT_SYSTEM_MESSAGE",
              number: 212,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CHANGE_LID",
              number: 213,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_CUSTOMER_3PD_DATA_SHARING_OPT_IN_MESSAGE",
              number: 214,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_CUSTOMER_3PD_DATA_SHARING_OPT_OUT_MESSAGE",
              number: 215,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CHANGE_LIMIT_SHARING",
              number: 216,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_MEMBER_LINK_MODE",
              number: 217,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "BIZ_AUTOMATICALLY_LABELED_CHAT_SYSTEM_MESSAGE",
              number: 218,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PHONE_NUMBER_HIDING_CHAT_DEPRECATED_MESSAGE",
              number: 219,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "QUARANTINED_MESSAGE",
              number: 220,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_MEMBER_SHARE_GROUP_HISTORY_MODE",
              number: 221,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_OPEN_BOT_ADDED",
              number: 222,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "GROUP_TEE_BOT_ADDED",
              number: 223,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CONTACT_INFO",
              number: 224,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SCHEDULED_MESSAGE_CREATED",
              number: 225,
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
          name: "Status",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "ERROR",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PENDING",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SERVER_ACK",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DELIVERY_ACK",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "READ",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PLAYED",
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

  field(:key, 1, required: true, type: WACommon.MessageKey)
  field(:message, 2, optional: true, type: WAWebProtobufsE2E.Message)
  field(:messageTimestamp, 3, optional: true, type: :uint64)
  field(:status, 4, optional: true, type: WAWebProtobufsWeb.WebMessageInfo.Status, enum: true)
  field(:participant, 5, optional: true, type: :string)
  field(:messageC2STimestamp, 6, optional: true, type: :uint64)
  field(:ignore, 16, optional: true, type: :bool)
  field(:starred, 17, optional: true, type: :bool)
  field(:broadcast, 18, optional: true, type: :bool)
  field(:pushName, 19, optional: true, type: :string)
  field(:mediaCiphertextSHA256, 20, optional: true, type: :bytes)
  field(:multicast, 21, optional: true, type: :bool)
  field(:urlText, 22, optional: true, type: :bool)
  field(:urlNumber, 23, optional: true, type: :bool)

  field(:messageStubType, 24,
    optional: true,
    type: WAWebProtobufsWeb.WebMessageInfo.StubType,
    enum: true
  )

  field(:clearMedia, 25, optional: true, type: :bool)
  field(:messageStubParameters, 26, repeated: true, type: :string)
  field(:duration, 27, optional: true, type: :uint32)
  field(:labels, 28, repeated: true, type: :string)
  field(:paymentInfo, 29, optional: true, type: WAWebProtobufsWeb.PaymentInfo)
  field(:finalLiveLocation, 30, optional: true, type: WAWebProtobufsE2E.LiveLocationMessage)
  field(:quotedPaymentInfo, 31, optional: true, type: WAWebProtobufsWeb.PaymentInfo)
  field(:ephemeralStartTimestamp, 32, optional: true, type: :uint64)
  field(:ephemeralDuration, 33, optional: true, type: :uint32)
  field(:ephemeralOffToOn, 34, optional: true, type: :bool)
  field(:ephemeralOutOfSync, 35, optional: true, type: :bool)

  field(:bizPrivacyStatus, 36,
    optional: true,
    type: WAWebProtobufsWeb.WebMessageInfo.BizPrivacyStatus,
    enum: true
  )

  field(:verifiedBizName, 37, optional: true, type: :string)
  field(:mediaData, 38, optional: true, type: WAWebProtobufsWeb.MediaData)
  field(:photoChange, 39, optional: true, type: WAWebProtobufsWeb.PhotoChange)
  field(:userReceipt, 40, repeated: true, type: WAWebProtobufsWeb.UserReceipt)
  field(:reactions, 41, repeated: true, type: WAWebProtobufsWeb.Reaction)
  field(:quotedStickerData, 42, optional: true, type: WAWebProtobufsWeb.MediaData)
  field(:futureproofData, 43, optional: true, type: :bytes)
  field(:statusPsa, 44, optional: true, type: WAWebProtobufsWeb.StatusPSA)
  field(:pollUpdates, 45, repeated: true, type: WAWebProtobufsWeb.PollUpdate)

  field(:pollAdditionalMetadata, 46,
    optional: true,
    type: WAWebProtobufsWeb.PollAdditionalMetadata
  )

  field(:agentID, 47, optional: true, type: :string)
  field(:statusAlreadyViewed, 48, optional: true, type: :bool)
  field(:messageSecret, 49, optional: true, type: :bytes)
  field(:keepInChat, 50, optional: true, type: WAWebProtobufsWeb.KeepInChat)
  field(:originalSelfAuthorUserJIDString, 51, optional: true, type: :string)
  field(:revokeMessageTimestamp, 52, optional: true, type: :uint64)
  field(:pinInChat, 54, optional: true, type: WAWebProtobufsWeb.PinInChat)
  field(:premiumMessageInfo, 55, optional: true, type: WAWebProtobufsWeb.PremiumMessageInfo)
  field(:is1PBizBotMessage, 56, optional: true, type: :bool)
  field(:isGroupHistoryMessage, 57, optional: true, type: :bool)
  field(:botMessageInvokerJID, 58, optional: true, type: :string)
  field(:commentMetadata, 59, optional: true, type: WAWebProtobufsWeb.CommentMetadata)
  field(:eventResponses, 61, repeated: true, type: WAWebProtobufsWeb.EventResponse)
  field(:reportingTokenInfo, 62, optional: true, type: WAWebProtobufsWeb.ReportingTokenInfo)
  field(:newsletterServerID, 63, optional: true, type: :uint64)

  field(:eventAdditionalMetadata, 64,
    optional: true,
    type: WAWebProtobufsWeb.EventAdditionalMetadata
  )

  field(:isMentionedInStatus, 65, optional: true, type: :bool)
  field(:statusMentions, 66, repeated: true, type: :string)
  field(:targetMessageID, 67, optional: true, type: WACommon.MessageKey)
  field(:messageAddOns, 68, repeated: true, type: WAWebProtobufsWeb.MessageAddOn)

  field(:statusMentionMessageInfo, 69,
    optional: true,
    type: WAWebProtobufsWeb.StatusMentionMessage
  )

  field(:isSupportAiMessage, 70, optional: true, type: :bool)
  field(:statusMentionSources, 71, repeated: true, type: :string)
  field(:supportAiCitations, 72, repeated: true, type: WAWebProtobufsWeb.Citation)
  field(:botTargetID, 73, optional: true, type: :string)

  field(:groupHistoryIndividualMessageInfo, 74,
    optional: true,
    type: WAWebProtobufsWeb.GroupHistoryIndividualMessageInfo
  )

  field(:groupHistoryBundleInfo, 75,
    optional: true,
    type: WAWebProtobufsWeb.GroupHistoryBundleInfo
  )

  field(:interactiveMessageAdditionalMetadata, 76,
    optional: true,
    type: WAWebProtobufsWeb.InteractiveMessageAdditionalMetadata
  )

  field(:quarantinedMessage, 77, optional: true, type: WAWebProtobufsWeb.QuarantinedMessage)
  field(:nonJIDMentions, 78, optional: true, type: :uint32)
  field(:hsmTag, 79, optional: true, type: :string)
  field(:ephemeralExpirationTimestamp, 80, optional: true, type: :uint64)

  field(:scheduledMessageMetadata, 81,
    optional: true,
    type: WAWebProtobufsWeb.ScheduledMessageMetadata
  )

  field(:decisionID, 82, optional: true, type: :string)
  field(:decisionSources, 83, repeated: true, type: :string)
end

defmodule WAWebProtobufsWeb.PaymentInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.PaymentInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PaymentInfo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "currencyDeprecated",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.PaymentInfo.Currency",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "currencyDeprecated",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "amount1000",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "amount1000",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "receiverJID",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "receiverJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "status",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.PaymentInfo.Status",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "status",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "transactionTimestamp",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "transactionTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "requestMessageKey",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "requestMessageKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "expiryTimestamp",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "expiryTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "futureproofed",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "futureproofed",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "currency",
          extendee: nil,
          number: 9,
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
          name: "txnStatus",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.PaymentInfo.TxnStatus",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "txnStatus",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "useNoviFiatFormat",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "useNoviFiatFormat",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "primaryAmount",
          extendee: nil,
          number: 12,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsE2E.Money",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "primaryAmount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "exchangeAmount",
          extendee: nil,
          number: 13,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsE2E.Money",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "exchangeAmount",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "TxnStatus",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PENDING_SETUP",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PENDING_RECEIVER_SETUP",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INIT",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SUCCESS",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMPLETED",
              number: 5,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FAILED",
              number: 6,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FAILED_RISK",
              number: 7,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FAILED_PROCESSING",
              number: 8,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FAILED_RECEIVER_PROCESSING",
              number: 9,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FAILED_DA",
              number: 10,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FAILED_DA_FINAL",
              number: 11,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REFUNDED_TXN",
              number: 12,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REFUND_FAILED",
              number: 13,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REFUND_FAILED_PROCESSING",
              number: 14,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REFUND_FAILED_DA",
              number: 15,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "EXPIRED_TXN",
              number: 16,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AUTH_CANCELED",
              number: 17,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AUTH_CANCEL_FAILED_PROCESSING",
              number: 18,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "AUTH_CANCEL_FAILED",
              number: 19,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COLLECT_INIT",
              number: 20,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COLLECT_SUCCESS",
              number: 21,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COLLECT_FAILED",
              number: 22,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COLLECT_FAILED_RISK",
              number: 23,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COLLECT_REJECTED",
              number: 24,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COLLECT_EXPIRED",
              number: 25,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COLLECT_CANCELED",
              number: 26,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COLLECT_CANCELLING",
              number: 27,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "IN_REVIEW",
              number: 28,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REVERSAL_SUCCESS",
              number: 29,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REVERSAL_PENDING",
              number: 30,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REFUND_PENDING",
              number: 31,
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
          name: "Status",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN_STATUS",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PROCESSING",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "SENT",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NEED_TO_ACCEPT",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COMPLETE",
              number: 4,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "COULD_NOT_COMPLETE",
              number: 5,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REFUNDED",
              number: 6,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "EXPIRED",
              number: 7,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REJECTED",
              number: 8,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "CANCELLED",
              number: 9,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WAITING_FOR_PAYER",
              number: 10,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "WAITING",
              number: 11,
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
          name: "Currency",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNKNOWN_CURRENCY",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INR",
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

  field(:currencyDeprecated, 1,
    optional: true,
    type: WAWebProtobufsWeb.PaymentInfo.Currency,
    enum: true
  )

  field(:amount1000, 2, optional: true, type: :uint64)
  field(:receiverJID, 3, optional: true, type: :string)
  field(:status, 4, optional: true, type: WAWebProtobufsWeb.PaymentInfo.Status, enum: true)
  field(:transactionTimestamp, 5, optional: true, type: :uint64)
  field(:requestMessageKey, 6, optional: true, type: WACommon.MessageKey)
  field(:expiryTimestamp, 7, optional: true, type: :uint64)
  field(:futureproofed, 8, optional: true, type: :bool)
  field(:currency, 9, optional: true, type: :string)
  field(:txnStatus, 10, optional: true, type: WAWebProtobufsWeb.PaymentInfo.TxnStatus, enum: true)
  field(:useNoviFiatFormat, 11, optional: true, type: :bool)
  field(:primaryAmount, 12, optional: true, type: WAWebProtobufsE2E.Money)
  field(:exchangeAmount, 13, optional: true, type: WAWebProtobufsE2E.Money)
end

defmodule WAWebProtobufsWeb.WebFeatures do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.WebFeatures",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "WebFeatures",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "labelsDisplay",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "labelsDisplay",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "voipIndividualOutgoing",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "voipIndividualOutgoing",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupsV3",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "groupsV3",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupsV3Create",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "groupsV3Create",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "changeNumberV2",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "changeNumberV2",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "queryStatusV3Thumbnail",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "queryStatusV3Thumbnail",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "liveLocations",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "liveLocations",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "queryVname",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "queryVname",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "voipIndividualIncoming",
          extendee: nil,
          number: 9,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "voipIndividualIncoming",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "quickRepliesQuery",
          extendee: nil,
          number: 10,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "quickRepliesQuery",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "payments",
          extendee: nil,
          number: 11,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "payments",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "stickerPackQuery",
          extendee: nil,
          number: 12,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "stickerPackQuery",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "liveLocationsFinal",
          extendee: nil,
          number: 13,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "liveLocationsFinal",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "labelsEdit",
          extendee: nil,
          number: 14,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "labelsEdit",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaUpload",
          extendee: nil,
          number: 15,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaUpload",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mediaUploadRichQuickReplies",
          extendee: nil,
          number: 18,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mediaUploadRichQuickReplies",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "vnameV2",
          extendee: nil,
          number: 19,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "vnameV2",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "videoPlaybackURL",
          extendee: nil,
          number: 20,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "videoPlaybackURL",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "statusRanking",
          extendee: nil,
          number: 21,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "statusRanking",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "voipIndividualVideo",
          extendee: nil,
          number: 22,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "voipIndividualVideo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "thirdPartyStickers",
          extendee: nil,
          number: 23,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "thirdPartyStickers",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "frequentlyForwardedSetting",
          extendee: nil,
          number: 24,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "frequentlyForwardedSetting",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupsV4JoinPermission",
          extendee: nil,
          number: 25,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "groupsV4JoinPermission",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "recentStickers",
          extendee: nil,
          number: 26,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "recentStickers",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "catalog",
          extendee: nil,
          number: 27,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "catalog",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "starredStickers",
          extendee: nil,
          number: 28,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "starredStickers",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "voipGroupCall",
          extendee: nil,
          number: 29,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "voipGroupCall",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "templateMessage",
          extendee: nil,
          number: 30,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "templateMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "templateMessageInteractivity",
          extendee: nil,
          number: 31,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "templateMessageInteractivity",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralMessages",
          extendee: nil,
          number: 32,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeralMessages",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "e2ENotificationSync",
          extendee: nil,
          number: 33,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "e2ENotificationSync",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "recentStickersV2",
          extendee: nil,
          number: 34,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "recentStickersV2",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "recentStickersV3",
          extendee: nil,
          number: 36,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "recentStickersV3",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "userNotice",
          extendee: nil,
          number: 37,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "userNotice",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "support",
          extendee: nil,
          number: 39,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "support",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupUiiCleanup",
          extendee: nil,
          number: 40,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "groupUiiCleanup",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "groupDogfoodingInternalOnly",
          extendee: nil,
          number: 41,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "groupDogfoodingInternalOnly",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "settingsSync",
          extendee: nil,
          number: 42,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "settingsSync",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "archiveV2",
          extendee: nil,
          number: 43,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "archiveV2",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeralAllowGroupMembers",
          extendee: nil,
          number: 44,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeralAllowGroupMembers",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "ephemeral24HDuration",
          extendee: nil,
          number: 45,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "ephemeral24HDuration",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "mdForceUpgrade",
          extendee: nil,
          number: 46,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "mdForceUpgrade",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "disappearingMode",
          extendee: nil,
          number: 47,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "disappearingMode",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "externalMdOptInAvailable",
          extendee: nil,
          number: 48,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "externalMdOptInAvailable",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "noDeleteMessageTimeLimit",
          extendee: nil,
          number: 49,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebFeatures.Flag",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "noDeleteMessageTimeLimit",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "Flag",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NOT_STARTED",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "FORCE_UPGRADE",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "DEVELOPMENT",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PRODUCTION",
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

  field(:labelsDisplay, 1, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)

  field(:voipIndividualOutgoing, 2,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:groupsV3, 3, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)
  field(:groupsV3Create, 4, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)
  field(:changeNumberV2, 5, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)

  field(:queryStatusV3Thumbnail, 6,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:liveLocations, 7, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)
  field(:queryVname, 8, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)

  field(:voipIndividualIncoming, 9,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:quickRepliesQuery, 10,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:payments, 11, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)

  field(:stickerPackQuery, 12,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:liveLocationsFinal, 13,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:labelsEdit, 14, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)
  field(:mediaUpload, 15, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)

  field(:mediaUploadRichQuickReplies, 18,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:vnameV2, 19, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)

  field(:videoPlaybackURL, 20,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:statusRanking, 21, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)

  field(:voipIndividualVideo, 22,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:thirdPartyStickers, 23,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:frequentlyForwardedSetting, 24,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:groupsV4JoinPermission, 25,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:recentStickers, 26, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)
  field(:catalog, 27, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)
  field(:starredStickers, 28, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)
  field(:voipGroupCall, 29, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)
  field(:templateMessage, 30, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)

  field(:templateMessageInteractivity, 31,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:ephemeralMessages, 32,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:e2ENotificationSync, 33,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:recentStickersV2, 34,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:recentStickersV3, 36,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:userNotice, 37, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)
  field(:support, 39, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)
  field(:groupUiiCleanup, 40, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)

  field(:groupDogfoodingInternalOnly, 41,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:settingsSync, 42, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)
  field(:archiveV2, 43, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)

  field(:ephemeralAllowGroupMembers, 44,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:ephemeral24HDuration, 45,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:mdForceUpgrade, 46, optional: true, type: WAWebProtobufsWeb.WebFeatures.Flag, enum: true)

  field(:disappearingMode, 47,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:externalMdOptInAvailable, 48,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )

  field(:noDeleteMessageTimeLimit, 49,
    optional: true,
    type: WAWebProtobufsWeb.WebFeatures.Flag,
    enum: true
  )
end

defmodule WAWebProtobufsWeb.PinInChat do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.PinInChat",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PinInChat",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "type",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.PinInChat.Type",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "type",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "key",
          extendee: nil,
          number: 2,
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
          name: "senderTimestampMS",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "senderTimestampMS",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "serverTimestampMS",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "serverTimestampMS",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageAddOnContextInfo",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.MessageAddOnContextInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageAddOnContextInfo",
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
              name: "UNKNOWN_TYPE",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PIN_FOR_ALL",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNPIN_FOR_ALL",
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

  field(:type, 1, optional: true, type: WAWebProtobufsWeb.PinInChat.Type, enum: true)
  field(:key, 2, optional: true, type: WACommon.MessageKey)
  field(:senderTimestampMS, 3, optional: true, type: :int64)
  field(:serverTimestampMS, 4, optional: true, type: :int64)

  field(:messageAddOnContextInfo, 5,
    optional: true,
    type: WAWebProtobufsWeb.MessageAddOnContextInfo
  )
end

defmodule WAWebProtobufsWeb.MessageAddOn do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.MessageAddOn",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MessageAddOn",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageAddOnType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.MessageAddOn.MessageAddOnType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageAddOnType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageAddOn",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsE2E.Message",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageAddOn",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "senderTimestampMS",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "senderTimestampMS",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "serverTimestampMS",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "serverTimestampMS",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "status",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.WebMessageInfo.Status",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "status",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "addOnContextInfo",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.MessageAddOnContextInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "addOnContextInfo",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageAddOnKey",
          extendee: nil,
          number: 7,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageAddOnKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "legacyMessage",
          extendee: nil,
          number: 8,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.LegacyMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "legacyMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "MessageAddOnType",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "UNDEFINED",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "REACTION",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "EVENT_RESPONSE",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "POLL_UPDATE",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "PIN_IN_CHAT",
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

  field(:messageAddOnType, 1,
    optional: true,
    type: WAWebProtobufsWeb.MessageAddOn.MessageAddOnType,
    enum: true
  )

  field(:messageAddOn, 2, optional: true, type: WAWebProtobufsE2E.Message)
  field(:senderTimestampMS, 3, optional: true, type: :int64)
  field(:serverTimestampMS, 4, optional: true, type: :int64)
  field(:status, 5, optional: true, type: WAWebProtobufsWeb.WebMessageInfo.Status, enum: true)
  field(:addOnContextInfo, 6, optional: true, type: WAWebProtobufsWeb.MessageAddOnContextInfo)
  field(:messageAddOnKey, 7, optional: true, type: WACommon.MessageKey)
  field(:legacyMessage, 8, optional: true, type: WAWebProtobufsWeb.LegacyMessage)
end

defmodule WAWebProtobufsWeb.GroupHistoryBundleInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.GroupHistoryBundleInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "GroupHistoryBundleInfo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "deprecatedMessageHistoryBundle",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsE2E.MessageHistoryBundle",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deprecatedMessageHistoryBundle",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "processState",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsWeb.GroupHistoryBundleInfo.ProcessState",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "processState",
          proto3_optional: nil,
          __unknown_fields__: []
        }
      ],
      nested_type: [],
      enum_type: [
        %Google.Protobuf.EnumDescriptorProto{
          name: "ProcessState",
          value: [
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "NOT_INJECTED",
              number: 0,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INJECTED",
              number: 1,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INJECTED_PARTIAL",
              number: 2,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INJECTION_FAILED",
              number: 3,
              options: nil,
              __unknown_fields__: []
            },
            %Google.Protobuf.EnumValueDescriptorProto{
              name: "INJECTION_FAILED_NO_RETRY",
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

  field(:deprecatedMessageHistoryBundle, 1,
    optional: true,
    type: WAWebProtobufsE2E.MessageHistoryBundle
  )

  field(:processState, 2,
    optional: true,
    type: WAWebProtobufsWeb.GroupHistoryBundleInfo.ProcessState,
    enum: true
  )
end

defmodule WAWebProtobufsWeb.CommentMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.CommentMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "CommentMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "commentParentKey",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "commentParentKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "replyCount",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "replyCount",
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

  field(:commentParentKey, 1, optional: true, type: WACommon.MessageKey)
  field(:replyCount, 2, optional: true, type: :uint32)
end

defmodule WAWebProtobufsWeb.WebNotificationsInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.WebNotificationsInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "WebNotificationsInfo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "timestamp",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "timestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "unreadChats",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "unreadChats",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "notifyMessageCount",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "notifyMessageCount",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "notifyMessages",
          extendee: nil,
          number: 5,
          label: :LABEL_REPEATED,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsWeb.WebMessageInfo",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "notifyMessages",
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

  field(:timestamp, 2, optional: true, type: :uint64)
  field(:unreadChats, 3, optional: true, type: :uint32)
  field(:notifyMessageCount, 4, optional: true, type: :uint32)
  field(:notifyMessages, 5, repeated: true, type: WAWebProtobufsWeb.WebMessageInfo)
end

defmodule WAWebProtobufsWeb.NotificationMessageInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.NotificationMessageInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "NotificationMessageInfo",
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
          name: "message",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsE2E.Message",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "message",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageTimestamp",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "participant",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "participant",
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
  field(:message, 2, optional: true, type: WAWebProtobufsE2E.Message)
  field(:messageTimestamp, 3, optional: true, type: :uint64)
  field(:participant, 4, optional: true, type: :string)
end

defmodule WAWebProtobufsWeb.ReportingTokenInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.ReportingTokenInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ReportingTokenInfo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "reportingTag",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "reportingTag",
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

  field(:reportingTag, 1, optional: true, type: :bytes)
end

defmodule WAWebProtobufsWeb.MediaData do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.MediaData",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MediaData",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "localPath",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "localPath",
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

  field(:localPath, 1, optional: true, type: :string)
end

defmodule WAWebProtobufsWeb.PhotoChange do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.PhotoChange",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PhotoChange",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "oldPhoto",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "oldPhoto",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "newPhoto",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "newPhoto",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "newPhotoID",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "newPhotoID",
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

  field(:oldPhoto, 1, optional: true, type: :bytes)
  field(:newPhoto, 2, optional: true, type: :bytes)
  field(:newPhotoID, 3, optional: true, type: :uint32)
end

defmodule WAWebProtobufsWeb.StatusPSA do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.StatusPSA",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "StatusPSA",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "campaignID",
          extendee: nil,
          number: 44,
          label: :LABEL_REQUIRED,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "campaignID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "campaignExpirationTimestamp",
          extendee: nil,
          number: 45,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "campaignExpirationTimestamp",
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

  field(:campaignID, 44, required: true, type: :uint64)
  field(:campaignExpirationTimestamp, 45, optional: true, type: :uint64)
end

defmodule WAWebProtobufsWeb.UserReceipt do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.UserReceipt",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "UserReceipt",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "userJID",
          extendee: nil,
          number: 1,
          label: :LABEL_REQUIRED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "userJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "receiptTimestamp",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "receiptTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "readTimestamp",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "readTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "playedTimestamp",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "playedTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pendingDeviceJID",
          extendee: nil,
          number: 5,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pendingDeviceJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "deliveredDeviceJID",
          extendee: nil,
          number: 6,
          label: :LABEL_REPEATED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deliveredDeviceJID",
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

  field(:userJID, 1, required: true, type: :string)
  field(:receiptTimestamp, 2, optional: true, type: :int64)
  field(:readTimestamp, 3, optional: true, type: :int64)
  field(:playedTimestamp, 4, optional: true, type: :int64)
  field(:pendingDeviceJID, 5, repeated: true, type: :string)
  field(:deliveredDeviceJID, 6, repeated: true, type: :string)
end

defmodule WAWebProtobufsWeb.Reaction do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.Reaction",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Reaction",
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
          name: "text",
          extendee: nil,
          number: 2,
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
          name: "groupingKey",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "groupingKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "senderTimestampMS",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "senderTimestampMS",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "unread",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "unread",
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
  field(:text, 2, optional: true, type: :string)
  field(:groupingKey, 3, optional: true, type: :string)
  field(:senderTimestampMS, 4, optional: true, type: :int64)
  field(:unread, 5, optional: true, type: :bool)
end

defmodule WAWebProtobufsWeb.PollUpdate do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.PollUpdate",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PollUpdate",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "pollUpdateMessageKey",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pollUpdateMessageKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "vote",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsE2E.PollVoteMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "vote",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "senderTimestampMS",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "senderTimestampMS",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "serverTimestampMS",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "serverTimestampMS",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "unread",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "unread",
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

  field(:pollUpdateMessageKey, 1, optional: true, type: WACommon.MessageKey)
  field(:vote, 2, optional: true, type: WAWebProtobufsE2E.PollVoteMessage)
  field(:senderTimestampMS, 3, optional: true, type: :int64)
  field(:serverTimestampMS, 4, optional: true, type: :int64)
  field(:unread, 5, optional: true, type: :bool)
end

defmodule WAWebProtobufsWeb.PollAdditionalMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.PollAdditionalMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PollAdditionalMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "pollInvalidated",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pollInvalidated",
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

  field(:pollInvalidated, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufsWeb.InteractiveMessageAdditionalMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.InteractiveMessageAdditionalMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "InteractiveMessageAdditionalMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "isGalaxyFlowCompleted",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isGalaxyFlowCompleted",
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

  field(:isGalaxyFlowCompleted, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufsWeb.EventAdditionalMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.EventAdditionalMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "EventAdditionalMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "isStale",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "isStale",
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

  field(:isStale, 1, optional: true, type: :bool)
end

defmodule WAWebProtobufsWeb.KeepInChat do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.KeepInChat",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "KeepInChat",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "keepType",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsE2E.KeepType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "keepType",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "serverTimestamp",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "serverTimestamp",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "key",
          extendee: nil,
          number: 3,
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
          name: "deviceJID",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "deviceJID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "clientTimestampMS",
          extendee: nil,
          number: 5,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "clientTimestampMS",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "serverTimestampMS",
          extendee: nil,
          number: 6,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "serverTimestampMS",
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

  field(:keepType, 1, optional: true, type: WAWebProtobufsE2E.KeepType, enum: true)
  field(:serverTimestamp, 2, optional: true, type: :int64)
  field(:key, 3, optional: true, type: WACommon.MessageKey)
  field(:deviceJID, 4, optional: true, type: :string)
  field(:clientTimestampMS, 5, optional: true, type: :int64)
  field(:serverTimestampMS, 6, optional: true, type: :int64)
end

defmodule WAWebProtobufsWeb.MessageAddOnContextInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.MessageAddOnContextInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "MessageAddOnContextInfo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageAddOnDurationInSecs",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT32,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageAddOnDurationInSecs",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "messageAddOnExpiryType",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_ENUM,
          type_name: ".WAWebProtobufsE2E.MessageContextInfo.MessageAddonExpiryType",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "messageAddOnExpiryType",
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

  field(:messageAddOnDurationInSecs, 1, optional: true, type: :uint32)

  field(:messageAddOnExpiryType, 2,
    optional: true,
    type: WAWebProtobufsE2E.MessageContextInfo.MessageAddonExpiryType,
    enum: true
  )
end

defmodule WAWebProtobufsWeb.PremiumMessageInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.PremiumMessageInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "PremiumMessageInfo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "serverCampaignID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "serverCampaignID",
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

  field(:serverCampaignID, 1, optional: true, type: :string)
end

defmodule WAWebProtobufsWeb.EventResponse do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.EventResponse",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "EventResponse",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "eventResponseMessageKey",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "eventResponseMessageKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "timestampMS",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_INT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "timestampMS",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "eventResponseMessage",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsE2E.EventResponseMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "eventResponseMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "unread",
          extendee: nil,
          number: 4,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "unread",
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

  field(:eventResponseMessageKey, 1, optional: true, type: WACommon.MessageKey)
  field(:timestampMS, 2, optional: true, type: :int64)
  field(:eventResponseMessage, 3, optional: true, type: WAWebProtobufsE2E.EventResponseMessage)
  field(:unread, 4, optional: true, type: :bool)
end

defmodule WAWebProtobufsWeb.LegacyMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.LegacyMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "LegacyMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "eventResponseMessage",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsE2E.EventResponseMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "eventResponseMessage",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "pollVote",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsE2E.PollVoteMessage",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "pollVote",
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

  field(:eventResponseMessage, 1, optional: true, type: WAWebProtobufsE2E.EventResponseMessage)
  field(:pollVote, 2, optional: true, type: WAWebProtobufsE2E.PollVoteMessage)
end

defmodule WAWebProtobufsWeb.StatusMentionMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.StatusMentionMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "StatusMentionMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "quotedStatus",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WAWebProtobufsE2E.Message",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "quotedStatus",
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

  field(:quotedStatus, 1, optional: true, type: WAWebProtobufsE2E.Message)
end

defmodule WAWebProtobufsWeb.Citation do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.Citation",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "Citation",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "title",
          extendee: nil,
          number: 1,
          label: :LABEL_REQUIRED,
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
          name: "subtitle",
          extendee: nil,
          number: 2,
          label: :LABEL_REQUIRED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "subtitle",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "cmsID",
          extendee: nil,
          number: 3,
          label: :LABEL_REQUIRED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "cmsID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "imageURL",
          extendee: nil,
          number: 4,
          label: :LABEL_REQUIRED,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "imageURL",
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

  field(:title, 1, required: true, type: :string)
  field(:subtitle, 2, required: true, type: :string)
  field(:cmsID, 3, required: true, type: :string)
  field(:imageURL, 4, required: true, type: :string)
end

defmodule WAWebProtobufsWeb.GroupHistoryIndividualMessageInfo do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.GroupHistoryIndividualMessageInfo",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "GroupHistoryIndividualMessageInfo",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "bundleMessageKey",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_MESSAGE,
          type_name: ".WACommon.MessageKey",
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "bundleMessageKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "editedAfterReceivedAsHistory",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BOOL,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "editedAfterReceivedAsHistory",
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

  field(:bundleMessageKey, 1, optional: true, type: WACommon.MessageKey)
  field(:editedAfterReceivedAsHistory, 2, optional: true, type: :bool)
end

defmodule WAWebProtobufsWeb.QuarantinedMessage do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.QuarantinedMessage",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "QuarantinedMessage",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "originalData",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "originalData",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "extractedText",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "extractedText",
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

  field(:originalData, 1, optional: true, type: :bytes)
  field(:extractedText, 2, optional: true, type: :string)
end

defmodule WAWebProtobufsWeb.ScheduledMessageMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "WAWebProtobufsWeb.ScheduledMessageMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto2

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.DescriptorProto{
      name: "ScheduledMessageMetadata",
      field: [
        %Google.Protobuf.FieldDescriptorProto{
          name: "revealKeyID",
          extendee: nil,
          number: 1,
          label: :LABEL_OPTIONAL,
          type: :TYPE_STRING,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "revealKeyID",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "revealKey",
          extendee: nil,
          number: 2,
          label: :LABEL_OPTIONAL,
          type: :TYPE_BYTES,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "revealKey",
          proto3_optional: nil,
          __unknown_fields__: []
        },
        %Google.Protobuf.FieldDescriptorProto{
          name: "scheduledTime",
          extendee: nil,
          number: 3,
          label: :LABEL_OPTIONAL,
          type: :TYPE_UINT64,
          type_name: nil,
          default_value: nil,
          options: nil,
          oneof_index: nil,
          json_name: "scheduledTime",
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

  field(:revealKeyID, 1, optional: true, type: :string)
  field(:revealKey, 2, optional: true, type: :bytes)
  field(:scheduledTime, 3, optional: true, type: :uint64)
end
