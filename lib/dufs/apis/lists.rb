# frozen_string_literal: true

require 'json'

module Dufs
  module Apis
    class Lists
      include Helper::Respondable

      def initialize(connection)
        @connection = connection
      end

      def all
        response = @connection.get('?json') do |req|
          req.headers['Content-Type'] = 'application/json'
        end

        JSON.parse(response.body) if parse(response)
      end

      def search(keyword)
        response = @connection.get do |req|
          req.headers['Content-Type'] = 'application/json'
          req.params['json'] = true
          req.params['q'] = keyword
        end

        JSON.parse(response.body) if parse(response)
      end
    end
  end
end
