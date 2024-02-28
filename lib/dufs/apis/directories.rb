# frozen_string_literal: true

module Dufs
  module Apis
    class Directories
      include Helper::Respondable

      def initialize(connection)
        @connection = connection
      end

      def create(path)
        response = @connection.run_request(:mkcol, path, nil, {})
        parse(response)
      end

      def delete(path)
        response = @connection.delete(path)
        parse(response)
      end

      def download(path)
        response = @connection.get(path) do |req|
          req.params['zip'] = true
        end

        return response.body if parse(response)
      end

      def move(origin, destination)
        response = @connection.run_request(
          :move, origin, nil, { 'Destination': "/#{destination}".gsub('//', '/') }
        )

        parse(response)
      end
    end
  end
end
