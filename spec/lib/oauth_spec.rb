require 'spec_helper'


describe Airseed::OAuth, :vcr do
  Airseed.client_id = CONFIG['client_id']
  Airseed.client_secret = CONFIG['client_secret']

  subject(:oauth) { Airseed::OAuth.new(CONFIG['oauth_callback_url']) }

  describe 'login' do
    subject(:login) { oauth.login(CONFIG['provider']) }
    subject(:params) { URI.parse(login).query }

    it 'should return the ssl link' do
      expect(login).to_not be_nil
      expect(params).to include('client_id')
      expect(params).to include('provider')
      expect(params).to include('state')
    end
  end

  describe 'refresh_token' do
    subject(:response) { oauth.refresh_token(CONFIG['refresh_token']) }

    it 'returns the oauth refresh access token' do
      expect(response['access_token']).to_not be_nil
      expect(response['expires_in']).to_not be_nil
      if response['access_token'] != CONFIG['access_token']
        CONFIG['access_token'] = response['access_token']
      end
    end
  end
end
