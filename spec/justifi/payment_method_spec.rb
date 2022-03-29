# frozen_string_literal: true

RSpec.describe Justifi::PaymentMethod do
  before do
    Justifi.setup(client_id: ENV["CLIENT_ID"],
                  client_secret: ENV["CLIENT_SECRET"],
                  environment: ENV["ENVIRONMENT"])
    Stubs::OAuth.success_get_token
  end

  let(:token) { "pm_123xyz" }

  describe "list" do
    let(:params) { {limit: 15} }
    let(:list_payment_methods) { subject.send(:list, params: params) }
    let(:justifi_object) { list_payment_methods }

    context "with valid params" do
      before do
        Stubs::PaymentMethod.empty_list
      end

      it do
        expect(justifi_object).to be_a(Justifi::ListObject)
        expect(justifi_object.empty?).to be_truthy
      end
    end

    context "with next_page" do
      before do
        Stubs::PaymentMethod.success_list
      end

      let(:object) { justifi_object }
      let(:next_card_id) { "pm_1234xyz" }
      let(:next_page) { object.next_page }

      it do
        Stubs::PaymentMethod.success_list({after_cursor: object.end_cursor}, next_card_id)
        object.each do |payment_method|
          expect(payment_method[:card][:id]).not_to eq(next_card_id)
        end
        expect(next_page.data.first[:card][:id]).to eq(next_card_id)
      end
    end

    context "with previous_page" do
      before do
        Stubs::PaymentMethod.success_list
      end

      let(:object) { justifi_object }
      let(:card_id) { "pm_1234xyz" }
      let(:previous_page) { object.previous_page }

      it do
        Stubs::PaymentMethod.success_list({before_cursor: object.start_cursor}, card_id)
        expect(object.data.first[:card][:id]).not_to eq(previous_page.data.first[:card][:id])
      end
    end

    context "when next_page is empty" do
      before do
        Stubs::PaymentMethod.success_list
        allow_any_instance_of(Justifi::ListObject).to receive(:has_next).and_return(false)
      end

      let(:previous_data) { justifi_object }

      it do
        expect {
          previous_data.next_page
        }.not_to change(previous_data, :data)
      end
    end
  end

  describe "#get" do
    let(:get_payment_method) { subject.send(:get, token: token) }

    context "with valid params" do
      let(:justifi_object) { get_payment_method }

      before do
        Stubs::PaymentMethod.success_get(token)
      end

      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end

  describe "#update" do
    before do
      Stubs::PaymentMethod.success_update(card_params, token)
    end

    let(:updated_payment_method) { subject.send(:update, token: token, card_params: card_params) }
    let(:justifi_object) { updated_payment_method }

    let(:card_params) {
      {
        card: {
          month: 5,
          year: 2042,
          address_line1: "123 Fake St",
          address_line2: "Suite 101",
          address_city: "Cityville",
          address_state: "MN",
          address_postal_code: 55555,
          address_country: "US",
          metadata: {}
        }
      }
    }

    context "with valid params" do
      it do
        expect(justifi_object).to be_a(Justifi::JustifiObject)
        expect(justifi_object.raw_response.http_status).to eq(200)
      end
    end
  end
end
