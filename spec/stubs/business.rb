module Stubs
  class Business
    class << self
      def success_create(params)
        response_body = {
          id: 1,
          type: "business",
          data: {
            id: "biz_xyz",
            platform_account_id: "acc_xyz",
            legal_name: "Business Name",
            website_url: "https://justifi.ai",
            email: "business@justifi.ai",
            phone: "6124011111",
            doing_business_as: "Best Business",
            business_type: "for_profit",
            business_structure: "sole_proprietorship",
            classification: "sole_proprietor",
            industry: "Big Business",
            mcc: "8021",
            tax_id: "string",
            date_of_incorporation: "2015-02-20",
            terms_conditions_accepted: false,
            metadata: {},
            legal_address: {
              id: "addr_123xyz",
              line1: "123 Example St",
              line2: "Suite 101",
              city: "Minneapolis",
              state: "MN",
              postal_code: "55555",
              country: "USA",
              created_at: "2021-01-01T12:00:00Z",
              updated_at: "2021-01-01T12:00:00Z"
            },
            representative: {
              id: "idty_xyz",
              platform_account_id: "acc_xyz",
              business_id: "biz_xyz",
              name: "Person Name",
              title: "President",
              email: "person.name@justifi.ai",
              phone: "6124011111",
              dob_day: "01",
              dob_month: "01",
              dob_year: "1980",
              ssn_last4: "6789",
              is_owner: true,
              metadata: {},
              address: {
                id: "addr_123xyz",
                line1: "123 Example St",
                line2: "Suite 101",
                city: "Minneapolis",
                state: "MN",
                postal_code: "55555",
                country: "USA",
                created_at: "2021-01-01T12:00:00Z",
                updated_at: "2021-01-01T12:00:00Z"
              },
              documents: [
                {
                  id: "doc_abc123",
                  description: "My Document",
                  file_name: "my_document",
                  file_type: "pdf",
                  document_type: "balance_sheet",
                  business_id: "biz_abc123",
                  identity_id: "idty_abc123",
                  presigned_url: "https://test.test/doc_abc123/file_name.pdf",
                  metadata: {
                    language: "english",
                    social_network: "@person"
                  },
                  status: "pending uploaded canceled",
                  created_at: "2021-01-01T12:00:00Z",
                  updated_at: "2021-01-01T12:00:00Z"
                }
              ],
              created_at: "2021-01-01T12:00:00Z",
              updated_at: "2021-01-01T12:00:00Z"
            },
            owners: [
              {
                id: "idty_xyz",
                platform_account_id: "acc_xyz",
                business_id: "biz_xyz",
                name: "Person Name",
                title: "President",
                email: "person.name@justifi.ai",
                phone: "6124011111",
                dob_day: "01",
                dob_month: "01",
                dob_year: "1980",
                ssn_last4: "6789",
                is_owner: true,
                metadata: {},
                address: {
                  id: "addr_123xyz",
                  line1: "123 Example St",
                  line2: "Suite 101",
                  city: "Minneapolis",
                  state: "MN",
                  postal_code: "55555",
                  country: "USA",
                  created_at: "2021-01-01T12:00:00Z",
                  updated_at: "2021-01-01T12:00:00Z"
                },
                documents: [
                  {
                    id: "doc_abc123",
                    description: "My Document",
                    file_name: "my_document",
                    file_type: "pdf",
                    document_type: "balance_sheet",
                    business_id: "biz_abc123",
                    identity_id: "idty_abc123",
                    presigned_url: "https://test.test/doc_abc123/file_name.pdf",
                    metadata: {
                      language: "english",
                      social_network: "@person"
                    },
                    status: "pending uploaded canceled",
                    created_at: "2021-01-01T12:00:00Z",
                    updated_at: "2021-01-01T12:00:00Z"
                  }
                ],
                created_at: "2021-01-01T12:00:00Z",
                updated_at: "2021-01-01T12:00:00Z"
              }
            ],
            documents: [
              {
                id: "doc_abc123",
                description: "My Document",
                file_name: "my_document",
                file_type: "pdf",
                document_type: "balance_sheet",
                business_id: "biz_abc123",
                identity_id: "idty_abc123",
                presigned_url: "https://test.test/doc_abc123/file_name.pdf",
                metadata: {
                  language: "english",
                  social_network: "@person"
                },
                status: "pending uploaded canceled",
                created_at: "2021-01-01T12:00:00Z",
                updated_at: "2021-01-01T12:00:00Z"
              }
            ],
            bank_accounts: [
              {
                id: "ba_123xyz",
                account_owner_name: "Napheesa Collier",
                account_type: "checking",
                acct_last_four: "6789",
                routing_number: "110000000",
                bank_name: "Wells Fargo",
                country: "US",
                currency: "usd",
                nickname: "Phee's money",
                metadata: {},
                business_id: "biz_123abc",
                platform_account_id: "acc_123abc",
                created_at: "2021-01-01T12:00:00Z",
                updated_at: "2021-01-01T12:00:00Z"
              }
            ],
            additional_questions: {
              business_revenue: "84220",
              business_payment_volume: "1000000",
              business_when_service_received: "Within 7 days",
              business_recurring_payments: "true",
              business_recurring_payments_percentage: "50% monthly, 50% annual",
              business_seasonal: "No. The business revenue is generated evenly throughout the year",
              business_other_payment_details: "50% of revenue is taken 90 days in advance of service and 50% of revenue is taken 30 days in advance of service",
              business_purchase_order_volume: "150",
              business_invoice_volume: "500",
              business_fund_use_intent: "expanding marketing efforts",
              equipment_invoice: "$10,000 invoice for computer equipment",
              business_invoice_number: "202105-001",
              business_invoice_amount: "$4500",
              business_purchase_order_number: "120",
              industry_code: "541512",
              duns_number: "123456789",
              business_payment_decline_volume: "500",
              business_refund_volume: "100",
              business_dispute_volume: "50",
              business_receivable_volume: "US $100,000",
              business_future_scheduled_payment_volume: "200",
              business_dispute_win_rate: "75%",
              length_of_business_relationship: "5 years"
            },
            created_at: "2021-01-01T12:00:00Z",
            updated_at: "2021-01-01T12:00:00Z"
          },
          page_info: "string"
        }.to_json

        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/entities/business")
          .with(body: params.to_json, headers: headers(params: params))
          .to_return(status: 201, body: response_body, headers: {})
      end

      def fail_create
        WebMock.stub_request(:post, "#{Justifi.api_url}/v1/entities/business")
          .with(body: {}, headers: DEFAULT_HEADERS)
          .to_return(status: 404, body: "{}", headers: {})
      end

      def success_list
        response_body = {
          id: 1,
          type: "array",
          data: [
            {}
          ],
          page_info: {
            end_cursor: "WyIyMDIyLTAyLTA4IDE5OjUyOjM3LjEwNDE3MzAwMCIsIjY4MDliYTU5LTYxYjctNDg3MS05YWFiLWE2Y2MyNmY3M2M1ZCJd",
            has_next: false,
            has_previous: false,
            start_cursor: "WyIyMDIyLTAyLTA4IDIwOjAxOjU4LjEyMDIzMjAwMCIsIjU5ZTFjNGI1LWFlOWQtNDIyZC04MTVkLWNjNzQ5NzdlYmFjYSJd"
          }
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/entities/business")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_get(business_id)
        response_body = {
          id: 1,
          type: "business",
          data: {
            id: "biz_xyz",
            platform_account_id: "acc_xyz",
            legal_name: "Business Name",
            website_url: "https://justifi.ai",
            email: "business@justifi.ai",
            phone: "6124011111",
            doing_business_as: "Best Business",
            business_type: "for_profit",
            business_structure: "sole_proprietorship",
            classification: "sole_proprietor",
            industry: "Big Business",
            mcc: "8021",
            tax_id: "string",
            date_of_incorporation: "2015-02-20",
            terms_conditions_accepted: false,
            metadata: {},
            legal_address: {},
            representative: {},
            owners: [],
            documents: [],
            bank_accounts: [],
            additional_questions: {},
            created_at: "2021-01-01T12:00:00Z",
            updated_at: "2021-01-01T12:00:00Z"
          },
          page_info: "string"
        }.to_json

        WebMock.stub_request(:get, "#{Justifi.api_url}/v1/entities/business/#{business_id}")
          .with(headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end

      def success_update(params, business_id)
        response_body = {
          id: 1,
          type: "business",
          data: {
            id: "biz_xyz",
            platform_account_id: "acc_xyz",
            legal_name: "New Business Name",
            website_url: "https://justifi.ai",
            email: "business@justifi.ai",
            phone: "6124011111",
            doing_business_as: "Best Business",
            business_type: "for_profit",
            business_structure: "sole_proprietorship",
            classification: "government limited non_profit partnership corporation public_company sole_proprietor",
            industry: "Big Business",
            mcc: "8021",
            tax_id: "string",
            date_of_incorporation: "2015-02-20",
            terms_conditions_accepted: false,
            metadata: {},
            legal_address: {
              id: "addr_123xyz",
              line1: "123 Example St",
              line2: "Suite 101",
              city: "Minneapolis",
              state: "MN",
              postal_code: "55555",
              country: "USA",
              created_at: "2021-01-01T12:00:00Z",
              updated_at: "2021-01-01T12:00:00Z"
            },
            representative: {
              id: "idty_xyz",
              platform_account_id: "acc_xyz",
              business_id: "biz_xyz",
              name: "Person Name",
              title: "President",
              email: "person.name@justifi.ai",
              phone: "6124011111",
              dob_day: "01",
              dob_month: "01",
              dob_year: "1980",
              ssn_last4: "6789",
              is_owner: true,
              metadata: {},
              address: {
                id: "addr_123xyz",
                line1: "123 Example St",
                line2: "Suite 101",
                city: "Minneapolis",
                state: "MN",
                postal_code: "55555",
                country: "USA",
                created_at: "2021-01-01T12:00:00Z",
                updated_at: "2021-01-01T12:00:00Z"
              },
              documents: [
                {
                  id: "doc_abc123",
                  description: "My Document",
                  file_name: "my_document",
                  file_type: "pdf",
                  document_type: "balance_sheet",
                  business_id: "biz_abc123",
                  identity_id: "idty_abc123",
                  presigned_url: "https://test.test/doc_abc123/file_name.pdf",
                  metadata: {
                    language: "english",
                    social_network: "@person"
                  },
                  status: "pending uploaded canceled",
                  created_at: "2021-01-01T12:00:00Z",
                  updated_at: "2021-01-01T12:00:00Z"
                }
              ],
              created_at: "2021-01-01T12:00:00Z",
              updated_at: "2021-01-01T12:00:00Z"
            },
            owners: [
              {
                id: "idty_xyz",
                platform_account_id: "acc_xyz",
                business_id: "biz_xyz",
                name: "Person Name",
                title: "President",
                email: "person.name@justifi.ai",
                phone: "6124011111",
                dob_day: "01",
                dob_month: "01",
                dob_year: "1980",
                ssn_last4: "6789",
                is_owner: true,
                metadata: {},
                address: {
                  id: "addr_123xyz",
                  line1: "123 Example St",
                  line2: "Suite 101",
                  city: "Minneapolis",
                  state: "MN",
                  postal_code: "55555",
                  country: "USA",
                  created_at: "2021-01-01T12:00:00Z",
                  updated_at: "2021-01-01T12:00:00Z"
                },
                documents: [
                  {
                    id: "doc_abc123",
                    description: "My Document",
                    file_name: "my_document",
                    file_type: "pdf",
                    document_type: "balance_sheet",
                    business_id: "biz_abc123",
                    identity_id: "idty_abc123",
                    presigned_url: "https://test.test/doc_abc123/file_name.pdf",
                    metadata: {
                      language: "english",
                      social_network: "@person"
                    },
                    status: "pending uploaded canceled",
                    created_at: "2021-01-01T12:00:00Z",
                    updated_at: "2021-01-01T12:00:00Z"
                  }
                ],
                created_at: "2021-01-01T12:00:00Z",
                updated_at: "2021-01-01T12:00:00Z"
              }
            ],
            documents: [
              {
                id: "doc_abc123",
                description: "My Document",
                file_name: "my_document",
                file_type: "pdf",
                document_type: "balance_sheet",
                business_id: "biz_abc123",
                identity_id: "idty_abc123",
                presigned_url: "https://test.test/doc_abc123/file_name.pdf",
                metadata: {
                  language: "english",
                  social_network: "@person"
                },
                status: "pending uploaded canceled",
                created_at: "2021-01-01T12:00:00Z",
                updated_at: "2021-01-01T12:00:00Z"
              }
            ],
            bank_accounts: [
              {
                id: "ba_123xyz",
                account_owner_name: "Napheesa Collier",
                account_type: "checking",
                acct_last_four: "6789",
                routing_number: "110000000",
                bank_name: "Wells Fargo",
                country: "US",
                currency: "usd",
                nickname: "Phee's money",
                metadata: {},
                business_id: "biz_123abc",
                platform_account_id: "acc_123abc",
                created_at: "2021-01-01T12:00:00Z",
                updated_at: "2021-01-01T12:00:00Z"
              }
            ],
            additional_questions: {
              business_revenue: "84220",
              business_payment_volume: "1000000",
              business_when_service_received: "Within 7 days",
              business_recurring_payments: "true",
              business_recurring_payments_percentage: "50% monthly, 50% annual",
              business_seasonal: "No. The business revenue is generated evenly throughout the year",
              business_other_payment_details: "50% of revenue is taken 90 days in advance of service and 50% of revenue is taken 30 days in advance of service",
              business_purchase_order_volume: "150",
              business_invoice_volume: "500",
              business_fund_use_intent: "expanding marketing efforts",
              equipment_invoice: "$10,000 invoice for computer equipment",
              business_invoice_number: "202105-001",
              business_invoice_amount: "$4500",
              business_purchase_order_number: "120",
              industry_code: "541512",
              duns_number: "123456789",
              business_payment_decline_volume: "500",
              business_refund_volume: "100",
              business_dispute_volume: "50",
              business_receivable_volume: "US $100,000",
              business_future_scheduled_payment_volume: "200",
              business_dispute_win_rate: "75%",
              length_of_business_relationship: "5 years"
            },
            created_at: "2021-01-01T12:00:00Z",
            updated_at: "2021-01-01T12:00:00Z"
          },
          page_info: "string"
        }.to_json

        WebMock.stub_request(:patch, "#{Justifi.api_url}/v1/entities/business/#{business_id}")
          .with(body: params.to_json, headers: DEFAULT_HEADERS)
          .to_return(status: 200, body: response_body, headers: {})
      end
    end
  end
end
