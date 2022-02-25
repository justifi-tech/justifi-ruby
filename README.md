# JustiFi Ruby

The JustiFi gem provides a simple way to access JustiFi API for apps written in Ruby language. 
It includes a pre-defined set of modules and classes that are essentially wrapped versions of our API resources.

## Installation

From the command line:
```bash
gem install justifi --version "0.2.0" --source "https://rubygems.pkg.github.com/justifi-tech"
```
OR

Add these lines to your application's Gemfile:

```ruby
source "https://rubygems.pkg.github.com/justifi-tech" do
  gem "justifi", "0.2.0"
end
```
And then execute:

    $ bundle install


## Usage

The gem needs to be configured with your `client_id` and `client_secret` in order to access JustiFi API resources.

Set `Justifi.client_id` and `Justifi.client_secret`:

```ruby
require 'justifi'

Justifi.client_id = 'live_13...'
Justifi.client_secret = 'live_TDYj_wdd...'
```

OR just use the `Justifi.setup` method to set all at once:


```ruby
require 'justifi'

# setup
Justifi.setup(client_id:     ENV["JUSTIFI_CLIENT_ID"],
              client_secret: ENV["JUSTIFI_CLIENT_SECRET"])
```


## Create Payment

There are two ways to create a payment:

1. Create with tokenized payment method:

```ruby
require 'justifi'

# gem setup...

payment_params = {
  amount: 1000,
  currency: "usd",
  capture_strategy: "automatic",
  email: "example@example.com",
  description: "Charging $10 on Example.com",
  payment_method: {
    token: "#{tokenized_payment_method_id}"
  }
}

Justifi::Payment.create(params: payment_params)
```

2. Create with full payment params:

```ruby
require 'justifi'

# gem setup...

payment_params = {
  amount: 1000,
  currency: "usd",
  capture_strategy: "automatic",
  email: "example@example.com",
  description: "Charging $10 on Example.com",
  payment_method: {
    card: {
      name: "JustiFi Tester",
      number: "4242424242424242",
      verification: "123",
      month: "3",
      year: "2040",
      address_postal_code: "55555"
    }
  }
}

Justifi::Payment.create(params: payment_params)
```

## Idempotency Key

You can use your own idempotency-key when creating payments.

```ruby
require 'justifi'

# gem setup...

payment_params = {
  amount: 1000,
  currency: "usd",
  capture_strategy: "automatic",
  email: "example@example.com",
  description: "Charging $10 on Example.com",
  payment_method: {
    card: {
      name: "JustiFi Tester",
      number: "4242424242424242",
      verification: "123",
      month: "3",
      year: "2040",
      address_postal_code: "55555"
    }
  }
}

Justifi::Payment.create(params: payment_params, idempotency_key: "my_idempotency_key")
```

IMPORTANT: The gem will generate an idempotency key in case you don't want to use your own.

## Create Payment Refund

In order to create a refund, you will need an amount, a payment_id ( `py_2aBBouk...` ).

```ruby
require 'justifi'

# gem setup...

payment_params = {
  amount: 1000,
  currency: "usd",
  capture_strategy: "automatic",
  email: "example@example.com",
  description: "Charging $10 on Example.com",
  payment_method: {
    card: {
      name: "JustiFi Tester",
      number: "4242424242424242",
      verification: "123",
      month: "3",
      year: "2040",
      address_postal_code: "55555"
    }
  }
}

payment_id = Justifi::Payment.create(params: payment_params).data[:id] # get the payment id
reason     = ['duplicate', 'fraudulent', 'customer_request'] # optional: one of these
amount     = 1000

Justifi::Payment.create_refund( amount: 1000, reason: reason, payment_id: payment_id )
```

## Listing Resources

All top-level API resources have support for bulk fetches via `array` API methods.
JustiFi uses cursor based pagination which supports `limit`, `before_cursor` and `after_cursor`.
Each response will have a `page_info` object that contains the `has_next` and `has_previous` fields,
which tells you if there are more items before or after the current page.
The `page_info` object also includes `start_cursor` and `end_cursor` values which can be used in 
conjuction with `before_cursor` and `after_cursor` to retrieve items from the api one page at a time.

### List PaymentMethods

```ruby
require 'justifi'

# gem setup...

pms = Justifi::PaymentMethod.list

# pagination with after_cursor

query_params = {
  limit: 15,
  after_cursor: pms.data[:page_info][:after_cursor],
}

payment_methods = Justifi::PaymentMethod.list(params: query_params)
```

### List Payments

```ruby
require 'justifi'

# gem setup...

payments = Justifi::Payment.list

# pagination with after_cursor

query_params = {
  limit: 15,
  after_cursor: payments.data[:page_info][:after_cursor],
}

payments = Justifi::Payment.list(params: query_params)
```

