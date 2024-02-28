# frozen_string_literal: true

require 'json'

module Dufs
  module Apis
    class Files
      include Helper::Respondable

      def initialize(connection)
        @connection = connection
      end

      def upload(path)
        response = @connection.put(path) do |req|
          req.body = File.read(path)
        end

        parse(response)
      end

      def download(path)
        response = @connection.get(path)
        return response if parse(response)
      end
    end
  end
end
