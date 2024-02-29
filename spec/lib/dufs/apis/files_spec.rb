# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

module Dufs
  module Apis
    RSpec.describe Files do
      let(:conn) do
        Faraday.new(url: 'http://127.0.0.1:5001') do |faraday|
          faraday.request :authorization, :basic, 'user', 'pass'
        end
      end

      subject do
        described_class.new(conn)
      end

      describe '#upload' do
        before do
          stub_request(:put, 'http://127.0.0.1:5001/dir/file.txt').to_return(
            status: 200, body: ''
          )
        end

        it 'returns true' do
          file = File.dirname(__FILE__) + '/../../../fixtures/file.txt'
          expect(subject.upload(file, 'dir/file.txt')).to eq(true)
        end
      end

      describe '#delete' do
        before do
          stub_request(:delete, 'http://127.0.0.1:5001/dir/file.txt').to_return(
            status: 200, body: ''
          )
        end

        it 'returns true' do
          expect(subject.delete('dir/file.txt')).to eq(true)
        end
      end

      describe '#dowload' do
        before do
          stub_request(:get, 'http://127.0.0.1:5001/dir/file.txt').to_return(
            status: 200, body: 'content-of-the-file'
          )
        end

        it 'returns content-of-the-file' do
          expect(subject.download('dir/file.txt')).to eq('content-of-the-file')
        end
      end
    end
  end
end
