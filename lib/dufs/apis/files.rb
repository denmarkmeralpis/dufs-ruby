# frozen_string_literal: true

require 'json'

module Dufs
  module Apis
    class Files
      include Helper::Respondable

      def initialize(connection)
        @connection = connection
      end

      def upload(file, path)
        response = @connection.put(path) do |req|
          req.body = File.read(file)
        end

        parse(response)
      end

      def exists?(path)
        data = Dufs::Apis::Lists.new(@connection).search(File.basename(path))
        !data['paths'].empty?
      rescue Dufs::FileOrDirNotFound
        false
      end

      def delete(file)
        response = @connection.delete(file)
        parse(response)
      end

      def download(path)
        response = @connection.get(path)
        return response.body if parse(response)
      end
    end
  end
end
