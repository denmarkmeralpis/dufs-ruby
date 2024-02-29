# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

module Dufs
  RSpec.describe Api do
    subject do
      described_class.new(
        user: 'user',
        pass: 'pass',
        url: 'http://127.0.0.1:5001'
      )
    end

    describe '#authorized?' do
      context 'when authorized' do
        before do
          mock = instance_double(Dufs::Apis::Lists)

          allow(Dufs::Apis::Lists).to receive(:new).and_return(mock)
          allow(mock).to receive(:search).and_return({})
        end

        it 'returns true' do
          expect(subject.authorized?).to eq(true)
        end
      end

      context 'when unathorized' do
        before do
          mock = instance_double(Dufs::Apis::Lists)

          allow(Dufs::Apis::Lists).to receive(:new).and_return(mock)
          allow(mock).to receive(:search).and_raise(Dufs::Unauthorized)
        end

        it 'returns false' do
          expect(subject.authorized?).to eq(false)
        end
      end
    end

    describe '#directories' do
      it 'returns an instance of Dufs::Apis::Directories' do
        expect(subject.directories).to be_an_instance_of(Dufs::Apis::Directories)
      end
    end

    describe '#directories' do
      it 'returns an instance of Dufs::Apis::Files' do
        expect(subject.files).to be_an_instance_of(Dufs::Apis::Files)
      end
    end

    describe '#files' do
      it 'returns an instance of Dufs::Apis::Files' do
        expect(subject.files).to be_an_instance_of(Dufs::Apis::Files)
      end
    end

    describe '#lists' do
      it 'returns an instance of Dufs::Apis::Lists' do
        expect(subject.lists).to be_an_instance_of(Dufs::Apis::Lists)
      end
    end
  end
end
