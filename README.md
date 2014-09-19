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

		Airseed.base_api = 'https://api.airseed.com'
		Airseed.client_id = ENV['CLIENT_ID']
		Airseed.CLIENT_SECRET = ENV['CLIENT_SECRET']

		Airseed::Client.request(method, endpoint_path, endpoint_params, options)
		e.g. Airseed::Client.request(:get, 'users/v1/<user_id>', {}, :bearer_token => ENV['BEARER_TOKEN'])


## Contributing

1. Fork it ( https://github.com/[my-github-username]/airseed.rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
