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

		Airseed::OAuth.new(callback_url).login(provider)
		Airseed::UserAPI.new(acccess_token).users_info

## Contributing

1. Fork it ( https://github.com/[my-github-username]/airseed.rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
