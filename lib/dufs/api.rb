# frozen_string_literal: true

require 'faraday'
require_relative 'helper/respondable'
require_relative 'apis/directories'
require_relative 'apis/files'
require_relative 'apis/lists'

module Dufs
  class Api
    def initialize(user:, pass:, base_url:)
      Faraday::Connection::METHODS.merge([:mkcol, :move])
      @user = user
      @pass = pass
      @base_url = base_url
    end

    def authorized?
      return true if lists.search('test')
    rescue Dufs::Unauthorized
      false
    end

    def directories
      Dufs::Apis::Directories.new(connection)
    end

    def files
      Dufs::Apis::Files.new(connection)
    end

    def lists
      Dufs::Apis::Lists.new(connection)
    end

    private

    def connection
      @connection ||= Faraday.new(url: @base_url) do |conn|
        conn.request :basic_auth, @user, @pass
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
