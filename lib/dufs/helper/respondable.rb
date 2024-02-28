# frozen_string_literal: true

module Dufs
  module Helper
    module Respondable
      RESPONSES = {
        'Invalid Destination' => 'Dufs::InvalidDestination',
        'Not Found' => 'Dufs::FileOrDirNotFound',
        'Already exists' => 'Dufs::FileOrDirAlreadyExists'
      }.freeze

      def parse(response)
        if response.success?
          true
        else
          raise Unauthorized if response.status == 401
          raise exception(response.body), response.body
        end
      end

      private

      def exception(body)
        Object.const_get(RESPONSES[body] || 'Dufs::UnknownError')
      end
    end
  end
end
