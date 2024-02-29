# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

module Dufs
  module Apis
    RSpec.describe Directories do
      let(:conn) do
        Faraday.new(url: 'http://127.0.0.1:5001') do |faraday|
          faraday.request :authorization, :basic, 'user', 'pass'
        end
      end

      subject do
        described_class.new(conn)
      end

      describe '#create' do
        before do
          Faraday::Connection::METHODS.merge([:mkcol])
          stub_request(:mkcol, 'http://127.0.0.1:5001/rspec_dir').to_return(
            status: 200, body: ''
          )
        end

        it 'returns true' do
          expect(subject.create('rspec_dir')).to eq(true)
        end
      end

      describe '#delete' do
        before do
          stub_request(:delete, 'http://127.0.0.1:5001/path-to-file').to_return(
            status: 200, body: ''
          )
        end

        it 'returns true' do
          expect(subject.delete('path-to-file')).to eq(true)
        end
      end

      describe '#download' do
        before do
          stub_request(:delete, 'http://127.0.0.1:5001/?zip=true').to_return(
            status: 200, body: ''
          )

          it 'returns true' do
            expect(subject.download).to eq(true)
          end
        end
      end

      describe '#move' do
        before do
          Faraday::Connection::METHODS.merge([:move])
          stub_request(:delete, 'http://127.0.0.1:5001/origin-dir').to_return(
            status: 200, body: ''
          )

          it 'returns true' do
            expect(subject.move('origin-dir')).to eq(true)
          end
        end
      end
    end
  end
end
