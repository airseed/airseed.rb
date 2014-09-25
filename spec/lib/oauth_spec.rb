require 'spec_helper'


describe Airseed::OAuth, :vcr do
  Airseed.client_id = ENV['CLIENT_ID']
  Airseed.client_secret = ENV['CLIENT_SECRET']

  let(:oauth_callback_url) { 'https://localhost:3000/callback' }

  subject(:oauth) { Airseed::OAuth.new(oauth_callback_url) }

  describe 'login' do
    let(:provider) { 'google_oauth2' }

    subject(:login) { oauth.login(provider) }
    subject(:params) { URI.parse(login).query }

    it 'should return the ssl link' do
      expect(login).to_not be_nil
      expect(params).to include('client_id')
      expect(params).to include('provider')
      expect(params).to include('state')
    end
  end

  describe 'refresh_token' do
    let(:refresh_token) { 'deadbeaf' }

    subject(:access_token) { oauth.refresh_token(refresh_token) }

    it 'returns the oauth refresh access token' do
      expect(access_token['access_token']).to_not be_nil
      expect(access_token['expires_in']).to_not be_nil
    end
  end
end
