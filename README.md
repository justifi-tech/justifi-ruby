# JustiFi Ruby

The JustiFi gem provides a simple way to access JustiFi API for apps written in Ruby language. 
It includes a pre-defined set of modules and classes that are essentially wrapped versions of our API resources.

## Installation

From the command line:
```bash
gem install justifi --version "0.1.4" --source "https://rubygems.pkg.github.com/justifi-tech"
```
OR

Add these lines to your application's Gemfile:

```ruby
source "https://rubygems.pkg.github.com/justifi-tech" do
  gem "justifi", "0.1.0"
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

Justifi::Payment.create(payment_params)
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
