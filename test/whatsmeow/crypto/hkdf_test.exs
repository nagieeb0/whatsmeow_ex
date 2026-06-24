defmodule Whatsmeow.Crypto.HKDFTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Crypto.HKDF

  describe "RFC 5869 test case 1 (basic, SHA-256)" do
    @ikm Base.decode16!("0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B")
    @salt Base.decode16!("000102030405060708090A0B0C")
    @info Base.decode16!("F0F1F2F3F4F5F6F7F8F9")
    @prk Base.decode16!("077709362C2E32DF0DDC3F0DC47BBA6390B6C73BB50F9C3122EC844AD7C2B3E5")
    @okm Base.decode16!(
           "3CB25F25FAACD57A90434F64D0362F2A2D2D0A90CF1A5A4C5DB02D56ECC4C5BF34007208D5B887185865"
         )

    test "extract/2 produces the documented PRK" do
      assert HKDF.extract(@ikm, @salt) == @prk
    end

    test "expand/3 produces the documented OKM" do
      assert HKDF.expand(@prk, @info, 42) == @okm
    end

    test "derive/4 combines extract + expand" do
      assert HKDF.derive(@ikm, @salt, @info, 42) == @okm
    end
  end

  describe "RFC 5869 test case 2 (longer inputs/outputs)" do
    @ikm Base.decode16!(
           "000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F" <>
             "202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F" <>
             "404142434445464748494A4B4C4D4E4F"
         )
    @salt Base.decode16!(
            "606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E7F" <>
              "808182838485868788898A8B8C8D8E8F909192939495969798999A9B9C9D9E9F" <>
              "A0A1A2A3A4A5A6A7A8A9AAABACADAEAF"
          )
    @info Base.decode16!(
            "B0B1B2B3B4B5B6B7B8B9BABBBCBDBEBFC0C1C2C3C4C5C6C7C8C9CACBCCCDCECF" <>
              "D0D1D2D3D4D5D6D7D8D9DADBDCDDDEDFE0E1E2E3E4E5E6E7E8E9EAEBECEDEEEF" <>
              "F0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF"
          )
    @okm Base.decode16!(
           "B11E398DC80327A1C8E7F78C596A49344F012EDA2D4EFAD8A050CC4C19AFA97C" <>
             "59045A99CAC7827271CB41C65E590E09DA3275600C2F09B8367793A9ACA3DB71" <>
             "CC30C58179EC3E87C14C01D5C1F3434F1D87"
         )

    test "derive/4 produces 82 bytes" do
      assert HKDF.derive(@ikm, @salt, @info, 82) == @okm
    end
  end

  describe "RFC 5869 test case 3 (zero-length salt and info)" do
    @ikm Base.decode16!("0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B")
    @okm Base.decode16!(
           "8DA4E775A563C18F715F802A063C5A31B8A11F5C5EE1879EC3454E5F3C738D2D" <>
             "9D201395FAA4B61A96C8"
         )

    test "derive/4 with nil salt and empty info produces documented OKM" do
      assert HKDF.derive(@ikm, nil, <<>>, 42) == @okm
    end
  end
end
