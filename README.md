# Airseed.rb

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'airseed'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install airseed

## Usage

    Airseed.client_id = ENV['CLIENT_ID']
    Airseed.client_secret = ENV['CLIENT_SECRET']

    oauth = Airseed::OAuth.new(callback_url:'https://www.example.com/callback')
    oauth.login(provider: 'google_auth2')

    user_api = Airseed::UserAPI.new(acccess_token: 'a_access_token')
    user_profile = user_api.users_info(id: 'c2edddfaefe2c81a8696291c6fc5c97f6f75461b')
    user_products = user_api.endpoint(endpoint: 'product', id: 'c2edddfaefe2c81a8696291c6fc5c97f6f75461b')

## Contributing

1. Fork it ( https://github.com/[my-github-username]/airseed.rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
