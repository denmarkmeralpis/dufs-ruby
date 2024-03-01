# frozen_string_literal: true

require 'faraday'
require_relative 'helper/respondable'
require_relative 'apis/directories'
require_relative 'apis/files'
require_relative 'apis/lists'

module Dufs
  class Api
    def initialize(options = {})
      Faraday::Connection::METHODS.merge([:mkcol, :move])
      @user = options.fetch(:user, ENV['DUFS_USER'])
      @pass = options.fetch(:pass, ENV['DUFS_PASS'])
      @url = options.fetch(:url, ENV['DUFS_URL'])
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
      @connection ||= Faraday.new(url: @url) do |conn|
        conn.request :authorization, :basic, @user, @pass
      end
    end
  end
end
