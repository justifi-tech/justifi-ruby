module Stubs
  class SubAccount
    class << self
      def success_create(params)
        response_body = {
          "id" => "acc_5jrZ7fE7NrbWFMWHwc8mlk",
          "type" => "account",
          "page_info" => nil,
          "data" => {
            "id" => "acc_5jrZ7fE7NrbWFMWHwc8mlk",
            "account_type" => "test",
            "name" => "fake:account-name",
            "processing_ready" => false,
            "payout_ready" => false,
            "platform_account_id" => "acc_3FIbl3TIhTUBhXkwaTX59Z",
            "status" => "created",
            "currency" => "usd",
            "related_accounts" => {
              "live_account_id" => nil, "test_account_id" => "acc_5jrZ7fE7NrbWFMWHwc8mlk"
            },
            "created_at" => "2023-02-22T18:12:58.707Z",
            "updated_at" => "2023-02-22T18:12:58.707Z",
            "application_fee_rates" => [{
              "id" => "afr_39RUnuzvRD02imAHBZfGma",
              "transaction_fee" => 37,
              "currency" => "usd",
              "basis_point_rate" => 225,
              "rate_type" => "cc",
              "created_at" => "2023-02-22T18:12:58.678Z",
              "updated_at" => "2023-02-22T18:12:58.678Z"
            }, {
              "id" => "afr_3qezkv6MjjPfZuOnu4u8xz",
              "transaction_fee" => 75,
              "currency" => "usd",
              "basis_point_rate" => 45,
              "rate_type" => "ach",
              "created_at" => "2023-02-22T18:12:58.695Z",
              "updated_at" => "2023-02-22T18:12:58.695Z"
            }]
          }
        }.to_json

        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/sub_accounts")
          .with(body: params.to_json, headers: headers(params: params))
          .to_return(status: 201, body: response_body, headers: {})
      end

      def fail_create
        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/sub_accounts")
          .with(body: {}, headers: DEFAULT_HEADERS)
          .to_return(status: 404, body: "{}", headers: {})
      end

      def success_list
        response_body = {
          "id" => nil,
          "type" => "array",
          "page_info" => {
            "has_previous" => false,
            "has_next" => true,
            "start_cursor" => "WyJBQUFBIFNlbGxlciIsIjY0NWRlODVjLWJkYmEtNGYxNC1hZjM1LTcxNzUzYjQ3Yjc0MyJd",
            "end_cursor" => "WyJCQkJCQiBTZWxsZXIgYWNjb3VudCIsIjU1NGY2MmNkLWFkYjUtNGQxNy04NjkwLWNjOWMwYmM5MmE5MSJd"
          },
          "data" => [{
            "id" => "acc_33O9DIgIeS391LILHER1ff",
            "account_type" => "test",
            "name" => "AAAA Seller",
            "processing_ready" => false,
            "payout_ready" => false,
            "platform_account_id" => "acc_3FIbl3TIhTUBhXkwaTX59Z",
            "status" => "enabled",
            "currency" => "usd",
            "related_accounts" => {"live_account_id" => nil, "test_account_id" => "acc_33O9DIgIeS391LILHER1ff"},
            "created_at" => "2022-11-07T14:56:08.127Z",
            "updated_at" => "2022-11-07T14:56:16.605Z",
            "application_fee_rates" =>
              [{"id" => "afr_4PYXKatJ9SmYlgu0nzS5gi",
                "transaction_fee" => 99,
                "currency" => "usd",
                "basis_point_rate" => 300,
                "rate_type" => "cc",
                "created_at" => "2022-11-25T21:09:13.353Z",
                "updated_at" => "2022-11-25T21:09:13.353Z"},
                {"id" => "afr_4oKBL8P62G53iLbdRbd4nM",
                 "transaction_fee" => 95,
                 "currency" => "usd",
                 "basis_point_rate" => 70,
                 "rate_type" => "ach",
                 "created_at" => "2023-01-03T22:37:00.666Z",
                 "updated_at" => "2023-01-03T22:37:00.666Z"}]
          }, {
            "id" => "acc_2ayctF9eIbyw7ngrPTgp8r",
            "account_type" => "test",
            "name" => "BBBBB Seller account",
            "processing_ready" => false,
            "payout_ready" => false,
            "platform_account_id" => "acc_3FIbl3TIhTUBhXkwaTX59Z",
            "status" => "enabled",
            "currency" => "usd",
            "related_accounts" => {"live_account_id" => nil, "test_account_id" => "acc_2ayctF9eIbyw7ngrPTgp8r"},
            "created_at" => "2022-11-07T15:47:21.380Z",
            "updated_at" => "2022-11-07T15:47:29.491Z",
            "application_fee_rates" =>
              [{"id" => "afr_FwpFnf3OUDr29bWmbTHS7",
                "transaction_fee" => 50,
                "currency" => "usd",
                "basis_point_rate" => 300,
                "rate_type" => "cc",
                "created_at" => "2023-02-16T19:41:13.092Z",
                "updated_at" => "2023-02-16T19:41:13.092Z"},
                {"id" => "afr_2GrAERYu38VhRZfmrmhoII",
                 "transaction_fee" => 40,
                 "currency" => "usd",
                 "basis_point_rate" => 100,
                 "rate_type" => "ach",
                 "created_at" => "2023-02-16T19:41:34.780Z",
                 "updated_at" => "2023-02-16T19:41:34.780Z"}]
          }]
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/sub_accounts?limit=5")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_get(sub_account_id)
        response_body = {
          "id" => "acc_2FDS2gTHkibfz2opfYiweA",
          "type" => "account",
          "page_info" => nil,
          "data" => {
            "id" => "acc_2FDS2gTHkibfz2opfYiweA",
            "account_type" => "test",
            "name" => "Created from Ruby SDK",
            "processing_ready" => false,
            "payout_ready" => false,
            "platform_account_id" => "acc_3FIbl3TIhTUBhXkwaTX59Z",
            "status" => "enabled",
            "currency" => "usd",
            "related_accounts" => {"live_account_id" => nil, "test_account_id" => "acc_2FDS2gTHkibfz2opfYiweA"},
            "created_at" => "2023-02-22T17:54:10.840Z",
            "updated_at" => "2023-02-22T17:54:17.600Z",
            "application_fee_rates" => [
              {"id" => "afr_3fL3xJqCmVGMsX02Z7eP7h",
               "transaction_fee" => 37,
               "currency" => "usd",
               "basis_point_rate" => 225,
               "rate_type" => "cc",
               "created_at" => "2023-02-22T17:54:10.807Z",
               "updated_at" => "2023-02-22T17:54:10.807Z"},
              {"id" => "afr_5b6GwOqiDVDdONkoszmUvS",
               "transaction_fee" => 75,
               "currency" => "usd",
               "basis_point_rate" => 45,
               "rate_type" => "ach",
               "created_at" => "2023-02-22T17:54:10.827Z",
               "updated_at" => "2023-02-22T17:54:10.827Z"}
            ]
          }
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/sub_accounts/#{sub_account_id}")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end
    end
  end
end
