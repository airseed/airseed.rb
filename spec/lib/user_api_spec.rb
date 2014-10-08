require 'spec_helper'

describe Airseed::UserAPI, :vcr do

  let(:api_object) { Airseed::UserAPI.new(CONFIG['access_token']) }

  describe 'users_info' do
    subject(:users_info) { api_object.users_info }

    it 'returns the user infos' do
      expect(users_info['email']).to eq 'airseed.test@gmail.com'
      expect(users_info['first_name']).to eq 'Airseed'
      expect(users_info['last_name']).to eq 'Test'
    end
  end

  describe 'users_data' do
    [
      'products', 'products/apparel', 'travel', 'travel/flights',
    ].each do |endpoint|
      it "should resolve to /users/:user_id/#{endpoint}" do
        users_data = api_object.users_data(endpoint)
        expect(has_keys(users_data, ["_links", "_embedded"])).to be(true)
        expect(has_keys(users_data['_links'], ["self", "next"])).to be(true)
        expect(has_keys(users_data['_embedded'], ["data"])).to be(true)
      end
    end
  end
end
