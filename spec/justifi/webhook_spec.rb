# frozen_string_literal: true

RSpec.describe Justifi::Webhook do
  describe "#verify_signature" do
    let(:verify_signature) { subject.verify_signature(**args) }
    let(:args) do
      {
        received_event: received_event,
        signature: signature,
        secret_key: "sigk_59MIs5qN2tBrsNw6JzIXlU",
        timestamp: 1651070133
      }
    end
    let(:signature) { "eb9a2709ca0442d3603795571a07d1b75483a61f5318343bc9a060e3dad88f88" }
    let(:received_event) do
      {
        id: "evt_4vt3adCPYsyYmP64nQD6BD",
        account_id: "acc_55WeC3mKzXD9qgdyObSIQA",
        account_type: "test",
        platform_account_id: "acc_2ELCdFp1sPkOVo4h4DD0o7",
        idempotency_key: "dp-2841220e-1ef3-422a-a9c2-4281c49b5b72",
        request_id: "req_46ODW2j2rUeyw1w1bBbVNe",
        version: "v1",
        data: {
          id: "py_1xy1fjX7gPECfg6d5839iU",
          account_id: "acc_55WeC3mKzXD9qgdyObSIQA",
          amount_disputed: 0,
          amount_refunded: 0,
          amount: 1000,
          amount_refundable: 1000,
          balance: 0,
          capture_strategy: "automatic",
          captured: true,
          created_at: "2022-04-27T14:35:32.468Z",
          currency: "usd",
          description: "debatable v2",
          disputed: false,
          error_code: nil,
          error_description: nil,
          fee_amount: 0,
          is_test: true,
          metadata: nil,
          payment_intent_id: nil,
          refunded: false,
          status: "succeeded",
          updated_at: "2022-04-27T14:35:32.468Z",
          payment_method: {
            card: {
              id: "pm_1411kCQV3aO1Pd6quIyJTt",
              acct_last_four: "4242",
              brand: "visa",
              name: "Silva Fowles",
              token: "pm_1411kCQV3aO1Pd6quIyJTt",
              created_at: "2022-04-27T14:35:32.462Z",
              updated_at: "2022-04-27T14:35:32.462Z"
            }
          },
          application_fee: nil,
          disputes: []
        },
        event_name: "payment.created"
      }
    end

    context "with valid signature" do
      it { expect(verify_signature).to be_truthy }
    end

    context "with invalid signature" do
      let(:signature) { "wrong_signature" }
      it { expect(verify_signature).to be_falsey }
    end
  end
end
