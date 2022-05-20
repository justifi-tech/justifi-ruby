module Stubs
  class BalanceTransaction
    class << self
      def success_get(balance_transaction_id)
        response_body = {
          id: "bt_7Q8gGG1tMFoFmO7fo9gQGH",
          type: "balance_transaction",
          data: {
            id: "bt_7Q8gGG1tMFoFmO7fo9gQGH",
            account_id: "acc_6YJ7EMKYcxePaEpicPfDgW",
            amount: 100,
            available_on: "2022-05-20T16:17:18.783Z",
            created_at: "2022-05-20T16:17:18.785Z",
            currency: "usd",
            description: "Ergonomic Iron Clock",
            fee: 53,
            financial_transaction_id: "3d49a2a6-1c31-4a58-aa26-51741770be46",
            net: 47,
            payout_id: nil,
            source_id: "py_2GWdO0FuMRAuZ3rjISYygx",
            source_type: "Payment",
            txn_type: "seller_payment",
            updated_at: "2022-05-20T16:17:18.785Z"
          },
          page_info: nil
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/balance_transactions/#{balance_transaction_id}")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_list
        response_body = {
          id: nil,
          type: "array",
          data: [
            {
              id: "bt_ZG9QBxBiFNhv9DtNoq2qp",
              account_id: "acc_7hEMrvhAExyiqwuK4YlknR",
              amount: 100,
              available_on: "2022-05-20T16:08:43.707Z",
              created_at: "2022-05-20T16:08:43.709Z",
              currency: "usd",
              description: nil,
              fee: 104,
              financial_transaction_id: "4c05f2bb-1ce1-427f-b599-a99ef6a51b9c",
              net: -4,
              payout_id: nil,
              source_id: "py_1jjKaF8HJCbYW2AjDQ0c49",
              source_type: "Payment",
              txn_type: "seller_payment",
              updated_at: "2022-05-20T16:08:43.709Z"
            }
          ],
          page_info: {
            has_previous: false,
            has_next: false,
            start_cursor: "WyIyMDIyLTA1LTIwIDE2OjA4OjQzLjcwOTM3MDAwMCIsIjEyYWZiMDYxLTJhY2EtNGYzNS1hYjNjLTliYzFhZWQ4NjNiMyJd",
            end_cursor: "WyIyMDIyLTA1LTIwIDE2OjA4OjQzLjcwOTM3MDAwMCIsIjEyYWZiMDYxLTJhY2EtNGYzNS1hYjNjLTliYzFhZWQ4NjNiMyJd"
          }
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/balance_transactions?limit=15")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end
    end
  end
end
