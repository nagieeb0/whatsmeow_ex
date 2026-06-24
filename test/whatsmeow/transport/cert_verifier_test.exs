defmodule Whatsmeow.Transport.CertVerifierTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Transport.CertVerifier

  alias WACert.CertChain
  alias WACert.CertChain.NoiseCertificate, as: NestedCert

  describe "verify/3 structural failures" do
    test "rejects garbage bytes as :malformed_cert" do
      assert {:error, :malformed_cert} =
               CertVerifier.verify(<<0xFF, 0xFF, 0xFF, 0xFF>>, server_static())
    end

    test "rejects empty intermediate as :missing_parts" do
      chain = CertChain.encode(%CertChain{intermediate: nil, leaf: nil})
      assert {:error, :missing_parts} = CertVerifier.verify(chain, server_static())
    end

    test "rejects wrong-length signature as :bad_sig_length" do
      chain =
        CertChain.encode(%CertChain{
          intermediate: %NestedCert{details: <<1, 2, 3>>, signature: <<1, 2>>},
          leaf: %NestedCert{details: <<4, 5, 6>>, signature: :crypto.strong_rand_bytes(64)}
        })

      assert {:error, :bad_sig_length} = CertVerifier.verify(chain, server_static())
    end

    test "rejects sig-shape-OK but-cryptographically-bogus as :intermediate_sig_invalid" do
      chain =
        CertChain.encode(%CertChain{
          intermediate: %NestedCert{
            details: <<1, 2, 3>>,
            signature: :crypto.strong_rand_bytes(64)
          },
          leaf: %NestedCert{details: <<4, 5, 6>>, signature: :crypto.strong_rand_bytes(64)}
        })

      assert {:error, :intermediate_sig_invalid} =
               CertVerifier.verify(chain, server_static())
    end
  end

  defp server_static, do: :crypto.strong_rand_bytes(32)
end
