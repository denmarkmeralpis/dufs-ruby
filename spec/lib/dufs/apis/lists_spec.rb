# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

module Dufs
  module Apis
    RSpec.describe Lists do
      let(:conn) do
        Faraday.new(url: 'http://127.0.0.1:5001') do |faraday|
          faraday.request :authorization, :basic, 'user', 'pass'
        end
      end

      subject do
        described_class.new(conn)
      end

      describe '#all' do
        before do
          stub_request(:get, 'http://127.0.0.1:5001/?json').to_return(
            status: 200, body: {}.to_json, headers: {
              'Content-Type': 'application/json'
            }
          )
        end

        it 'returns a hash' do
          expect(subject.all).to be_a(Hash)
        end
      end

      describe '#search' do
        before do
          stub_request(:get, 'http://127.0.0.1:5001/?json=true&q=keyword').to_return(
            status: 200, body: {}.to_json, headers: {
              'Content-Type': 'application/json'
            }
          )
        end

        it 'returns a hash' do
          expect(subject.search('keyword')).to be_a(Hash)
        end
      end
    end
  end
end
